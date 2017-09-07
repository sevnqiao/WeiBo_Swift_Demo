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
        
        let AccountPath:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!.appending("/account.archiver")
        
        NSKeyedArchiver.archiveRootObject(accountInfo, toFile: AccountPath)
    }
    
    class func accountInfo() -> AccountInfo? {
        
        let AccountPath:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!.appending("/account.archiver")
        
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: AccountPath) == false {
            
            return nil
        }
        
        let accountInfo:AccountInfo = NSKeyedUnarchiver.unarchiveObject(withFile: AccountPath) as! AccountInfo
        
        let expire_in:TimeInterval = TimeInterval(accountInfo.expires_in!)!
        let expire_date:Date = Date.init(timeInterval: expire_in, since: accountInfo.create_time!)
        
        if expire_date.compare(Date()) == .orderedAscending {
            
            return nil
        }        
        
        return accountInfo
    }
    
    
    
    
}
