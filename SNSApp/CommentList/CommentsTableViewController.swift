//
//  CommentsTableViewController.swift
//  SNSApp
//
//  Created by Raelyn Lyu on 14/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController {
    var comments: [Comments]?
    
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
        self.comments = Comments.fetchPosts()
        self.tableView.reloadData()
    }
}
extension CommentsTableViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let comments = comments {
            return comments.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = comments {
            return 1
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.commentListCell, for: indexPath) as! CommentListCell
        
        cell.comments = self.comments?[indexPath.section]
        cell.selectionStyle = .none
        
        return cell
    }
    
}
