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

struct WebAPIJSONHeader{
    static let USERNAME = "username"
    static let PASSWORD = "password"
}

struct WebAPIUrls{
    public static let IP = "13.211.229.245"
    public static let baseURL = "https://\(IP):5001/api"
    public static let loginURL = baseURL + "/login/login"
    public static let signupURL = baseURL + "/login/sign-up"
}


public class WebAPIHandler {
    
    
    
    public static var shared = WebAPIHandler()
    
    
    
    public var token : String?
    
    private let headers:HTTPHeaders = [
        "Accept": "application/json",
        "Content-Type":"application/json"
    ]
    private let _httpManager : SessionManager =  {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            WebAPIUrls.IP: .disableEvaluation
//            "13.211.229.245:5001": .disableEvaluation,
//            "13.211.229.245": .disableEvaluation

        ]
        
        let sessionManager = SessionManager(
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        return sessionManager
    }()
    
    private init(){
        
    }
    
    
    public func sendLoginRequest(username:String, password:String,viewController :UIViewController,
                                 callback:@escaping ((DataResponse<Any>) -> Void)) -> Void{
        
        let loginInfo: Parameters = [WebAPIJSONHeader.USERNAME: username, WebAPIJSONHeader.PASSWORD:password]
        //UIFuncs.popUp(title: "Processing", info: "Login, please wait", type: .process, sender: viewController, callback: {})
        UIFuncs.showLoadingLabel()
        _httpManager.request(WebAPIUrls.loginURL,
                          method: HTTPMethod.post,
                          parameters: loginInfo,
                          encoding: JSONEncoding.default,
                          headers: headers)
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
                             headers: headers)
            .validate()
            .responseJSON { (response) in
                UIFuncs.dismissLoadingLabel()
                callback(response)
        }
    }

}
