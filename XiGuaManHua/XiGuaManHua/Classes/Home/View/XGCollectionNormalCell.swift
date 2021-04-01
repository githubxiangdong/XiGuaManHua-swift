//
//  XGCollectionNormalCell.swift
//  XiGuaManHua
//
//  Created by zxd on 2021/4/1.
//

import UIKit

class XGCollectionNormalCell: UICollectionViewCell {
    // MARK:- 懒加载属性
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "normal_placeholder_h"))
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "有妖气"
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 14.0)
        return titleLabel
    }()
    
    private lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.text = "我是描述文本"
        descLabel.textColor = UIColor.gray
        descLabel.font = UIFont.systemFont(ofSize: 12.0)
        return descLabel
    }()
    
    
    // MARK:- 系统方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK:- 设置UI
extension XGCollectionNormalCell {
    private func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descLabel)
        
        setupLayout()
    }
    
    private func setupLayout() {
        descLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(-15)
            make.left.equalTo(5)
            make.height.equalTo(20)
            make.right.equalTo(-5)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(descLabel.snp_top).offset(0)
            make.left.equalTo(5)
            make.height.equalTo(20)
            make.right.equalTo(-5)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(titleLabel.snp_top).offset(-5)
        }
    }
}
