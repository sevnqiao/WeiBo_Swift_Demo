//
//  AccountInfoTool.swift
//  WeiBo_Swift_Demo
//
//  Created by Xiong on 2017/9/6.
//  Copyright © 2017年 Xiong. All rights reserved.
//

// 账号的存储路径


import UIKit

class AccountInfoTool: NSObject {
    
    class func saveAccountInfo(accountInfo:AccountInfo) {
        
        UserDefaults.standard.set(accountInfo.access_token, forKey: "access_token")
        UserDefaults.standard.set(accountInfo.expires_in, forKey: "expires_in")
        UserDefaults.standard.set(accountInfo.remind_in, forKey: "remind_in")
        UserDefaults.standard.set(accountInfo.uid, forKey: "uid")
        UserDefaults.standard.set(accountInfo.create_time, forKey: "create_time")
        
    }
    
    class func accountInfo() -> AccountInfo? {
        
    
        let access_token:String? = UserDefaults.standard.object(forKey: "access_token") as? String
        if access_token == nil || (access_token?.isEmpty)! {
            return nil
        }
        
        let accountInfo:AccountInfo = AccountInfo()
        accountInfo.access_token = UserDefaults.standard.object(forKey: "access_token") as? String
        accountInfo.expires_in = UserDefaults.standard.object(forKey: "expires_in") as? String
        accountInfo.remind_in = UserDefaults.standard.object(forKey: "remind_in") as? String
        accountInfo.uid = UserDefaults.standard.object(forKey: "uid") as? String
        accountInfo.create_time = UserDefaults.standard.object(forKey: "create_time") as? Date
        
        let expire_in:TimeInterval = TimeInterval(accountInfo.expires_in!)!
        let expire_date:Date = Date.init(timeInterval: expire_in, since: accountInfo.create_time!)
        
        if expire_date.compare(Date()) == .orderedAscending {
            
            return nil
        }        
        
        return accountInfo
    }
    
    
    
    
}
