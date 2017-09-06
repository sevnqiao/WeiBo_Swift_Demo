//
//  BaseTabBarController.swift
//  SaleHouse_Swift
//
//  Created by Xiong on 2017/9/6.
//  Copyright © 2017年 Xiong. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        
        
        self.initChildCiewController()
        
        
        
        let tabBar:TabBar = TabBar.init()
        self.setValue(tabBar, forKey: "tabBar")
        
    }
    
    func initChildCiewController() {
        
        let homeVC = HomeViewController.init()
        let messageVC = MessageViewController.init()
        let discoverVC = DiscoverViewController.init()
        let myVC = MineViewController.init()

        self.initConfig(vc: homeVC, title: "首页", iconImage: "tabbar_home", selectIconImage: "tabbar_home_selected")
        self.initConfig(vc: messageVC, title: "消息", iconImage: "tabbar_message_center", selectIconImage: "tabbar_message_center_selected")
        self.initConfig(vc: discoverVC, title: "发现", iconImage: "tabbar_discover", selectIconImage: "tabbar_discover_selected")
        self.initConfig(vc: myVC, title: "我的", iconImage: "tabbar_profile", selectIconImage: "tabbar_profile_selected")
    }
    
    
    func initConfig(vc:BaseViewController, title:String, iconImage:String, selectIconImage:String) {
        
        vc.title = title
        vc.tabBarItem.image = UIImage(named: iconImage)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: selectIconImage)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange], for: UIControlState.selected)
        
        let nav:BaseNavigationController = BaseNavigationController.init(rootViewController:vc)
        self.addChildViewController(nav)
    }
    
}
