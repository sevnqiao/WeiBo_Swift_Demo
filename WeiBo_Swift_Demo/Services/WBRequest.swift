//
//  WBRequest.swift
//  WeiBo_Swift_Demo
//
//  Created by Xiong on 2017/9/7.
//  Copyright © 2017年 Xiong. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class WBRequest: NSObject {
    
    static let sharedInstance = WBRequest()
    
    private override init() {
        
    }
    
    
    func sendRequestWith(type:MethodType, url:String, parameters:Dictionary<String, Any>, finished: @escaping (_ response: String) -> ()){
        
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        let urlStr = url_host + url
        
        var param = parameters
        
        param["access_token"] = AccountInfoTool.accountInfo()?.access_token
        
        Alamofire.request(urlStr, method: method, parameters: param).responseString { (response) in
            
            switch response.result {
                
            case .success:
                
                if let value = response.result.value {
                    
                    finished(value)
                }
                break
            case .failure(let error):
                
                print(error.localizedDescription)
                
                break
                
            }

        }
        
    }

}
