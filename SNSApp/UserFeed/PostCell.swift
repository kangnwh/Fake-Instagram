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
    
    var callback :(( _ post: PostModel) -> Void )!
    var callback2 :(( _ post: PostModel) -> Void )!
    var callback3 :(( _ postId: Int) -> Void )!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var numberOfLikesButton: UIButton!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var postCaptionLabel: UILabel!
   
    @IBAction func leaveCommentButton(_ sender: Any) {
        callback3(post.postId!)
    }
    @IBAction func likeSkipButton(_ sender: Any) {
        callback2(post)
    }
    @IBOutlet weak var numberOfCommentButton: UIButton!
    @IBAction func numberOfCommentsButton(_ sender: Any) {
        callback(post)
    }
    @IBOutlet weak var addressLabel: UILabel!
    @IBAction func likeButton(_ sender: UIButton) {
        
        if sender.currentImage == UIImage(named: "icon-like.png"){
//            let postid = post.postId
//            WebAPIHandler.shared.requestLike(id:postid!){ response in
//                switch response.result{
//                case .failure(let error):
//                    print("error.localizedDescription")
//                case .success(let value):
//                    sender.setImage(UIImage(named:"icon-like-filled.png"), for: .normal)
//                }
//            }
            sender.setImage(UIImage(named:"icon-like-filled.png"), for: .normal)
            let likes = post.likeCount!+1
            
            let likeToString = String(describing: likes)
            numberOfLikesButton.setTitle(likeToString + " likes", for: [])
        }else{
            sender.setImage(UIImage(named:"icon-like.png"), for: .normal)
            let likes = post.likeCount!
            
            let likeToString = String(describing: likes)
            numberOfLikesButton.setTitle(likeToString + " likes", for: [])
        }
        //TODO:like or unlike
        
        
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




















