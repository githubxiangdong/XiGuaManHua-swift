//
//  XGCommon.swift
//  XiGuaManHua
//
//  Created by zxd on 2021/3/29.
//

import UIKit
import SnapKit
import Kingfisher

// 数据请求接口
let kBaseUrl = "http://app.u17.com/v3/appV3_3/ios/phone"

// 是否是iphonex
let kIsIphoneX = UI_USER_INTERFACE_IDIOM() == .phone
    && (max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 812
    || max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 896)

// 状态栏高度
let kStatusBarHeight: CGFloat = kIsIphoneX ? 44.0 : 20
// 导航栏高度
let kNavigationBarHeight: CGFloat = 44
// tabBar的高度
let kTabBarHeight: CGFloat = kIsIphoneX ? (49.0 + 34.0) : 49.0

// 屏幕宽高
let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

// MARK:- 应用颜色
extension UIColor {
    // 计算属性
    // static 修饰的计算属性，是不能被继承的
    static var unselectdColor: UIColor {
        return UIColor(r: 230, g: 230, b: 230, a: 0.8)
    }
    
    static var theme: UIColor {
        return UIColor(r: 29, g: 221, b: 43)
    }
    
    static var background: UIColor {
        return UIColor(r: 242, g: 242, b: 242)
    }
    
    /*
     static：修饰的存储属性、计算属性、类方法，其中计算属性和类方法是无法继承的
     class：修饰计算属性、类方法，不能修饰存储属性
     
     注意点：在使用protocol、enum、struct时，使用static
     class中使用 class和static均可
     */
}
