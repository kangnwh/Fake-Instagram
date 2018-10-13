//  Created by Raelyn Lyu on 2/10/18.
//  Copyright © 2018 Raelyn Lyu. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var numberOfLikesButton: UIButton!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var postCaptionLabel: UILabel!
    @IBOutlet weak var numberOfCommentButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    var post: Post! {
        didSet {
            self.updateUI()
        }
    }
    
    
    func updateUI()
    {
        let likes = post.numberOfComments
       
        let likeToString = String(describing: likes!)
        
        let comment = post.numberOfComments
        let commentToString = String(describing:comment!)

        self.postImageView.image = post.image
        postCaptionLabel.text = post.caption
        numberOfLikesButton.setTitle(likeToString + " likes", for: [])
        numberOfCommentButton.setTitle(commentToString + " comments", for: [])
        timeAgoLabel.text = post.timeAgo
        addressLabel.text = post.address
    }
}




















