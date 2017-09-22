//
//  BlogListTableViewCell.swift
//  WeiBo_Swift_Demo
//
//  Created by Xiong on 2017/9/7.
//  Copyright © 2017年 Xiong. All rights reserved.
//

import UIKit
import AlamofireImage

typealias HandleSelectPicture = (_ imageView:BlogImageView, _ pic_urls:Array<pic_url>, _ indexPath:IndexPath) ->()

class BlogListTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private var iconImageView:UIImageView = UIImageView()
    private var vipImageView:UIImageView = UIImageView()
    private var nameLabel:UILabel = UILabel()
    private var timeLabel:UILabel = UILabel()
    private var contentLabel:UILabel = UILabel()
     var imageCollectionView:UICollectionView?
    private var commenToolView:BlogCommentToolView?
    private var currentIndexPath:IndexPath?
    private var tempBlogDetailModel:BlogDetailModel?
    
    var handleSelectPicture:HandleSelectPicture?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    class func setupCell(tableView:UITableView) -> BlogListTableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellIdentifier")
        if (cell == nil) {
            cell = BlogListTableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: "UITableViewCellIdentifier")
        }
        return cell! as! BlogListTableViewCell
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initSubViews()
        
    }
    
    private func initSubViews() {
        
        iconImageView.layer.cornerRadius = 20
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.red.cgColor
        contentView.addSubview(iconImageView)
        
        contentView.addSubview(vipImageView)
        
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textColor = UIColor.orange
        nameLabel.textAlignment = NSTextAlignment.left
        contentView.addSubview(nameLabel)
        
        timeLabel.font = UIFont.systemFont(ofSize: 10)
        timeLabel.textColor = UIColor.lightGray
        timeLabel.textAlignment = NSTextAlignment.left
        contentView.addSubview(timeLabel)
        
        contentLabel.font = UIFont.systemFont(ofSize: 13)
        contentLabel.textColor = UIColor.black
        contentLabel.textAlignment = NSTextAlignment.left
        contentLabel.numberOfLines = 0
        contentView.addSubview(contentLabel)
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        imageCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        imageCollectionView?.backgroundColor = UIColor.clear
        imageCollectionView?.delegate = self
        imageCollectionView?.dataSource = self
        contentView.addSubview(imageCollectionView!)
        imageCollectionView!.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "123")
        
        
        commenToolView = BlogCommentToolView.init(frame: CGRect.zero)
        contentView.addSubview(commenToolView!)
        commenToolView?.handleToolViewBlock = { (_ indexPath:IndexPath, _ tag:Int) ->() in
            
            
        }
    }
    
    
    // MARK: - cell 赋值
    public func configCell(blogDetailModel:BlogDetailModel, indexPath:IndexPath) -> Void {
        
        tempBlogDetailModel = blogDetailModel
        
        iconImageView.af_setImage(withURL: URL.init(string: (blogDetailModel.user?.profile_image_url)!)!)
        
        nameLabel.text = blogDetailModel.user?.name
        
        let vip:String = "common_icon_membership_level\(blogDetailModel.user?.mbtype ?? -1)"
        vipImageView.image = UIImage(named:vip)
        
        timeLabel.text = blogDetailModel.created_at! + "   来自 " + blogDetailModel.source!
        
        contentLabel.text = blogDetailModel.text
        
        commenToolView?.configView(retweetCount: blogDetailModel.reposts_count!, commentCount: blogDetailModel.comments_count!, admireCount: blogDetailModel.attitudes_count!, indexPath: indexPath)
        
        currentIndexPath = indexPath
        
        imageCollectionView!.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (tempBlogDetailModel?.pic_urls?.count)! > 0 {
            return (tempBlogDetailModel?.pic_urls?.count)!
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "123", for: indexPath)
        
        for item in cell.subviews {
            item.removeFromSuperview()
        }
        
        let image:BlogImageView = BlogImageView.init(frame: cell.contentView.bounds)
        image.backgroundColor = UIColor.black
        let url:pic_url = (tempBlogDetailModel?.pic_urls![indexPath.row])!
        
        image.setImage(url:url.thumbnail_pic!, placeholderImage:"", isBig:false)
        

        cell.addSubview(image)
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width:CGFloat = (kScreenWidth - 40)/3.0
        let height:CGFloat = width / 0.75
        
        return CGSize.init(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        if (handleSelectPicture != nil) {
            handleSelectPicture!(cell?.subviews.first as! BlogImageView, (tempBlogDetailModel?.pic_urls)!, currentIndexPath!)
        }
    }
    
    
    
// MARK: - layoutSubViewsFrame
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        iconImageView.frame = CGRect.init(x: 10, y: 10, width: 40, height: 40)
        
        let nameLabelRect:CGRect =  nameLabel.text!.boundingRect(with: CGSize.init(width: kScreenWidth, height: 15), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12)], context: nil)
        nameLabel.frame = CGRect.init(x: 60, y: 15, width: nameLabelRect.width, height: 15)
        
        vipImageView.frame = CGRect.init(x: 80 + nameLabelRect.width, y: 10, width: 20, height: 20)
        
        timeLabel.frame = CGRect.init(x: 60, y: 35, width: kScreenWidth - 100, height: 15)
        
        let contentLabelRect:CGRect =  contentLabel.text!.boundingRect(with: CGSize.init(width: kScreenWidth - 20, height: kScreenHeight), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 13)], context: nil)
        contentLabel.frame = CGRect.init(x: 10, y: 70, width: kScreenWidth - 20, height: contentLabelRect.height)
        
        var picH:CGFloat = 0
        let count:Int = (tempBlogDetailModel!.pic_urls?.count)!
        
        let lat:Int = count / 3
        let lng:Int = count % 3
        
        let heigth:CGFloat = (kScreenWidth - 40)/3.0/0.75
        
        if (tempBlogDetailModel?.pic_urls?.count)! > 0 {
            picH = CGFloat(lat) * heigth + (lng > 0 ? heigth : 0) + (CGFloat(lat) + 2)*10.0
            imageCollectionView?.frame = CGRect.init(x: 10, y: 80 + contentLabelRect.height + 10, width: kScreenWidth-20, height: picH)
        }else
        {
            picH = 0
        }
        
        commenToolView?.frame = CGRect.init(x: 0, y: 80 + contentLabelRect.height + picH, width: kScreenWidth, height: 33)
    }
    
    
    class func cellHeight(blogDetailModel:BlogDetailModel) -> CGFloat {
        
        let contentLabelRect:CGRect =  blogDetailModel.text!.boundingRect(with: CGSize.init(width: kScreenWidth - 20, height: kScreenHeight), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 13)], context: nil)
        
        var picH:CGFloat = 0
        let count:Int = (blogDetailModel.pic_urls?.count)!
        
        let lat:Int = count / 3
        let lng:Int = count % 3
        
        let heigth:CGFloat = (kScreenWidth - 40)/3.0/0.75
        
        if (blogDetailModel.pic_urls?.count)! > 0 {
            picH = CGFloat(lat) * heigth + (lng > 0 ? heigth : 0) + (CGFloat(lat) + 2)*10.0
        }
        
        return 80 + contentLabelRect.height + picH + 33
    }
    
}
