//
//  YoursTableViewController.swift
//  SNSApp
//
//  Created by Raelyn Lyu on 15/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

class YoursTableViewController: UITableViewController {
    var yours: [YoursModel]?
    
    struct Storyboard{
        static let commentListCell = "CommentListCell"
        static let postHeaderHeight: CGFloat = 100.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchPosts()
        
        tableView.estimatedRowHeight = Storyboard.postHeaderHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.clear
    }
    
    func fetchPosts()
    {
        self.yours = YoursModel.fetchPosts()
        self.tableView.reloadData()
    }
}
extension YoursTableViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let yours = yours {
            return yours.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = yours {
            return 1
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YoursTableViewCell", for: indexPath) as! YoursTableViewCell
        
        cell.yours = self.yours?[indexPath.section]
        cell.selectionStyle = .none
        
        return cell
    }
    
}
