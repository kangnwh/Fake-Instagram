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
    
    func updateUI()
    {
        if let urlStr = post.avatarImageURL {
            let url = URL(string: WebAPIUrls.photoResourceBaseURL + "/" + urlStr)!
            profileImageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "5"))
        }
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2.0
        profileImageView.layer.masksToBounds = true
        
        usernameLabel.text = post.postUsername
        
       
    }
    
}











