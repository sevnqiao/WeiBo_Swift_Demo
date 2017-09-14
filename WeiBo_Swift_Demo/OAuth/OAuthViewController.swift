//
//  OAuthViewController.swift
//  WeiBo_Swift_Demo
//
//  Created by Xiong on 2017/9/6.
//  Copyright © 2017年 Xiong. All rights reserved.
//

import UIKit

class OAuthViewController: BaseViewController, UIWebViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let webView = UIWebView.init()
        webView.frame = view.bounds
        webView.delegate = self
        view.addSubview(webView)
        
        let urlStr:String = "https://api.weibo.com/oauth2/authorize?client_id=" + app_client_id + "&redirect_uri=" + app_redirect_uri
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
            
            return false
        }

        return true

    }
    
    func accessTokenWithCode(code:String) {
        
        var dict:Dictionary<String, String> = Dictionary()
        dict["client_id"] = app_client_id
        dict["client_secret"] = app_client_secret
        dict["grant_type"] = "authorization_code"
        dict["code"] = code
        dict["redirect_uri"] = app_redirect_uri
        
        WBRequest.sharedInstance.sendRequestWith(type: .POST, url: url_access_token, parameters: dict) { (response) in
            
            let accountInfo:AccountInfo = AccountInfo.deserialize(from: response)!
            accountInfo.create_time = Date()
            
            AccountInfoTool.saveAccountInfo(accountInfo: accountInfo)
            
            UIApplication.shared.keyWindow?.rootViewController = BaseTabBarController.init()
        }
    }
}
