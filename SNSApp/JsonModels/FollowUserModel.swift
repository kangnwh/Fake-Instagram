//
//  FollowUserModel.swift
//  SNSApp
//
//  Created by Kang Ning on 16/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper

public class FollowUserModel: Mappable{
    
    var userName:String?
    var nickName:String?
    var avatarUrl: String?
    var isFollowedByCurrentUser: Bool?
    
    public required init?(map: Map) {
        self.mapping(map: map)
    }
    
    public func mapping(map: Map) {
       
    }
}
