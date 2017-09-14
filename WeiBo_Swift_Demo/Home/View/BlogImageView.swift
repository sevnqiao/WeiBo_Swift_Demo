//
//  BlogImageView.swift
//  WeiBo_Swift_Demo
//
//  Created by Xiong on 2017/9/14.
//  Copyright © 2017年 Xiong. All rights reserved.
//

import UIKit
import AlamofireImage

class BlogImageView: UIView {
    var imageView:UIImageView = UIImageView()
    var scrollView:UIScrollView = UIScrollView()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        scrollView.frame = frame
        scrollView.clipsToBounds = true
        scrollView.isScrollEnabled = false
        self.addSubview(scrollView)
        
        imageView.clipsToBounds = true
        scrollView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setImage(url: String, placeholderImage:String) {

        let urlStr = url.replacingOccurrences(of: "thumbnail", with: "bmiddle")
        imageView.af_setImage(withURL: URL(string: urlStr)!,
                         placeholderImage: UIImage(named:placeholderImage),
                         filter: nil,
                         progress: nil,
                         progressQueue: DispatchQueue.main,
                         imageTransition: .crossDissolve(0.2),
                         runImageTransitionIfCached: true) { (data) in
                            
                            self.imageView.image = data.value
                            
                            let scale = (data.value?.size.height)! / (data.value?.size.width)!
                            
                            var x:CGFloat = 0
                            var width:CGFloat = self.frame.size.width
                            var height:CGFloat = self.frame.size.height
                            
                            if self.frame.size.height - self.frame.width * scale < 0 {
                                height = width * scale
                            }else {
                                width = height / scale
                                x = (self.frame.width - width) / 2
                            }
                            
                            self.imageView.frame = CGRect.init(x: x, y: 0, width: width, height: height)
                            
                            self.scrollView.contentSize = self.imageView.bounds.size
        }
    }
}
