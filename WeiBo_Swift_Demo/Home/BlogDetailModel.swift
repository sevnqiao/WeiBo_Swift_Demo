//
//  BlogDetailModel.swift
//  WeiBo_Swift_Demo
//
//  Created by Xiong on 2017/9/7.
//  Copyright © 2017年 Xiong. All rights reserved.
//

import HandyJSON

class BlogDetailModel: HandyJSON {

    var idstr:String?
    var text:String?
    var created_at:String?
    var source:String?
    var pic_urls:Array<pic_url>?
    var bmiddle_pic:String?
    var thumbnail_pic:String?
    var original_pic:String?
    var retweeted_status:BlogDetailModel?
    var reposts_count:String?
    var comments_count:String?
    var attitudes_count:String?
    var favorited:Bool = false
    var truncated:Bool = false
    var user:UserInfoModel?


    required init(){}
    
}


class pic_url: HandyJSON {
    
    var thumbnail_pic:String?
    
    required init(){}
    
    
}
