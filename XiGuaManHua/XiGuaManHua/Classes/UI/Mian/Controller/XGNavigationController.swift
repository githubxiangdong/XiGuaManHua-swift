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
        //MARK:- 给pop添加全屏手势
        // 1, 获取系统的pop手势
        guard let systemGes = interactivePopGestureRecognizer else {return}
        // 2, 将获取的手势添加到view中的view
        guard let gestView = systemGes.view else {return}
        // 3, 获取target/action
        // 3.1 利用运行时机制，查看所有属性名称
        /*var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)
        for i in 0..<count {
            let ivar = ivars?[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }*/
        // 利用kvc取出属性
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else {return}
        
        // 3.2 取出target
        guard let target = targetObjc.value(forKey: "target") else {return}
        
        // 3.3 取出action
        let action = Selector(("handleNavigationTransition:"))
        
        // 4, 创建自己的pan手势
        let pan = UIPanGestureRecognizer()
        gestView.addGestureRecognizer(pan)
        pan.addTarget(target, action: action)
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 隐藏掉分栏控制器的tabbar
        // 此方法会在pop回来时直接显示，没有动画，效果不是很好
        // 所以就在自定义的navigation里面隐藏掉tabbar
        // tabBarController?.tabBar.isHidden = false
        if viewControllers.count > 0 { viewController.hidesBottomBarWhenPushed = true }
        super.pushViewController(viewController, animated: animated)
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


