//
//  XGCollectionHeaderView.swift
//  XiGuaManHua
//
//  Created by zxd on 2021/3/31.
//

import UIKit

class XGCollectionHeaderView: UICollectionReusableView {
    // MARK:- 懒加载属性
    private lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.image = UIImage(named: "normal_placeholder_v")
        return iconView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "有妖气"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 14.0)
        return titleLabel
    }()
    
    private lazy var moreButton: UIButton = {
        let moreButton = UIButton(type: .system)
        moreButton.setTitle("•••", for: .normal)
        moreButton.setTitleColor(UIColor.lightGray, for: .normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        moreButton.addTarget(self, action: #selector(onClickMore(_:)), for: .touchUpInside)
        return moreButton
    }()
    
    
    // MAKR:- 系统初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK:- 设置UI
extension XGCollectionHeaderView {
    private func setupUI() {
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(moreButton)
        
        setupLayout()
    }
    
    private func setupLayout() {
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp_right).offset(8)
            make.centerY.height.equalTo(iconView)
            make.width.equalTo(200)
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(40)
        }
    }
}


// MARK:- 更多事件监听
extension XGCollectionHeaderView {
    @objc private func onClickMore(_ btn: UIButton) {
        print("--------")
    }
}
