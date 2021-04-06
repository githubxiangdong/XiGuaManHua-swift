//
//  XGComicViewController.swift
//  XiGuaManHua
//
//  Created by zxd on 2021/4/5.
//

import UIKit

private let kTitleViewHeight: CGFloat = 40
private let kHeaderViewHeight: CGFloat = 150

class XGComicViewController: XGBaseViewController {
    // MARK:- 懒加载属性
    private lazy var mainScrollView: UIScrollView = {[unowned self] in
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: kScreenWidth, height: kScreenHeight + kHeaderViewHeight - kStatusAndNavigationBarH)
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var headerView: UIView = {
        let header = UIView(frame: CGRect(x: 0, y: -kStatusAndNavigationBarH, width: kScreenWidth, height: kHeaderViewHeight + kStatusAndNavigationBarH))
        header.backgroundColor = UIColor.lightGray
        return header
    }()
    
    private lazy var contentView: UIView = {
        let contentFrame = CGRect(x: 0, y: kHeaderViewHeight, width: kScreenWidth, height: kScreenHeight - kHeaderViewHeight - kStatusAndNavigationBarH)
        let contentView = UIView(frame: contentFrame)
        return contentView
    }()
    
    private lazy var segmendtedTitleView: XGSegmentedTitleView = {
        let titleFrame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kTitleViewHeight)
        let titles = ["详情", "章节", "评论"]
        let titleView = XGSegmentedTitleView(frame: titleFrame,
                                             titles: titles,
                                             normalColor: (0, 0, 0, 1),
                                             selectedColor: (29, 221, 43, 1),
                                             size: 18,
                                             isShowBottomLine: true)
        titleView.backgroundColor = UIColor.background
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var segmendtedPageView: XGSegmentedPageView = {[weak self] in
        // 1. 确定page的frame
        let pageFrmae = CGRect(x: 0, y: kTitleViewHeight, width: kScreenWidth, height: kScreenHeight - kTitleViewHeight - kStatusAndNavigationBarH)
        
        // 2. 确定所有的子控制器
        var childVCs = [UIViewController]()
        childVCs.append(XGDetailViewController())
        childVCs.append(XGChapterViewController())
        childVCs.append(XGCommentViewController())
        let pageView = XGSegmentedPageView(frame: pageFrmae, childVCs: childVCs, parentViewController: self)
        pageView.delegate = self
        return pageView
    }()
    
    // MARK:- 系统函数
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    // MARK:- 重写父类方法
    override func setupUI() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(headerView)
        mainScrollView.addSubview(contentView)
        contentView.addSubview(segmendtedTitleView)
        contentView.addSubview(segmendtedPageView)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationController?.barStyle(.clear)
    }
}


// MARK:- 遵守 XGSegmentedTitleViewDelegate
extension XGComicViewController: XGSegmentedTitleViewDelegate {
    func segmentedTitleView(titleView: XGSegmentedTitleView, selectedIndex: Int) {
        segmendtedPageView.setCurrentIndex(currentIndex: selectedIndex)
    }
}


// MARK:- 遵守
extension XGComicViewController: XGSegmentedPageViewDelegate {
    func segmentedPageView(pageView: XGSegmentedPageView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        segmendtedTitleView.setTitleProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


// MARK:- 遵守 UIScrollViewDelegate
extension XGComicViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        if scrollView.contentOffset.y - 20 > kStatusAndNavigationBarH {
            navigationController?.barStyle(.theme)
        }else {
            navigationController?.barStyle(.clear)
        }
    }
}
