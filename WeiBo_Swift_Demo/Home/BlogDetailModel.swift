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
    
    
    func mapping(mapper: HelpingMapper) {
        // specify 'cat_id' field in json map to 'id' property in object
        
        mapper <<< self.created_at <-- TransformOf<String, String>(fromJSON: { (rawString) -> String? in
            
                    var handleString:String = ""
                    
                    let dateStr:String = rawString!
                    let fmt:DateFormatter = DateFormatter()
                    fmt.locale = NSLocale(localeIdentifier: "en_US") as Locale!
                    fmt.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
                    let date:Date = fmt.date(from: dateStr)!
                    let calendar:NSCalendar = NSCalendar.current as NSCalendar
                    let unit:NSCalendar.Unit = [.year , .month, .day, .hour, .minute, .second]
                    let components:DateComponents = calendar.components(unit, from: date, to: Date(), options: .matchFirst)
                    if components.year == 0 {
                        
                        if components.day! < 1 {
                            
                            if components.hour! >= 1 {
                                
                                handleString = "\(components.hour ?? 0)" + "小时前"
                            }else if components.minute! >= 1 {
                                handleString = "\(components.minute ?? 0)" + "分钟前"
                            }else {
                                handleString = "刚刚"
                            }
                        }else if components.day! < 2 {
                            
                            fmt.dateFormat = "昨天 HH:mm"
                            handleString = fmt.string(from: date)
                        }else {
                            
                            fmt.dateFormat = "MM-dd HH:mm"
                            handleString = fmt.string(from: date)
                        }
                        
                        
                    } else {
                        fmt.dateFormat = "yyyy-MM-dd HH:mm"
                        handleString = fmt.string(from: date)
                    }
                    return handleString
            
            }, toJSON: { (tuple) -> String? in
                
                return nil
            })
        
        mapper <<< self.source <-- TransformOf<String, String>(fromJSON: { (rawString) -> String? in
            
            let split = rawString?.substring(from: rawString?.range(of: ">")?.upperBound ?? (rawString?.endIndex)!)
            let source = split?.substring(to: split?.range(of: "</")?.lowerBound ?? (split?.endIndex)!)
            return source
        }, toJSON: { (tuple) -> String? in
            
            return nil
        })
        
    }
    
}


class pic_url: HandyJSON {
    
    var thumbnail_pic:String?
    
    required init(){}
    
    
}
