//
//  FollowTableViewCell.swift
//  SNSApp
//
//  Created by Kang Ning on 16/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

class FollowTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var followBtn: UIButton!
    
    var followUser: FollowUserModel!{
        didSet{
            usernameLabel.text = self.followUser.userName
            nicknameLabel.text = self.followUser.nickName
            if let _ = self.followUser.isFollowedByCurrentUser{
                followBtn.isEnabled = false
            }
            if let avatar = followUser.avatarUrl{
                let url = URL(string: WebAPIUrls.photoResourceBaseURL + "/" + avatar)!
                avatarImageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "uploadIcon"))
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
