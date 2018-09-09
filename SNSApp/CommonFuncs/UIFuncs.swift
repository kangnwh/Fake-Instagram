//
//  UIFuncs.swift
//  SNSApp
//
//  Created by Kang Ning on 9/9/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import Foundation
import UIKit


public class UIFuncs{
    
    
    static func setBorder(layer:CALayer, width:Float, cornerRadius:Float, color:CGColor){
        layer.borderWidth = CGFloat(width)
        layer.cornerRadius = CGFloat(cornerRadius)
        layer.borderColor = color
    }
    
    static func setBorder(views:[UIView], width:Float, cornerRadius:Float, color:CGColor){
        for v in views{
            v.layer.borderWidth = CGFloat(width)
            v.layer.cornerRadius = CGFloat(cornerRadius)
            v.layer.borderColor = color
        }
    }
    
}
