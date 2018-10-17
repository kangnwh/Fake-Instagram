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
        
        let yours1 = YoursModel(image:#imageLiteral(resourceName: "icon-checkbox-filled"),body: "Eric starts following You")
        let yours2 = YoursModel(image:#imageLiteral(resourceName: "icon-checkbox-filled"),body: "Eric likes youe photo")
        
        
        yours.append(yours1)
        yours.append(yours2)
        return yours
    }
}
