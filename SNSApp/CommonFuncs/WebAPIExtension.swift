//
//  WebAPIExtension.swift
//  SNSApp
//
//  Created by Kang Ning on 11/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import PhotosUI
import AlamofireImage


//extension WebAPIHandler{
//    public func requestFollowingList(viewController :UIViewController,
//                            callback:@escaping ((DataResponse<Any>) -> Void)) -> Void{
//        let postid: Parameters = ["postId":"-1"]
//        UIFuncs.showLoadingLabel()
//        _httpManager.request(WebAPIUrls.stasticsURL,
//                             parameters: postid,
//                             method: HTTPMethod.post,
//                             encoding: JSONEncoding.default,
//                             headers: self.headerWithToken)
//            .validate()
//            .responseJSON{ (response:DataResponse<Any>) in
//                UIFuncs.dismissLoadingLabel()
//                callback(response)
//        }
//    }
//}
