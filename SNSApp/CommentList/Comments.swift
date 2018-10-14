//
//  Comments.swift
//  SNSApp
//
//  Created by Raelyn Lyu on 14/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//
import UIKit

struct Comments
{
    var username: String?
    var body: String?
    static func fetchPosts() -> [Comments]
    {
        var comments = [Comments]()
        
        let comments1 = Comments(username: "Raelyn Lyu", body: "sdasgduigfASgffhdFIW IAFHDISO; DFHEWFHO AFHLSFHOWE DAJDOJPDJIEW ASDNASDHO LKEFLSF DKLAJSD")
        
        comments.append(comments1)
        comments.append(comments1)
        comments.append(comments1)
        comments.append(comments1)
        return comments
    }
}
