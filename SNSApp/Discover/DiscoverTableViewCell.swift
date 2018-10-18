//
//  DiscoverTableViewCell.swift
//  SNSApp
//
//  Created by Kang Ning on 16/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

class DiscoverTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var useridLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followingBtn: UIButton!
    
    
    var user:FollowUserModel!{
        didSet{
            useridLabel.text = self.user.userName
            usernameLabel.text = self.user.nickName
            if let f = self.user.isFollowedByCurrentUser, f{
                followingBtn.setTitle("Unfollow", for: .normal)
            }else{
                followingBtn.setTitle("Follow", for: .normal)
            }
            
            if let avatar = user.avatarUrl{
                let url = URL(string: WebAPIUrls.photoResourceBaseURL + "/" + avatar)!
                avatarImageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "uploadIcon"))
            }
        }
    }
    
    @IBAction func following(_ sender: Any) {
        if let f = self.user.isFollowedByCurrentUser, f{
            
            WebAPIHandler.shared.unFollowUser(userId: self.user.userId!){ response in
                switch response.result{
                case .failure(let error):
                    print(error.localizedDescription)
                case .success( _):
                    DispatchQueue.main.async {
                        self.followingBtn.setTitle("Unfollow", for: .normal)
                    }
                    
                }
                
            }
            
        }else{
            WebAPIHandler.shared.followUser(userId: self.user.userId!){ response in
                switch response.result{
                case .failure(let error):
                    print(error.localizedDescription)
                case .success( _):
                    DispatchQueue.main.async {
                        self.followingBtn.setTitle("Unfollow", for: .normal)
                    }
                    
                }
                
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
