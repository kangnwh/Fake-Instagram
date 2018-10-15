//
//  ActivityTableViewController.swift
//  SNSApp
//
//  Created by Raelyn Lyu on 15/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

class ActivityTableViewController: UITableViewController {
    var activities: [ActivityModel]?
    
    struct StoryBoard{
        static let commentListCell = "CommentListCell"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchPosts()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.clear
    }
    
    func fetchPosts()
    {
        self.activities = ActivityModel.fetchPosts()
        self.tableView.reloadData()
    }
}
extension ActivityTableViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let activities = activities {
            return activities.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = activities {
            return 1
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityTableViewCell", for: indexPath) as! ActivityTableViewCell
        
        cell.activities = self.activities?[indexPath.section]
        cell.selectionStyle = .none
        
        return cell
    }
    
}
