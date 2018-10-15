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
        
        let yours1 = YoursModel(image:#imageLiteral(resourceName: "icon-checkbox-filled"),body: "Eric starts following Nicholas Li")
        
        yours.append(yours1)
        return yours
    }
}
