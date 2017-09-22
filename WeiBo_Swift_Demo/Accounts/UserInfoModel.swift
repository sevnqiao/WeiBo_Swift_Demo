//
//  UserInfoModel.swift
//  WeiBo_Swift_Demo
//
//  Created by Xiong on 2017/9/7.
//  Copyright © 2017年 Xiong. All rights reserved.
//

import UIKit
import HandyJSON

class UserInfoModel: HandyJSON {

    
    var uid:Int64?
    var idstr:String?
    var screen_name:String?
    var name:String?
    var province:Int?
    var city:Int?
    var location:String?
    var rDescription:String?
    var url:String?
    var profile_image_url:String?
    var profile_url:String?
    var domain:String?
    var weihao:String?
    var gender:String?
    var followers_count:Int?
    var friends_count:Int?
    var statuses_count:Int?
    var favourites_count:Int?
    var created_at:String?
    var following:Bool = false
    var allow_all_act_msg:Bool = false
    var geo_enabled:Bool = false
    var verified:Bool = false
    var verified_type:Int?
    var remark:String?
    var status:BlogDetailModel?
    var allow_all_comment:Bool = false
    var avatar_large:String?
    var avatar_hd:String?
    var verified_reason:String?
    var follow_me:Bool = false
    var online_status:Int?
    var bi_followers_count:Int?
    var lang:String?
    var mbtype:Int?
    
    
    required init(){}
    
    func mapping(mapper: HelpingMapper) {
        // specify 'cat_id' field in json map to 'id' property in object
        mapper <<< self.uid <-- "id"
        mapper <<< self.rDescription <-- "description"
        
    }
    
}
