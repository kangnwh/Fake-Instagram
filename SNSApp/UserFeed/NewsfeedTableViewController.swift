//
//  NewsfeedTableViewController.swift
//  SNSApp
//
//  Created by Raelyn Lyu on 13/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//
//
import UIKit

class NewsfeedTableViewController: UITableViewController
{
    var posts: [PostModel]?
    var selectedPost :[CommentModel]?
    
    struct Storyboard {
        static let postCell = "PostCell"
        static let postHeaderCell = "PostHeaderCell"
        static let postHeaderHeight: CGFloat = 57.0
        static let postCellDefaultHeight: CGFloat = 578.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchPosts()
        tableView.estimatedRowHeight = Storyboard.postCellDefaultHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.clear
    }
    
    
    @IBAction func refresh(_ sender: Any) {
        fetchPosts()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = posts?[indexPath.section]

        selectedPost = product?.comments
        print(selectedPost!)
        performSegue(withIdentifier:"CheckComments" , sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CheckComments" {
            let commentTVC = segue.destination as! CommentsTableViewController
            commentTVC.comments = selectedPost
        }
    }
    func fetchPosts()
    {
        WebAPIHandler.shared.requestPost(viewController: self){ response in
            if let posts = response.result.value{
                self.posts = posts
                self.tableView.reloadData()
            }
            
        }
        
    }
    func toProfileView(userId: Int){
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "userprofile") as? UserProfileViewController{
            vc.userId = userId
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
             UIFuncs.popUp(title: "Error", info: "Cannot find profile view", type: .warning, sender: self, callback: {})
        }
    
    }
}

extension NewsfeedTableViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let posts = posts {
            return posts.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = posts {
            return 1
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.postCell, for: indexPath) as! PostCell
        
        cell.post = self.posts?[indexPath.section]
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.postHeaderCell) as! PostHeaderCell
        
        cell.setUp(cellPost: (self.posts?[section])!, callback: self.toProfileView)
    
    
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Storyboard.postHeaderHeight
    }
    
    
}
















