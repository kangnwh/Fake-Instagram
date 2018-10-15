//
//  YoursTableViewCell.swift
//  SNSApp
//
//  Created by Raelyn Lyu on 15/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

class YoursTableViewCell: UITableViewCell {
    
    @IBOutlet weak var YoursImageView: UIImageView!
    
    @IBOutlet weak var YoursDetailView: UILabel!
    
    var yours: YoursModel! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        YoursImageView.image = yours.image
        YoursDetailView.text = yours.body
        
        
    }
}
