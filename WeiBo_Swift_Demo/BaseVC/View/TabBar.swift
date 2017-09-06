//
//  TabBar.swift
//  SaleHouse_Swift
//
//  Created by Xiong on 2017/9/6.
//  Copyright © 2017年 Xiong. All rights reserved.
//

import UIKit

class TabBar: UITabBar {
    
    var plusBtn:UIButton?
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        plusBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.size.width/5.0, height: 50))
        plusBtn?.setImage(UIImage.init(named: "tabbar_compose_icon_add"), for: UIControlState.normal)
        plusBtn?.setImage(UIImage.init(named: "tabbar_compose_icon_add_highlighted"), for: UIControlState.highlighted)
        plusBtn?.setBackgroundImage(UIImage.init(named: "tabbar_compose_button"), for: UIControlState.normal)
        plusBtn?.setBackgroundImage(UIImage.init(named: "tabbar_compose_button_highlighted"), for: UIControlState.highlighted)
        
        
        plusBtn?.addTarget(self, action: #selector(clickPlusBtn), for: UIControlEvents.touchUpInside)
        self.addSubview(plusBtn!)
        
    }
    
    
    
    
    func clickPlusBtn() {
        
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        plusBtn?.center = CGPoint.init(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        
        let width:Float = Float(self.bounds.size.width/5.0)
        var index:Float = 0
        
        let className:AnyClass = NSClassFromString("UITabBarButton")!
        for view in self.subviews {
            
            if view.isKind(of: className) {
                
                view.frame = CGRect.init(x: CGFloat(index * width), y: view.frame.origin.y, width: CGFloat(width), height: view.frame.size.height)
                
                index += 1;
                
                if index == 2 {
                    
                    plusBtn?.frame = CGRect.init(x: CGFloat(index * width), y: view.frame.origin.y, width: CGFloat(width), height: view.frame.size.height)
                    index += 1
                }
            }
        }
    }
}
