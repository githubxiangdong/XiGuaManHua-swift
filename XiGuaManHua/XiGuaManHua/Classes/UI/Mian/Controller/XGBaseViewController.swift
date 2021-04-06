//
//  XGBaseViewController.swift
//  XiGuaManHua
//
//  Created by zxd on 2021/3/29.
//

import UIKit

class XGBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    func setupUI() { }
    
    func setupNavigationBar() {
        guard let navigation = navigationController else { return }
        if navigation.visibleViewController == self {
            navigation.barStyle(.theme)
            navigation.setNavigationBarHidden(false, animated: true)
            // 只有在二级以上界面才会出现返回按钮
            if navigation.viewControllers.count > 1 {
                navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back_white")?.withRenderingMode(.alwaysOriginal),
                                                                   style: .plain,
                                                                   target: self,
                                                                   action: #selector(onBack))
            }
        }
    }
}


// MARK:- 返回事件监听
extension XGBaseViewController {
    @objc private func onBack() {
        navigationController?.popViewController(animated: true)
    }
}
