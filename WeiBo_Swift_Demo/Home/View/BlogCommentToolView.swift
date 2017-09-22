//
//  BlogCommentToolView.swift
//  WeiBo_Swift_Demo
//
//  Created by Xiong on 2017/9/20.
//  Copyright © 2017年 Xiong. All rights reserved.
//

import UIKit

typealias HandleToolViewBlock = (_ indexPath:IndexPath, _ tag:Int) ->()

class BlogCommentToolView: UIView {
    
    var retweetBtn:UIButton?
    var commentBtn:UIButton?
    var admireBtn:UIButton?
    var currentIdexPath:IndexPath?
    
    
    var handleToolViewBlock:HandleToolViewBlock?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize.init(width: 0, height: -2)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
        self.initSubViews()
    }
    
    func initSubViews() {
        retweetBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width/3, height: self.frame.height))
        retweetBtn!.setImage(UIImage(named:"timeline_icon_retweet"), for: UIControlState.normal)
        retweetBtn!.setTitleColor(UIColor.gray, for: UIControlState.normal)
        retweetBtn!.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        retweetBtn!.addTarget(self, action: #selector(clickBtn(sender:)), for: UIControlEvents.touchUpInside)
        retweetBtn!.tag = 0
        self.addSubview(retweetBtn!)
        
        
        commentBtn = UIButton.init(frame: CGRect.init(x: self.frame.width/3, y: 0, width: self.frame.width/3, height: self.frame.height))
        commentBtn!.setImage(UIImage(named:"timeline_icon_comment"), for: UIControlState.normal)
        commentBtn!.setTitleColor(UIColor.gray, for: UIControlState.normal)
        commentBtn!.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        commentBtn!.addTarget(self, action: #selector(clickBtn(sender:)), for: UIControlEvents.touchUpInside)
        commentBtn!.tag = 1
        self.addSubview(commentBtn!)
        
        admireBtn = UIButton.init(frame: CGRect.init(x: self.frame.width/3 * 2, y: 0, width: self.frame.width/3, height: self.frame.height))
        admireBtn!.setImage(UIImage(named:"timeline_icon_unlike"), for: UIControlState.normal)
        admireBtn!.setTitleColor(UIColor.gray, for: UIControlState.normal)
        admireBtn!.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        admireBtn!.addTarget(self, action: #selector(clickBtn(sender:)), for: UIControlEvents.touchUpInside)
        admireBtn!.tag = 2
        self.addSubview(admireBtn!)
    }
    
    func configView(retweetCount:String, commentCount:String, admireCount:String, indexPath:IndexPath) {
        if Int(retweetCount)! > 0 {
            retweetBtn?.setTitle(retweetCount, for: UIControlState.normal)
        }
        if Int(commentCount)! > 0 {
            commentBtn?.setTitle(commentCount, for: UIControlState.normal)
        }
        if Int(admireCount)! > 0 {
            admireBtn?.setTitle(admireCount, for: UIControlState.normal)
        }
        currentIdexPath = indexPath
    }
    
    func clickBtn(sender:UIButton) {
        
        if (handleToolViewBlock != nil) {
            handleToolViewBlock!( currentIdexPath!, sender.tag)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        retweetBtn?.frame = CGRect.init(x: 0, y: 0, width: self.frame.width/3, height: self.frame.height)
        commentBtn?.frame = CGRect.init(x: self.frame.width/3, y: 0, width: self.frame.width/3, height: self.frame.height)
        admireBtn?.frame = CGRect.init(x: self.frame.width/3 * 2, y: 0, width: self.frame.width/3, height: self.frame.height)
    }

}
