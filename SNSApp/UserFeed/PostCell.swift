//  Created by Raelyn Lyu on 2/10/18.
//
//  PostCell.swift
//  SNSApp
//
//  Created by Raelyn Lyu on 13/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var numberOfLikesButton: UIButton!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var postCaptionLabel: UILabel!
    @IBOutlet weak var numberOfCommentButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBAction func likeButton(_ sender: UIButton) {
        //TODO:like or unlike
        sender.setImage(UIImage(named: "icon-like-filled.png"), for: .normal)
        
    }
    
    @IBAction func leaveCommentButton(_ sender: UIButton) {
        //TODO: skip to comment page
    }
    var post: PostModel! {  
        didSet {
            self.updateUI()
        }
    }
    
    
    func updateUI()
    {
        let likes = post.likeCount
       
        let likeToString = String(describing: likes!)
        
        let comment = post.comments?.count
        let commentToString = String(describing:comment!)
        
        
        if let urlStr = post.img {
            let url = URL(string: WebAPIUrls.photoResourceBaseURL + "/" + urlStr)!
            postImageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "uploadIcon"))
        }
        
        
        postCaptionLabel.text = post.postContent
        numberOfLikesButton.setTitle(likeToString + " likes", for: [])
        numberOfCommentButton.setTitle(commentToString + " comments", for: [])
        timeAgoLabel.text = post.postTime
        addressLabel.text = post.postLocation
    }
}




















