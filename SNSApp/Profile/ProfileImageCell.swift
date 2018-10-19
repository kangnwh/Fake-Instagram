//
//  ProfileImageCell.swift
//  SNSApp
//
//  Created by Kang Ning on 9/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit
import AlamofireImage
import PopupDialog

class ProfileImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    public var post: PostModel! {
        didSet{
            if let imgName = post.img{
//                let urlStr = WebAPIUrls.photoResourceBaseURL + imgName
                WebAPIHandler.shared.fetchImage(url: imgName, identifier: imgName){ image in
                    self.imageView.image = image
                }
            }
        }
    }
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
