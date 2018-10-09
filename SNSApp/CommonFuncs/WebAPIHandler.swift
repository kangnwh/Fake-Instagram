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

struct WebAPIJSONHeader{
    static let USERNAME = "username"
    static let PASSWORD = "password"
}

struct WebAPIUrls{
    public static let IP =  "127.0.0.1" //"13.211.229.245" //
    public static let baseURL = "https://\(IP):5001/api"
    public static let loginURL = baseURL + "/login/login"
    public static let signupURL = baseURL + "/login/sign-up"
    public static let postURL = baseURL + "/upload/upload"
    public static let stasticsURL = baseURL + "/UserProfile/poststat"
    public static let photoBaseURL = baseURL + "/photos"
}


public class WebAPIHandler {
    
    
    
    public static var shared = WebAPIHandler()
    
    
    
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
    
    private let _httpManager : SessionManager =  {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            WebAPIUrls.IP: .disableEvaluation

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
    
    public func requestStatistic(viewController :UIViewController,
                                  callback:@escaping ((DataResponse<StatisticsModel>) -> Void)) -> Void{
        
        UIFuncs.showLoadingLabel()
        _httpManager.request(WebAPIUrls.stasticsURL,
                             method: HTTPMethod.post,
                             encoding: JSONEncoding.default,
                             headers: self.headerWithToken)
            .validate()
            .responseObject{ (response:DataResponse<StatisticsModel>) in
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
    
    

}
