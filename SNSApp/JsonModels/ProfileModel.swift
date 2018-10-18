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



public class ProfileModel: Mappable{
    
    var username:String?
    var postCount:Int?
    var followerCount:Int?
    var followingCount:Int?
    var avatarUrl: String?
    
    public required init?(map: Map) {
        self.mapping(map: map)
    }
    
    public func mapping(map: Map) {
        self.username <- map["username"]
        self.postCount <- map["postCount"]
        self.followerCount <- map["followerCount"]
        self.followingCount <- map["followingCount"]
        self.avatarUrl <- map["avatar"]
    }
}
