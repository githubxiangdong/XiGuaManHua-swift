//
//  XGSegmentedPageView.swift
//  XiGuaManHua
//
//  Created by zxd on 2021/3/29.
//

import UIKit

// MARK:- 定义协议
protocol XGSegmentedPageViewDelegate: class {
    func segmentedPageView(pageView: XGSegmentedPageView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

// MARK:- 定义常量
private let pageCellId = "pageCellId"


class XGSegmentedPageView: UIView {
    // MARK:- 定义对外属性
    public weak var delegate: XGSegmentedPageViewDelegate?
    
    // MARK:- 定义私有属性
    private var childVCs: [UIViewController]
    private weak var parentViewController: UIViewController? // weak 解决循环引用
    private var startOffestX: CGFloat = 0
    private var isForbidScrollDelegate: Bool = false // 是否禁止滚动代理
    
    // MARK:- 懒加载属性
    private lazy var collectionView: UICollectionView = {[weak self] in  // [weak self] in  决绝闭包的循环引用
        // 1. 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2. 创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: pageCellId)
        return collectionView
    }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, childVCs: [UIViewController], parentViewController: UIViewController?) {
        self.childVCs = childVCs
        self.parentViewController = parentViewController
    
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK:- 设置UI界面
extension XGSegmentedPageView {
    private func setupUI() {
        // 1. 将所有的子控制器添加到父控制器中
        for childVC in childVCs {
            parentViewController?.addChild(childVC)
        }
        
        // 2. 添加一个UICollectionView，用于存放控制器中的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}


// MARK:- 遵守 UICollectionViewDataSource
extension XGSegmentedPageView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1. 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pageCellId, for: indexPath)
        
        // 2. 给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}


// MARK:- 遵守 UICollectionViewDelegate
extension XGSegmentedPageView: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 一旦拖动界面，就要解禁
        isForbidScrollDelegate = false
        
        startOffestX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0. 判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        // 1. 定义需要获取的数据
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        // 2. 判断是左滑还是右滑
        let currentOffestX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        let ratio = currentOffestX / scrollViewW // 计算出当前偏移量的占scrollView宽度的比例
        
        if currentOffestX > startOffestX { // 表示左滑
            // 1. 计算progress
            progress = ratio - floor(ratio)
            
            // 2. 计算sourceIndex
            sourceIndex = Int(ratio)
            
            // 3. 计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count { // 做边界检测
                targetIndex = childVCs.count - 1
            }
            
            // 4. 判断是否是完全滑过去了
            if progress == 0 {
                progress = 1
                targetIndex = sourceIndex
            }
        } else { // 右滑
            // 1. 计算progress
            progress = 1 - (ratio - floor(ratio))
            
            // 2. 计算targetIndex
            targetIndex = Int(ratio)
            
            // 3. 计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
            
            // 4. 判断是否是完全滑过去了
            if progress == 1 {
                sourceIndex = targetIndex
            }
        }
        
        // 3. 将progress/sourceIndex/targetIndex传递到 titileView
//        print("progress:\(progress) - sourceIndex:\(sourceIndex) - targetIndex:\(targetIndex)")
        delegate?.segmentedPageView(pageView: self,
                                    progress: progress,
                                    sourceIndex: sourceIndex,
                                    targetIndex: targetIndex)
    }
}


// MARK:- 对外暴露的方法
extension XGSegmentedPageView {
    public func setCurrentIndex(currentIndex: Int) {
        // 1. 如果是titleView点击事件，触发需要scrollView滚动的，是不需要触发滚动代理的
        isForbidScrollDelegate = true
        
        // 2. 滚动到具体的位置
        let offsetX = CGFloat(currentIndex) * collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
