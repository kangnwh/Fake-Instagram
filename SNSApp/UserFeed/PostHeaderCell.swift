//
//  PostHeaderCell.swift
//  SNSApp
//
//  Created by Raelyn Lyu on 13/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//
//
import UIKit

class PostHeaderCell: UITableViewCell
{
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var post: PostModel! {
        didSet {
            self.updateUI()
        }
    }
    
    func setUp(cellPost: PostModel, callback: @escaping (_ userId:Int)->Void){
        
        self.post = cellPost
        
        // add tap gesture for image view to allow select image
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.toProfile))
        
        // add it to the image view;
        profileImageView.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        profileImageView.isUserInteractionEnabled = true
        
        self.backgroundColor = UIColor.white
        self.callback = callback
    }
    
    var callback: ((_ userId:Int)->Void)!
    
    @objc func toProfile(){
        self.callback(self.post.postUserId!)
    }
    
    func updateUI()
    {
        if let urlStr = post.avatarImageURL {
            let url = URL(string: WebAPIUrls.photoResourceBaseURL + urlStr)!
            profileImageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "yp_iconLoop"))
        }
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2.0
        profileImageView.layer.masksToBounds = true
        
        usernameLabel.text = post.postUsername
        
       
    }
    
}











