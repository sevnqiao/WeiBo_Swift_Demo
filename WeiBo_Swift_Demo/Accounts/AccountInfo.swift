//
//  AccountInfo.swift
//  WeiBo_Swift_Demo
//
//  Created by Xiong on 2017/9/6.
//  Copyright © 2017年 Xiong. All rights reserved.
//

import UIKit
import SwiftyJSON

class AccountInfo: NSObject, NSCoding {

    var access_token:String?
    var expires_in:String?
    var remind_in:String?
    var uid:String?
    var create_time:Date?
    var name:String?
    
    public class func accountWithDict(jsonString:String) -> AccountInfo{
        
        let json:JSON = JSON.init(parseJSON: jsonString)
        let accountInfo:AccountInfo = AccountInfo.init()
        
        accountInfo.access_token = json["access_token"].stringValue
        accountInfo.expires_in = json["expires_in"].stringValue
        accountInfo.remind_in = json["remind_in"].stringValue
        accountInfo.uid = json["uid"].stringValue
        accountInfo.create_time = Date()
        return accountInfo
    }
    
    
    func encode(with aCoder: NSCoder){
        
        aCoder.encode(self.access_token, forKey: "access_token")
        aCoder.encode(self.expires_in, forKey: "expires_in")
        aCoder.encode(self.remind_in, forKey: "remind_in")
        aCoder.encode(self.uid, forKey: "uid")
        aCoder.encode(self.create_time, forKey: "create_time")
        aCoder.encode(self.name, forKey: "name")
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()

        self.access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        self.expires_in = aDecoder.decodeObject(forKey: "expires_in") as? String
        self.remind_in = aDecoder.decodeObject(forKey: "remind_in") as? String
        self.uid = aDecoder.decodeObject(forKey: "uid") as? String
        self.create_time = aDecoder.decodeObject(forKey: "create_time") as? Date
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        
    }
    
    override init() {
        
    }
    
    
}
