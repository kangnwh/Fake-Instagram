//
//  UIFuncs.swift
//  SNSApp
//
//  Created by Kang Ning on 9/9/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages
import AudioToolbox
import FCAlertView

public class UIFuncs{
    static let ErrorSoundID:UInt32 = 1073
    
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
    
//
//    // popup windows
//    static func popWarningWindow(info:String){
//        popBarNotification(theme: .warning, body: info, iconText: "W", title: "Warning")
//    }
//
//
//    static func popInfoWindow(info:String){
//        popBarNotification(theme: .info, body: info, iconText: "i", title: "Warning")
//    }
//
//    static func popSuccWindow(info:String){
//        popBarNotification(theme: .success, body: info, iconText: "i", title: "Warning")
//    }
//
//
//    static func popErrorWindow(info:String){
//        popBarNotification(theme: .error, body: info, position: .center, iconText: "X", title: "Error",layout:.cardView)    }
//
//    static func popAlertWindow(info:String, parent:UIViewController,callback:@escaping (UIAlertAction)->Void){
//        let alertView = UIAlertController(title: "Warning", message: info, preferredStyle: .alert)
//        alertView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: callback))
//
//        parent.present(alertView, animated: true)
//
//    }
//
//    static func popBarNotification(theme:Theme,body:String,position:SwiftMessages.PresentationStyle = .top, iconText:String ,title:String, layout:MessageView.Layout = .statusLine){
//
//        var config = SwiftMessages.Config()
//
//        config.duration = .seconds(seconds: 0.8)
//        config.presentationStyle = position
//        config.presentationContext = .window(windowLevel: UIWindowLevelNormal)
//
//        let view = MessageView.viewFromNib(layout: layout)
//        view.configureTheme(theme)
//        view.configureDropShadow()
//        view.configureContent(title: title, body: body, iconImage: nil, iconText: iconText, buttonImage: nil, buttonTitle: "OK", buttonTapHandler: nil)
//
//        SwiftMessages.show(config:config, view: view)
//        AudioServicesPlayAlertSound(ErrorSoundID)
//    }
    
    
    enum BlockPopType{
        case caution
        case success
        case warning
        case process
    }
    static func popUp(title:String, info:String, type:BlockPopType,sender:UIViewController,callback:@escaping ()->Void){
        let alert = FCAlertView()
        alert.doneBlock = callback
        switch type{
        case .caution:
            alert.makeAlertTypeCaution()
        case .success:
            alert.makeAlertTypeSuccess()
        case .warning:
            alert.makeAlertTypeWarning()
        case .process:
            alert.makeAlertTypeProgress()
        }
        
        alert.showAlert(inView: sender,
                        withTitle: title,
                        withSubtitle: info,
                        withCustomImage: nil,
                        withDoneButtonTitle: nil,
                        andButtons: nil)
    }
    
    
    static func setupLoadingLabel(id:String, title:String, body:String, iconText:String = "⥁") -> (MessageView,SwiftMessages.Config){
        let loadingLabel = MessageView.viewFromNib(layout: .cardView)
        var config = SwiftMessages.Config()
        
        config.duration = .forever
        config.presentationStyle = .center
        config.presentationContext = .automatic
        
        loadingLabel.id = id
        loadingLabel.configureTheme(.success)
        loadingLabel.configureDropShadow()
        
        loadingLabel.configureContent(title: title, body: body, iconImage: nil, iconText: iconText, buttonImage: nil, buttonTitle: "OK", buttonTapHandler: { button in
            SwiftMessages.hide(id: loadingView.label.id)
        })
        
        return (loadingLabel,config)
    }
    
    static let loadingView:(label:MessageView,config:SwiftMessages.Config) = setupLoadingLabel(id:"loading", title: "Processing", body: "Please wait ...")
    
    
    static func showLoadingLabel(){
        SwiftMessages.show(config:loadingView.config, view: loadingView.label)
    }
    
    static func dismissLoadingLabel(){
        SwiftMessages.hide(id: loadingView.label.id)
    }
    
}
