//  Created by Raelyn Lyu on 2/10/18.
//
//  PostModel.swift
//  SNSApp
//
//  Created by Raelyn Lyu on 13/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//
//
import UIKit
import AlamofireObjectMapper
import ObjectMapper

public class CommentModel:Mappable{
    var userid: Int?
    var username: String?
    var content: String?
    var datetime: Date?

    
    public required init?(map: Map) {
        self.mapping(map: map)
    }
    
    public func mapping(map: Map) {
        self.userid <- map["userid"]
        self.username <- map["username"]
        self.content <- map["content"]
        self.datetime <- map["datetime"]
    }
}

public class PostModel: Mappable {
    var postUserId: Int?
    var postId: Int?
    var img: String?
    var likeCount: Int?
    var likeUserList: [String]?
    var comments: [CommentModel]?
    var postUsername: String?
    var avatarImageURL: String?
    var postContent: String?
    var postLocation: String?
    var postTime: String?
   
    public required init?(map: Map) {
        self.mapping(map: map)
    }
    
    public func mapping(map: Map) {
        self.postUserId <- map["postuserId"]
        self.postId <- map["postId"]
        self.img <- map["img"]
        self.likeCount <- map["likeCount"]
        self.likeUserList <- map["likeUserList"]
        self.comments <- map["comments"]
        self.postUsername <- map["postUsername"]
        self.avatarImageURL <- map["avatarImageURL"]
        self.postContent <- map["postContent"]
        self.postLocation <- map["postLocation"]
        self.postTime <- map["postTime"]
        
    }
}

