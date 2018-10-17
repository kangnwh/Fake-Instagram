//
//  CommentController.swift
//  SNSApp
//
//  Created by Raelyn Lyu on 13/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

class LikeController: UITableViewController
{
    var likes: [String]?
    
    struct Storyboard {
        static let likeCell = "LikeCell"
        static let likeHeaderHeight: CGFloat = 57.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.fetchPosts()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.clear
//        tableView.register(LikeCell.self, forCellReuseIdentifier: "LikeCellA")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchPosts()
    }
    func fetchPosts()
    {
//        self.likes = ["dsdas","dsadas","dasd"]
        self.tableView.reloadData()
    }
}

extension LikeController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let likes = likes{
            return likes.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = likes {
            return 1
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikeCell", for: indexPath) as! LikeCell
        
        cell.likes = self.likes?[indexPath.section]
        cell.selectionStyle = .none
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//    {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.likeCell) as! LikeCell
//
//        cell.likes = self.likes?[section]
//        cell.backgroundColor = UIColor.white
//
//        return cell
//    }
    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return Storyboard.likeHeaderHeight
//    }
    
    
    
}
