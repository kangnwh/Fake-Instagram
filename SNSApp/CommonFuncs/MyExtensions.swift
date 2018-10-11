//
//  MyExtensions.swift
//  SNSApp
//
//  Created by Kang Ning on 2/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import Foundation
import UIKit

extension String{
  
    public func utf8() -> Data{
        return self.data(using:String.Encoding.utf8)!
    }
        
}

extension Float{
    public func utf8() -> Data{
        return "\(self)".data(using: String.Encoding.utf8)!
    }
}

extension Double{
    public func utf8() -> Data{
        return "\(self)".data(using: String.Encoding.utf8)!
    }
}

