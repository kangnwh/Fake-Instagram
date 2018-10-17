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
    
    @IBOutlet weak var commentPlaceholder: UITextView!
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIFuncs.setBorder(layer: commentPlaceholder.layer, width: 2, cornerRadius: 5, color: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1))
        UIFuncs.setBorder(layer: submitButton.layer, width: 1, cornerRadius: 15, color: UIColor.clear.cgColor)
    }
    
    @IBAction func SubmitActionButton(_ sender: Any) {
        let context = commentPlaceholder.text
        WebAPIHandler.shared.postComments(postId: self.postId!,commentContent: context!){ response in
            switch response.result{
            case .failure(let error):
                NSLog(error.localizedDescription)
            case .success(_):
                self.navigationController?.popViewController(animated: true)
            }
        }
    
    }
}
