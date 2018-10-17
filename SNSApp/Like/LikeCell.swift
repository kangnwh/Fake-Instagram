//
//  CommentCell.swift
//  SNSApp
//
//  Created by Raelyn Lyu on 13/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

class LikeCell: UITableViewCell {
    
    
    
//    @IBOutlet weak var AvatarView: UIImageView!
    
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var LikeLabel: UILabel!
    var likes: String! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
//        AvatarView.image = likes.createdBy.profileImage
//        AvatarView.layer.cornerRadius = AvatarView.bounds.width / 2.0
//        AvatarView.layer.masksToBounds = true
//
        NameLabel.text = likes
        
        
    }
}
