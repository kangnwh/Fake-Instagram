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
            let url = URL(string: WebAPIUrls.photoResourceBaseURL + "/" + post.img!)!
            imageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "uploadIcon"))
        }
    }
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
