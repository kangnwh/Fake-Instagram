//
//  StaticValues.swift
//  SNSApp
//
//  Created by Kang Ning on 24/9/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import PhotosUI
import AlamofireImage

struct WebAPIJSONHeader{
    static let USERNAME = "username"
    static let PASSWORD = "password"
}

public struct WebAPIUrls{
    public static let IP = "13.211.229.245"//"10.12.203.15" //"127.0.0.1" //
    public static let baseURL = "https://\(IP):5001/api"
    public static let photoResourceBaseURL = "https://\(IP):5001/photos/"
    
    public static let loginURL = baseURL + "/login/login"
    public static let signupURL = baseURL + "/login/sign-up"
    public static let postURL = baseURL + "/upload/upload"
    public static let updateAvatorURL = baseURL + "/upload/uploadAvator"
    public static let stasticsURL = baseURL + "/UserProfile/poststat"
    public static let myPhotosURL = baseURL + "/UserProfile/myphotos"
    public static let suggestionURL = baseURL + "/UserProfile/myphotos"
    public static let followedBy = baseURL + "/ActivityFeed/getFollowedUserList"
    public static let followingWhom = baseURL + "/ActivityFeed/getFollowingUserList"
    public static let discoverUserList = baseURL + "/Discover/index"
    public static let followUser = baseURL + "/Discover/followUser"
    public static let unFollowUser = baseURL + "/Discover/cancelFollowUser"
    
    
    
}


public class WebAPIHandler {
    
    
    
    public static var shared = WebAPIHandler()
    
    
    public var username:String?
    
    private var token : String?
    
    public func setToken(token: String){
        self.token = "Bearer \(token)"
        headerWithToken = [
            "Accept": "application/json",
            "Authorization":self.token!,
            "Content-Type":"application/json"
        ]
    }
    
    private let jsonHeader:HTTPHeaders = [
        "Accept": "application/json",
        "Content-Type":"application/json"
    ]
    
    private var headerWithToken:HTTPHeaders?
    
    public let _httpManager : SessionManager =  {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            WebAPIUrls.IP: .disableEvaluation

        ]
        
        let sessionManager = SessionManager(
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        return sessionManager
    }()
    
    private init(){
        let sessionManager = SessionManager(
            configuration: ImageDownloader.defaultURLSessionConfiguration(),
            serverTrustPolicyManager: ServerTrustPolicyManager(
                policies: [WebAPIUrls.IP: .disableEvaluation]
            )
        )
        
        UIImageView.af_sharedImageDownloader = ImageDownloader(sessionManager: sessionManager)
    }
    
    
    public func sendLoginRequest(username:String, password:String,viewController :UIViewController,
                                 callback:@escaping ((DataResponse<Any>) -> Void)) -> Void{
        
        let loginInfo: Parameters = [WebAPIJSONHeader.USERNAME: username, WebAPIJSONHeader.PASSWORD:password]
    
        UIFuncs.showLoadingLabel()
        _httpManager.request(WebAPIUrls.loginURL,
                          method: HTTPMethod.post,
                          parameters: loginInfo,
                          encoding: JSONEncoding.default,
                          headers: jsonHeader)
                    .validate()
                    .responseJSON { (response) in
            UIFuncs.dismissLoadingLabel()
            callback(response)
        }
    }
    
    public func sendSignupRequest(signupData : Dictionary<String,Any>,viewController :UIViewController,
                                 callback:@escaping ((DataResponse<Any>) -> Void)) -> Void{
        
        let data = signupData as! Dictionary<String,String>
        
        UIFuncs.showLoadingLabel()
        _httpManager.request(WebAPIUrls.signupURL,
                             method: HTTPMethod.post,
                             parameters: data,
                             encoding: JSONEncoding.default,
                             headers: jsonHeader)
            .validate()
            .responseJSON { (response) in
                UIFuncs.dismissLoadingLabel()
                callback(response)
        }
    }
    
