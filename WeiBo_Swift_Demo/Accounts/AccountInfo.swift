//
//  AccountInfo.swift
//  WeiBo_Swift_Demo
//
//  Created by Xiong on 2017/9/6.
//  Copyright © 2017年 Xiong. All rights reserved.
//

import UIKit
import HandyJSON

class AccountInfo: HandyJSON {

    var access_token:String?
    var expires_in:String?
    var remind_in:String?
    var uid:String?
    var create_time:Date?
    var name:String?

    
    required init() {
        
    }
    
    
}
