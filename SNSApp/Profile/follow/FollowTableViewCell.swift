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
    
    var removeFromTableView: ((_ index:Int) -> Void)?
    
    var user: FollowUserModel!{
        didSet{
            usernameLabel.text = self.user.userName
            nicknameLabel.text = self.user.nickName
            
            if let f = self.user.isFollowedByCurrentUser, f{
                followBtn.setTitle("Unfollow", for: .normal)
            }else{
                followBtn.setTitle("Follow", for: .normal)
            }
            if let avatar = user.avatarUrl{
                let url = URL(string: WebAPIUrls.photoResourceBaseURL + "/" + avatar)!
                avatarImageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "loading"))
                WebAPIHandler.shared.fetchImage(url: avatar, identifier: avatar){ image in
                
                    self.avatarImageView.image = image.af_imageRoundedIntoCircle()  //avatarImageView.image?.af_imageRoundedIntoCircle()
                    self.avatarImageView.setNeedsDisplay()
                }
                
            }
            
            if user.userName == WebAPIHandler.shared.username{
                followBtn.isEnabled = false
                followBtn.setTitle("Yourself", for: .disabled)
                followBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
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
                        self.followBtn.setTitle("Follow", for: .normal)
                        self.user.isFollowedByCurrentUser = nil
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
                        self.followBtn.setTitle("Unfollow", for: .normal)
                        self.user.isFollowedByCurrentUser = true
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
