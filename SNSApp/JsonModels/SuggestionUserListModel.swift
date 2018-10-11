//
//  SuggestionUserListModel.swift
//  SNSApp
//
//  Created by Kang Ning on 9/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper

public class SuggestionUserListModel: Mappable{
    var userList:[SuggestUser]?
    
    public init() {
        userList = []
    }
    
    public required init?(map: Map) {
        self.mapping(map: map)
    }
    
    public func mapping(map: Map) {
        self.userList <- map["users"]
    }
}

public class SuggestUser: Mappable{
    var id:Int?
    var userName: String?
    var avatarUrl: String?
    
    public required init?(map: Map) {
        self.mapping(map: map)
    }
    
    public func mapping(map: Map) {
        self.id <- map["userId"]
        self.userName <- map["userName"]
        self.avatarUrl <- map["avatarUrl"]
    }
}
