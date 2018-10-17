//
//  SwipeCell.swift
//  SNSApp
//
//  Created by Kang Ning on 17/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

class SwipeCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var post:PostModel!{
        didSet{
            let url = URL(string: WebAPIUrls.photoResourceBaseURL + "/" + post.img!)!
            imageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "loading"))
        }
    }
    
}
