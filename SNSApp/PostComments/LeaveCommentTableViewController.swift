//
//  LeaveCommentTableViewController.swift
//  SNSApp
//
//  Created by Raelyn Lyu on 17/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//
import UIKit

class LeaveCommentTableViewController: UIViewController {
    var postId : Int?
    struct StoryBoard{
        static let commentListCell = "CommentTableViewCell"
        
    }
    
    @IBOutlet weak var commentPlaceholder: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.fetchPosts()
        
//        tableView.estimatedRowHeight = tableView.rowHeight
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.separatorColor = UIColor.clear
    }
    
    @IBAction func SubmitActionButton(_ sender: Any) {
        let context = commentPlaceholder.text
        WebAPIHandler.shared.postComments(postId: self.postId!,commentContent: context!){ response in
            switch response.result{
            case .failure(let error):
                print("error.localizedDescription")
            case .success(let value):
                print("success")
            }
        }
    
//    func fetchPosts()
//    {
//        //        self.comments = CommentModel.fetchPosts()
//        self.tableView.reloadData()
//    }
}
//extension LeaveCommentTableViewController
//{
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.commentListCell, for: indexPath) as! CommentListCell
//
//        cell.comments = self.comments?[indexPath.section]
//        cell.selectionStyle = .none
//
//        return cell
//    }
    
//}
}
