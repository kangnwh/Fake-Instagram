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
    
    var comments: Comments! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        commentNameLabel.text = comments.username
        commentBodyLabel.text = comments.body
        
        
    }
}