    public func requestStatistic(userId: Int,
                                  callback:@escaping ((DataResponse<ProfileModel>) -> Void)) -> Void{
        
        UIFuncs.showLoadingLabel()
        _httpManager.request(WebAPIUrls.stasticsURL + "?id=\(userId)",
                             method: HTTPMethod.post,
                             encoding: JSONEncoding.default,
                             headers: self.headerWithToken)
            .validate()
            .responseObject{ (response:DataResponse<ProfileModel>) in
                UIFuncs.dismissLoadingLabel()
                callback(response)
        }
    }
    
    public func requestLike(id:Int,callback:@escaping ((DataResponse<Any>) -> Void)) -> Void{
        let postid: Parameters = ["postId":"\(id)"]
        print(postid)
        UIFuncs.showLoadingLabel()
        _httpManager.request(WebAPIUrls.baseURL + "/UserFeed/likePhoto",
                             method: HTTPMethod.post,
                             parameters: ["postId":10],
                             encoding: JSONEncoding.default,
                             headers: self.headerWithToken)
            .validate()
            .responseJSON{ (response:DataResponse<Any>) in
                UIFuncs.dismissLoadingLabel()
                callback(response)
        }
    }
    public func requestUnLike(id:String,callback:@escaping ((DataResponse<Any>) -> Void)) -> Void{
        let postid: Parameters = ["postId":id]
        UIFuncs.showLoadingLabel()
        _httpManager.request(WebAPIUrls.baseURL + "/UserFeed/dislikePhoto",
                             method: HTTPMethod.post,
                             parameters: postid,
                             encoding: JSONEncoding.default,
                             headers: self.headerWithToken)
            .validate()
            .responseJSON{ (response:DataResponse<Any>) in
                UIFuncs.dismissLoadingLabel()
                callback(response)
        }
    }
    public func requestUserPosts(userId: Int,
                                       callback:@escaping ((DataResponse<[PostModel]>) -> Void)) -> Void{
        let parameter:Parameters = ["uId": userId]
        UIFuncs.showLoadingLabel()
        _httpManager.request(WebAPIUrls.myPhotosURL + "?id=\(userId)",
                             method: HTTPMethod.post,
                             parameters:parameter,
                             encoding: JSONEncoding.default,
                             headers: self.headerWithToken)
            .validate()
            .responseArray{ (response:DataResponse<[PostModel]>) in
                UIFuncs.dismissLoadingLabel()
                callback(response)
        }
        
    }
    
//    public func requestSuggestions(viewController :UIViewController,
//                                callback:@escaping ((DataResponse<PostListModel>) -> Void)) -> Void{
//
//        UIFuncs.showLoadingLabel()
//        _httpManager.request(WebAPIUrls.myPhotosURL,
//                             method: HTTPMethod.post,
//                             encoding: JSONEncoding.default,
//                             headers: self.headerWithToken)
//            .validate()
//            .responseObject{ (response:DataResponse<PostListModel>) in
//                UIFuncs.dismissLoadingLabel()
//                callback(response)
//        }
//
//    }
    
    public func requestPost(viewController :UIViewController,
                            callback:@escaping ((DataResponse<[PostModel]>) -> ())) -> Void{
        let userid: Parameters = ["userId":"-1"]
        UIFuncs.showLoadingLabel()
        _httpManager.request(WebAPIUrls.baseURL + "/UserFeed/refresh",
                             method: HTTPMethod.post,
                             parameters: userid,
                             encoding: JSONEncoding.default,
                             headers: self.headerWithToken)
            
            .validate()
            .responseArray{ (response:DataResponse<[PostModel]>) in
                UIFuncs.dismissLoadingLabel()
                callback(response)
        }
    }
    
    
    public func requestDiscoverUserList(
                            callback:@escaping ((DataResponse<[FollowUserModel]>) -> ())) -> Void{
        UIFuncs.showLoadingLabel()
        _httpManager.request(WebAPIUrls.discoverUserList,
                             method: HTTPMethod.post,
                             encoding: JSONEncoding.default,
                             headers: self.headerWithToken)
            
            .validate()
            .responseArray{ (response:DataResponse<[FollowUserModel]>) in
                UIFuncs.dismissLoadingLabel()
                callback(response)
        }
    }
    
    
    func requestFollowInfo(type: FollowListViewController.FollowType, userId:Int,
                            callback:@escaping ((DataResponse<[FollowUserModel]>) -> ())) -> Void{
        
        var url = WebAPIUrls.followingWhom
        
        if type == .followedBy {
            url = WebAPIUrls.followedBy
        }
        
        UIFuncs.showLoadingLabel()
        _httpManager.request(url + "?id=\(userId)",
                             method: HTTPMethod.get,
//                             parameters: userid,
                             encoding: JSONEncoding.default,
                             headers: self.headerWithToken)
            
            .validate()
            .responseArray{ (response:DataResponse<[FollowUserModel]>) in
                UIFuncs.dismissLoadingLabel()
                callback(response)
        }
    }
    
