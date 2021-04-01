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
    
    private func setupNavigationBar() {
        guard let navigation = navigationController else { return }
        
        if navigation.visibleViewController == self {
            navigation.barStyle(.theme)
        }
    }
}


extension XGBaseViewController {
    
}
