//
//  XGHomeViewController.swift
//  XiGuaManHua
//
//  Created by zxd on 2021/3/28.
//

import UIKit

private let kTitleViewHeight: CGFloat = 40
private let kTitleViewSpace: CGFloat = 60

class XGHomeViewController: XGBaseViewController {
    // MARK:- 懒加载属性
    private lazy var segmendtedTitleView: XGSegmentedTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: 0, width: kScreenWidth - 2 * kTitleViewSpace, height: kTitleViewHeight)
        let titles = ["推荐", "VIP", "订阅", "排行"]
        let titleView = XGSegmentedTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var segmendtedPageView: XGSegmentedPageView = {[weak self] in
        // 1. 确定page的frame
        let pageFrmae = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight)
        
        // 2. 确定所有的子控制器
        var childVCs = [UIViewController]()
        childVCs.append(XGRecommendViewController())
        childVCs.append(XGVIPViewController())
        childVCs.append(XGSubscribeViewController())
        childVCs.append(XGRankViewController())
        let pageView = XGSegmentedPageView(frame: pageFrmae, childVCs: childVCs, parentViewController: self)
        pageView.delegate = self
        return pageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        // 1. 添加titleView
        navigationItem.titleView = self.segmendtedTitleView
        
        // 2. 添加pageView
        view.addSubview(self.segmendtedPageView)
    }
}


// MARK:- 遵守 XGSegmentedTitleDelegate
extension XGHomeViewController: XGSegmentedTitleViewDelegate {
    func segmentedTitleView(titleView: XGSegmentedTitleView, selectedIndex: Int) {
        segmendtedPageView.setCurrentIndex(currentIndex: selectedIndex)
    }
}


// MARK:- 遵守 XGSegmentedPageViewDelegate
extension XGHomeViewController: XGSegmentedPageViewDelegate {
    func segmentedPageView(pageView: XGSegmentedPageView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        segmendtedTitleView.setTitleProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
