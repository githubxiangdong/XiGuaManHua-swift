//
//  XGRecommendViewController.swift
//  XiGuaManHua
//
//  Created by zxd on 2021/3/30.
//

import UIKit

// MARK:- 定义常量
private let kItemMargin: CGFloat = 5
private let kItemW = (kScreenWidth - 3 * kItemMargin) / 2
private let kItemH = (kItemW * 3 / 4) + 35
private let kHeaderViewH: CGFloat = 44
private let kFooterViewH: CGFloat = 10

private let kNormalCellId = "kNormalCellId"
private let kHeaderViewId = "kHeaderViewId"
private let kFooterViewId = "kFooterViewId"

class XGRecommendViewController: UIViewController {
    // MARK:- 懒加载属性
    private lazy var comicList = [XGComicListsModel]()
    
    private lazy var collectionView: UICollectionView = {[unowned self] in
        /*
         [weak self] weak：弱引用
         [unowned self] unowned：无主引用
         
         使用场景：
         1. 如果捕获（比如 self）可以被设置为 nil，也就是说它可能在闭包前被销毁，那么就要将捕获定义为 weak；
         2. 如果它们一直是相互引用，即同时销毁的，那么就可以将捕获定义为 unowned。
         */
        
        // 1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin) // 设置组的内边距
        
        // 2. 创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(XGCollectionNormalCell.self, forCellWithReuseIdentifier: kNormalCellId)
        collectionView.register(XGCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewId)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: kFooterViewId)
        return collectionView
    }()
    
    
    // MARK:- 系统函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. 设置UI界面
        setupUI()
        
        // 2. 请求数据
        loadData()
    }
}


// MARK:- 设置UI界面
extension XGRecommendViewController {
    private func setupUI() {
        // 1. 将collectionView加入到控制器
        view.addSubview(collectionView)
    }
}


// MARK:- 请求数据
extension XGRecommendViewController {
    private func loadData() {
        XGRecommendRequest.requestRecommendData{ (comicList) in
            self.comicList = comicList
            self.collectionView.reloadData()
        }
    }
}


// MARK:- 遵循 UICollectionViewDataSource
extension XGRecommendViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return comicList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comicList[section].comicArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath) as! XGCollectionNormalCell
        let comicsModel = comicList[indexPath.section]
        cell.comicModel = comicsModel.comicArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewId, for: indexPath) as! XGCollectionHeaderView
            headerView.comicListModel = comicList[indexPath.section]
            return headerView
        } else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kFooterViewId, for: indexPath)
            footerView.backgroundColor = UIColor.background
            return footerView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let comicController = XGComicViewController()
        navigationController?.pushViewController(comicController, animated: true)
    }
}


// MARK:- 遵循 UICollectionViewDelegateFlowLayout
extension XGRecommendViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let comicListModel = comicList[section]
        //  ?? 空和并运算符
        return comicListModel.itemTitle?.count ?? 0 > 0 ? CGSize(width: kScreenWidth, height: kHeaderViewH) : CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return section != comicList.count - 1 ? CGSize(width: kScreenWidth, height: kFooterViewH) : CGSize.zero
    }
}
