//
//  AppDelegateExtension.swift
//  SNSApp
//
//  Created by Kang Ning on 24/9/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate{
    func getViewControllerByName(storyboard:String, controllerName:String) -> UIViewController?{
        return UIStoryboard.init(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: controllerName)
        
    }
    
    func switchRootViewController(rootViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if animated {
            UIView.transition(with: window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
                let oldState: Bool = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                self.window!.rootViewController = rootViewController
                UIView.setAnimationsEnabled(oldState)
            }, completion: { (finished: Bool) -> () in
                if (completion != nil) {
                    completion!()
                }
            })
        } else {
            window!.rootViewController = rootViewController
        }
    }
}
