//
//  ActivityTableViewCell.swift
//  SNSApp
//
//  Created by Raelyn Lyu on 15/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ActivityImageView: UIImageView!
    @IBOutlet weak var ActivityDetailView: UILabel!
    
    var activities: ActivityModel! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        ActivityImageView.image = activities.image
        ActivityDetailView.text = activities.body
        
        
    }
}
