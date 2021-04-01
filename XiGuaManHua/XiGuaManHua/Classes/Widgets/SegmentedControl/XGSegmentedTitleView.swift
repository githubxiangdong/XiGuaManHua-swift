//
//  XGSegmentedTitleView.swift
//  XiGuaManHua
//
//  Created by zxd on 2021/3/29.
//

import UIKit

// MARK:- 定义协议
protocol XGSegmentedTitleViewDelegate: class { // class 表示这个协议只能被类遵守
    func segmentedTitleView(titleView: XGSegmentedTitleView, selectedIndex: Int)
}

// MARK:- 定义常量
private let kScrollLineH: CGFloat = 2.0
private let kNormalColor: (CGFloat, CGFloat, CGFloat, CGFloat) = (242, 242, 242, 0.6)
private let kSelectedColor: (CGFloat, CGFloat, CGFloat, CGFloat) = (255, 255, 255, 1.0)


class XGSegmentedTitleView: UIView {
    // MARK:- 对外属性
    public var isShowBottomLine: Bool // 默认是NO 不展示
    public weak var delegate: XGSegmentedTitleViewDelegate?
    
    // MARK:- 自定义属性
    private var titles : [String]
    private var currentIndex: Int = 0 // 当前的下标值
    
    // MARK:- 懒加载属性
    private lazy var titleLabels: [UILabel] = [UILabel]()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        return scrollLine
    }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        isShowBottomLine = false
        
        super.init(frame: frame)
        
        // 设置UI界面
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK:- 设置UI界面
extension XGSegmentedTitleView {
    private func setupUI() {
        // 1. 添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2. 添加对应的titles
        setupTitleLabels()
        
        // 3. 设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLabels() {
        
        // 0.确定label的一些值
        let labelW: CGFloat = bounds.width / CGFloat(titles.count)
        let labelH: CGFloat = bounds.height - kScrollLineH
        let labelY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            // 1. 创建label
            let label = UILabel()
            
            // 2. 设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = UIColor(r: kNormalColor.0,
                                      g: kNormalColor.1,
                                      b: kNormalColor.2,
                                      a: kNormalColor.3)
            label.textAlignment = .center
            
            // 3. 设置label frame
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4. 将label添加到scrollView中
            scrollView.addSubview(label)
            
            // 5. 添加label到数组
            titleLabels.append(label)
            
            // 6. 给label添加手势
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onTitleLabelClick(_:)))
            label.addGestureRecognizer(tapGesture)
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        // 1. 添加底线
        if isShowBottomLine {
            let bottomLine = UIView()
            bottomLine.backgroundColor = UIColor.lightGray
            let lineH: CGFloat = 0.5
            bottomLine.frame = CGRect(x: 0, y: bounds.height - lineH, width: bounds.width, height: lineH)
            addSubview(bottomLine)
        }
        
        // 2. 添加scrollLine
        // 2.1 获取第一个label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectedColor.0,
                                       g: kSelectedColor.1,
                                       b: kSelectedColor.2,
                                       a: kSelectedColor.3)
        
        // 2.2 设置scrollView的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}


// MARK:- 监听label的事件点击
extension XGSegmentedTitleView {
    @objc private func onTitleLabelClick(_ tap: UIGestureRecognizer) {
        // 0. 获取当前label的下标值
        guard let currentLabel = tap.view as? UILabel else { return }
        
        // 1. 判断是否是点击了已经选中的title
        if currentLabel.tag == currentIndex { return }
        
        // 2. 获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        // 3. 切换文字的颜色
        currentLabel.textColor = UIColor(r: kSelectedColor.0,
                                         g: kSelectedColor.1,
                                         b: kSelectedColor.2,
                                         a: kSelectedColor.3)
        oldLabel.textColor = UIColor(r: kNormalColor.0,
                                     g: kNormalColor.1,
                                     b: kNormalColor.2,
                                     a: kNormalColor.3)
        
        // 4. 保存最新label的下标值
        currentIndex = currentLabel.tag
        
        // 5. 滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.bounds.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 6. 通知delegate
        delegate?.segmentedTitleView(titleView: self, selectedIndex: currentIndex)
    }
}


// MARK:- 对外暴露的方法
extension XGSegmentedTitleView {
    public func setTitleProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        // 1. 取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2. 处理滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 3. 颜色的渐变
        // 3.1 取出变化的范围
        let colorDelta = (kSelectedColor.0 - kNormalColor.0,
                          kSelectedColor.1 - kNormalColor.1,
                          kSelectedColor.2 - kNormalColor.2,
                          kSelectedColor.3 - kNormalColor.3)
        
        // 3.2 变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * progress,
                                        g: kSelectedColor.1 - colorDelta.1 * progress,
                                        b: kSelectedColor.2 - colorDelta.2 * progress,
                                        a: kSelectedColor.3 - colorDelta.3 * progress)
        
        // 3.3 变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress,
                                        g: kNormalColor.1 + colorDelta.1 * progress,
                                        b: kNormalColor.2 + colorDelta.2 * progress,
                                        a: kNormalColor.3 + colorDelta.3 * progress)
        
        // 4. 记录最新的index
        currentIndex = targetIndex
    }
}
