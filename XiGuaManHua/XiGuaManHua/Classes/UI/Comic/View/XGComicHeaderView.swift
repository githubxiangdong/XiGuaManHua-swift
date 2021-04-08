//
//  XGComicHeaderView.swift
//  XiGuaManHua
//
//  Created by zxd on 2021/4/6.
//

import UIKit

class XGComicHeaderView: UIView {
    // MARK:- 懒加载属性
    private lazy var blurView: UIVisualEffectView = {
        // 1. 创建一个模糊效果blur
        let blur = UIBlurEffect(style: .dark)
        // 2. 创建blurView
        let blurView = UIVisualEffectView(effect: blur)
        return blurView
    }()
    
    private lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView(image: UIImage(named: "test_image"))
        bgImageView.contentMode = .scaleToFill
        bgImageView.clipsToBounds = true
        return bgImageView
    }()
    
    private lazy var coverImageView: UIImageView = {
        let cover = UIImageView(image: UIImage(named: "test_image"))
        cover.contentMode = .scaleToFill
        cover.clipsToBounds = true
        cover.layer.cornerRadius = 3
        cover.layer.borderWidth = 1
        cover.layer.borderColor = UIColor.white.cgColor
        return cover
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "有妖气"
        title.textColor = UIColor.white
        title.font = UIFont.systemFont(ofSize: 16)
        return title
    }()
    
    private lazy var authorLabel: UILabel = {
        let author = UILabel()
        author.text = "小妖女"
        author.textColor = UIColor.white
        author.font = UIFont.systemFont(ofSize: 14)
        return author
    }()
    
    private lazy var typeLabel: UILabel = {
        let type = UILabel()
        type.text = "少年/魔幻/科幻"
        type.textColor = UIColor.white
        type.font = UIFont.systemFont(ofSize: 14)
        return type
    }()
    
    private lazy var numbersLabel: UILabel = {
        let numbers = UILabel()
        numbers.textColor = UIColor.white
        numbers.attributedText = attributedText(clickNumbers: "0", favoriteNumbers: "0")
        numbers.font = UIFont.systemFont(ofSize: 15)
        return numbers
    }()
    
    
    // MARK:- 系统初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK:- 设置UI
extension XGComicHeaderView {
    private func setupUI() {
        addSubview(bgImageView)
        bgImageView.addSubview(blurView)
        bgImageView.addSubview(coverImageView)
        bgImageView.addSubview(titleLabel)
        bgImageView.addSubview(authorLabel)
        bgImageView.addSubview(typeLabel)
        bgImageView.addSubview(numbersLabel)
    }
    
    private func setupLayout() {
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        blurView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        coverImageView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.bottom.equalTo(-20)
            make.width.equalTo(90)
            make.height.equalTo(120)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(coverImageView)
            make.left.equalTo(coverImageView.snp_right).offset(20)
            make.height.equalTo(20)
            make.right.equalTo(-20)
        }
        
        authorLabel.snp.makeConstraints { (make) in
            make.left.height.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(10)
        }
        
        typeLabel.snp.makeConstraints { (make) in
            make.left.height.right.equalTo(titleLabel)
            make.top.equalTo(authorLabel.snp_bottom).offset(15)
        }
        
        numbersLabel.snp.makeConstraints { (make) in
            make.left.height.right.equalTo(titleLabel)
            make.bottom.equalTo(coverImageView)
        }
    }
}


// MARK:- 内部方法
extension XGComicHeaderView {
    private func attributedText(clickNumbers: String?, favoriteNumbers: String?) -> NSMutableAttributedString {
        let text = NSMutableAttributedString(string: "点击 收藏")
        
        text.insert(NSAttributedString(string: " \(clickNumbers ?? "0") ",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]), at: 2)
        
        text.append(NSAttributedString(string: " \(favoriteNumbers ?? "0") ",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
        
        return text
    }
}
