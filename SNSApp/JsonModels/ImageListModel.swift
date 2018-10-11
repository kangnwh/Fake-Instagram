//
//  DiscoverModel.swift
//  SNSApp
//
//  Created by Kang Ning on 9/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper



public class ImageListModel: Mappable{
    
    var imageUrls:[String]?
    
    public init() {
        imageUrls = []
    }
    
    public required init?(map: Map) {
        self.mapping(map: map)
    }
    
    public func mapping(map: Map) {
        self.imageUrls <- map["image"]
    }
}
