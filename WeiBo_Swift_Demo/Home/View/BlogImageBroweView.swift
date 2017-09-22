//
//  BlogImageBroweView.swift
//  WeiBo_Swift_Demo
//
//  Created by Xiong on 2017/9/15.
//  Copyright © 2017年 Xiong. All rights reserved.
//

import UIKit

class BlogImageBroweView: UIView {
    
    private var scrollView:UIScrollView?
    var index:Int = 0
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.black
        
        scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        scrollView?.isPagingEnabled = true
        self.addSubview(scrollView!)
    }
    
    func showInView(view:UIView, pic_urls:Array<pic_url>) {
        
        view.addSubview(self)
        
        var i:Int = 0
        
        while i < pic_urls.count {
            
            let pic_url = pic_urls[i]
            
            let image:BlogImageView = BlogImageView.init(frame: CGRect.init(x: CGFloat(i)*kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight))
            image.setImage(url:pic_url.thumbnail_pic!, placeholderImage:"", isBig:true)
            scrollView?.addSubview(image)
            
            i += 1
        }
        

        scrollView?.contentSize = CGSize.init(width: kScreenWidth * CGFloat(pic_urls.count), height: kScreenHeight)
        
        scrollView?.setContentOffset(CGPoint.init(x: CGFloat(index)*kScreenWidth, y:0), animated: false)
        
    }
    
    
    


}


