//
//  MineViewController.swift
//  SaleHouse_Swift
//
//  Created by Xiong on 2017/9/6.
//  Copyright © 2017年 Xiong. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView:UITableView?
    
    override func viewDidLoad() {
        
        tableView = UITableView.init(frame: view.bounds, style: UITableViewStyle.grouped)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableviewCellReusable")
        view.addSubview(tableView!)
        
        
        
    }
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableviewCellReusable", for: indexPath)
        

        return cell
    }

}
