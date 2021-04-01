//
//  XGNavigationController.swift
//  XiGuaManHua
//
//  Created by zxd on 2021/3/29.
//

import UIKit

enum XGNavigationBarStyle {
    case theme // 主题颜色
    case clear // 透明
    case white
}

class XGNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


//MARK:- UINavigationController 的扩展
extension UINavigationController {
    
    func barStyle(_ style: XGNavigationBarStyle) {
        switch style {
        case .theme:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIImage(named: "nav_bg"), for: .default)
            navigationBar.shadowImage = UIImage()
        case .clear:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        case .white:
            navigationBar.barStyle = .default
            navigationBar.setBackgroundImage(UIColor.white.image(), for: .default)
            navigationBar.shadowImage = nil
        }
    }
}


