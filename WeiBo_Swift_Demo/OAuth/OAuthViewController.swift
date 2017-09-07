//
//  OAuthViewController.swift
//  WeiBo_Swift_Demo
//
//  Created by Xiong on 2017/9/6.
//  Copyright © 2017年 Xiong. All rights reserved.
//

import UIKit
import SwiftyJSON

class OAuthViewController: BaseViewController, UIWebViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let webView = UIWebView.init()
        webView.frame = view.bounds
        webView.delegate = self
        view.addSubview(webView)
        
        let urlStr:String = "https://api.weibo.com/oauth2/authorize?client_id=" + "698065407" + "&redirect_uri=" + "http://www.sina.com"
        let url:URL = URL.init(string: urlStr)!
        webView.loadRequest(URLRequest.init(url: url))
        
        
    
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let urlStr:String = (request.url?.absoluteString)!
        
        if urlStr.contains("code=") {
            let range:Range = urlStr.range(of: "code=")!
            
            let fromIndex = range.upperBound
            
            let str = urlStr.substring(from: fromIndex)
            
            self.accessTokenWithCode(code: str)
        }

        return true

    }
    
    func accessTokenWithCode(code:String) {
        
        var dict:Dictionary<String, String> = Dictionary()
        dict["client_id"] = "698065407";
        dict["client_secret"] = "d1766db5d5bf7cd84752236a179f299b";
        dict["grant_type"] = "authorization_code";
        dict["code"] = code;
        dict["redirect_uri"] = "http://www.sina.com";
        
        WBRequest.sharedInstance.sendRequestWith(type: .POST, url: "oauth2/access_token", parameters: dict) { (response) in
            
//            let jsonData:Data = response.data(using: .utf8)!
            
//            let dict2 = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
            
            let accountInfo = AccountInfo.accountWithDict(jsonString: response)
            
            AccountInfoTool.saveAccountInfo(accountInfo: accountInfo)
            
        }
        
        
    }

}
