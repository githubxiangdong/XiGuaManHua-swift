//
//  XGTabBarController.swift
//  XiGuaManHua
//
//  Created by zxd on 2021/3/28.
//

import UIKit

class XGTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置tabBar栏透明度为透明
        tabBar.isTranslucent = false
        
        // 首页
        addChildViewController(XGHomeViewController(),
                               title: "首页",
                               image: UIImage(named: "tab_home"),
                               selectedImage: UIImage(named: "tab_home_S"))
        
        // 分类
        addChildViewController(XGCategoryViewController(),
                               title: "分类",
                               image: UIImage(named: "tab_class"),
                               selectedImage: UIImage(named: "tab_class_S"))
        
        
        // 书架
        addChildViewController(XGBookViewController(),
                               title: "书架",
                               image: UIImage(named: "tab_book"),
                               selectedImage: UIImage(named: "tab_book_S"))
        
        // 我的
        addChildViewController(XGMineViewController(),
                               title: "我的",
                               image: UIImage(named: "tab_mine"),
                               selectedImage: UIImage(named: "tab_mine_S"))
    }
    
    // 添加子控制器
    func addChildViewController(_ childViewController: UIViewController,
                                title: String?,
                                image: UIImage?,
                                selectedImage: UIImage?) {
        
        childViewController.title = title
        childViewController.tabBarItem = UITabBarItem(title: nil,
                                                      image: image?.withRenderingMode(.alwaysOriginal),
                                                      selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            childViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
        
        addChild(XGNavigationController(rootViewController: childViewController))
    }
}
