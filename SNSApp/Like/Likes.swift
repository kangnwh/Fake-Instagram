//
//  Likes.swift
//  SNSApp
//
//  Created by Raelyn Lyu on 13/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

struct Likes
{
    var createdBy: User
    var timeAgo: String?
    static func fetchPosts() -> [Likes]
    {
        var likes = [Likes]()
        
        let duc = User(username: "Raelyn Lyu", profileImage: UIImage(named: "duc"))
        let likes1 = Likes(createdBy: duc, timeAgo: "1 hr")
        
        likes.append(likes1)
        likes.append(likes1)
        likes.append(likes1)
        likes.append(likes1)
        return likes
    }
}
