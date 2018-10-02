//
//  Log.swift
//  SNSApp
//
//  Created by Kang Ning on 2/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import Foundation

//
//  Log.swift
//  Order
//
//  Created by Kang Ning on 11/7/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

class Log{
    enum LOG_LEVEL:Int{
        case DEBUG = 90
        case INFO = 80
        case WARNING = 70
        case ERROR = 60
    }
    static var level = LOG_LEVEL.DEBUG
    static func debug(info:String){
        if level.rawValue > LOG_LEVEL.DEBUG.rawValue{
            print(info)
        }
    }
    static func info(info:String){
        if level.rawValue > LOG_LEVEL.INFO.rawValue{
            print(info)
        }
    }
    static func warning(info:String){
        if level.rawValue > LOG_LEVEL.WARNING.rawValue{
            print(info)
        }
    }
    static func error(info:String){
        if level.rawValue > LOG_LEVEL.ERROR.rawValue{
            print(info)
        }
    }
}
