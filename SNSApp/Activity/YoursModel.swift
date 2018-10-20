//
//  YoursModel.swift
//  SNSApp
//
//  Created by Raelyn Lyu on 15/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

struct YoursModel
{
    var image: UIImage?
    var body: String?
    static func fetchPosts() -> [YoursModel]
    {
        var yours = [YoursModel]()
        
        let yours1 = YoursModel(image:#imageLiteral(resourceName: "duc"),body: "Ning comments on your post")
        let yours2 = YoursModel(image:#imageLiteral(resourceName: "duc"),body: "Ning likes youe photo")
        
        
        yours.append(yours1)
        yours.append(yours2)
        return yours
    }
}
