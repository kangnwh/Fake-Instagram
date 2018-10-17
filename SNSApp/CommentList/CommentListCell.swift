//
//  CommentListCell.swift
//  SNSApp
//
//  Created by Raelyn Lyu on 14/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

class CommentListCell: UITableViewCell {
    
    
    @IBOutlet weak var commentNameLabel: UILabel!
    
    @IBOutlet weak var commentBodyLabel: UILabel!
    
    @IBOutlet weak var commentTimeLabel: UILabel!
    var comments: CommentModel! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        commentNameLabel.text = comments.username
        commentBodyLabel.text = comments.content
        commentTimeLabel.text = comments.datetime
        
    }
}
