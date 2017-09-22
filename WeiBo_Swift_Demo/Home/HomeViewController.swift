//
//  HomeViewController.swift
//  SaleHouse_Swift
//
//  Created by Xiong on 2017/9/6.
//  Copyright © 2017年 Xiong. All rights reserved.
//

import UIKit
import Alamofire


class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView:UITableView?
    var refreshControl:UIRefreshControl?
    
    var dataSourceArray:Array<BlogDetailModel> = Array()
    
    override func viewDidLoad() {

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named:"navigationbar_pop_highlighted")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.done, target: self, action: #selector(clickRightBarItem))
        
        tableView = UITableView.init(frame: view.bounds, style: UITableViewStyle.plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
        
        refreshControl = UIRefreshControl.init()
        refreshControl?.addTarget(self, action: #selector(headerRefresh), for: UIControlEvents.valueChanged)
        tableView?.addSubview(refreshControl!)
        
    }
    
    func clickRightBarItem() {
        
        
    }
    
    func headerRefresh() {
        
        self.loadData(isHeaderRefresh: true)
    }
    

// MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSourceArray.isEmpty == false {
            return dataSourceArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model:BlogDetailModel = dataSourceArray[indexPath.row]
        return BlogListTableViewCell.cellHeight(blogDetailModel:model)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:BlogListTableViewCell = BlogListTableViewCell.setupCell(tableView: tableView)
        
        let model:BlogDetailModel = dataSourceArray[indexPath.row]
        
        cell.configCell(blogDetailModel: model, indexPath:indexPath)
        
        cell.handleSelectPicture = { (_ imageView:BlogImageView, _ pic_urls:Array<pic_url>, _ indexPath:IndexPath) ->() in
            
            let browseView:BlogImageBroweView = BlogImageBroweView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
            browseView.isHidden = true
            browseView.showInView(view: UIApplication.shared.keyWindow!, pic_urls: pic_urls)
            
            
            let blogCell:BlogListTableViewCell = tableView.cellForRow(at: indexPath) as! BlogListTableViewCell
            
            let coverRect:CGRect = blogCell.imageCollectionView!.convert(imageView.frame, to: UIApplication.shared.keyWindow)
            let tempImageView:UIImageView = UIImageView.init(frame: coverRect)
            tempImageView.image = imageView.imageView.image
            UIApplication.shared.keyWindow?.addSubview(tempImageView)
            
            UIView.animate(withDuration: 0.25, animations: { 
                tempImageView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
            }, completion: { (Bool) in
                tempImageView.isHidden = true
                browseView.isHidden = false
            })
            
            
            

            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == self.dataSourceArray.count - 2 {
            
            self.loadData(isHeaderRefresh: false)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        let model:BlogDetailModel = dataSourceArray[indexPath.row]
        
        print(model.created_at)
        
    }
    
    
    
    func loadData(isHeaderRefresh:Bool)  {
        
        var param:Dictionary<String, Any> = Dictionary()
        if self.dataSourceArray.count > 0 {
            if isHeaderRefresh {
                let model:BlogDetailModel = (self.dataSourceArray.first)!
                param["since_id"] = model.idstr
            }else {
                let model:BlogDetailModel = (self.dataSourceArray.last)!
                param["max_id"] = model.idstr
            }
        }
        
        WBRequest.sharedInstance.sendRequestWith(type: .GET, url: url_statuses, parameters: param) { (response) in
            
                if let object = [BlogDetailModel].deserialize(from: response, designatedPath: "statuses") {
                    
                    self.dataSourceArray.append(contentsOf: (object as? Array<BlogDetailModel>)!)
                    
                    self.refreshControl?.endRefreshing()
                    self.tableView?.reloadData()
                }
        
        }
    }

}
