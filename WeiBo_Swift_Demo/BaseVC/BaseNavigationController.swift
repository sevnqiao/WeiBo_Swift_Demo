//
//  BaseNavigationController.swift
//  SaleHouse_Swift
//
//  Created by Xiong on 2017/9/6.
//  Copyright © 2017年 Xiong. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        
        self.interactivePopGestureRecognizer?.delegate = self
        
    }

    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            
            viewController.navigationController?.navigationBar.alpha = 1
            viewController.hidesBottomBarWhenPushed = true
        }
        super .pushViewController(viewController, animated: animated)
    }
    
}
