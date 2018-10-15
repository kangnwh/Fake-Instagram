//
//  ActivityModel.swift
//  SNSApp
//
//  Created by Raelyn Lyu on 15/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

struct ActivityModel
{
    var image: UIImage?
    var body: String?
    
    static func fetchPosts() -> [ActivityModel]
    {
        var activities = [ActivityModel]()
        
        let activities1 = ActivityModel(image: #imageLiteral(resourceName: "duc"), body: "Eric starts following Nicholas Li")
        let activities2 = ActivityModel(image: #imageLiteral(resourceName: "duc"), body: "Eric starts following Cissy Wang")
        
        activities.append(activities1)
        activities.append(activities2)
        return activities
    }
}