    public func unFollowUser(userId: Int,
                           callback:@escaping ((DataResponse<Any>) -> ())) -> Void{
//        let userid: Parameters = ["userId":userId]
        UIFuncs.showLoadingLabel()
        
        _httpManager.request(WebAPIUrls.unFollowUser + "?userId=\(userId)",
                             method: HTTPMethod.get,
//                             parameters: userid,
                             encoding: URLEncoding.httpBody,
                             headers: self.headerWithToken)
            
            .validate()
            .responseJSON{ (response:DataResponse<Any>) in
                UIFuncs.dismissLoadingLabel()
                callback(response)
        }
    }
    
    public func followUser(userId: Int,
        callback:@escaping ((DataResponse<Any>) -> ())) -> Void{
//        let userid: Parameters = ["userId":userId]
        UIFuncs.showLoadingLabel()
        _httpManager.request(WebAPIUrls.followUser + "?userId=\(userId)",
                             method: HTTPMethod.get,
//                             parameters: userid,
                             encoding: JSONEncoding.default,
                             headers: self.headerWithToken)
            
            .validate()
            .responseJSON{ (response:DataResponse<Any>) in
                UIFuncs.dismissLoadingLabel()
                callback(response)
        }
    }
    
    
    public func upload(image: UIImage,content: String,location:String, lati: CLLocationDegrees?, logi: CLLocationDegrees?,callback:@escaping ((DataResponse<Any>) -> Void) ){
        
        let imageData = image.pngData()!
        
        UIFuncs.showLoadingLabel()
        
        _httpManager.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "file",fileName:"mypic.png" ,mimeType:"image/png")
                multipartFormData.append(content.utf8(), withName: "content")
                multipartFormData.append(location.utf8(), withName: "location")
                if let latiDouble = lati{
                    multipartFormData.append(latiDouble.utf8(), withName: "lati")
                }
                if let logiDouble = logi{
                    multipartFormData.append(logiDouble.utf8(), withName: "logi")
                }
                
            },
            to: WebAPIUrls.postURL,
            method:HTTPMethod.post,
            headers:self.headerWithToken,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                   
                    upload.responseJSON{resonse in
                        UIFuncs.dismissLoadingLabel()
                        callback(resonse)
                        
                    }
                case .failure(let encodingError):
                    UIFuncs.dismissLoadingLabel()
                    print(encodingError)
                }
        }
        )
        
    }
    
    public func updateAvator(image: UIImage,callback:@escaping ((DataResponse<Any>) -> Void) ){
        
        let imageData = image.pngData()!
        
        UIFuncs.showLoadingLabel()
        
        _httpManager.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "file",fileName:"mypic.png" ,mimeType:"image/png")
            },
            to: WebAPIUrls.updateAvatorURL,
            method:HTTPMethod.post,
            headers:self.headerWithToken,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.responseJSON{response in
                        UIFuncs.dismissLoadingLabel()
                        callback(response)
                        
                    }
                case .failure(let encodingError):
                    UIFuncs.dismissLoadingLabel()
                    print(encodingError)
                }
        }
        )
        
    }
    
    

}
