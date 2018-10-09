//
//  SignupViewController.swift
//  SNSApp
//
//  Created by Kang Ning on 24/9/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addFormView()
    }
    
    
    @IBOutlet weak var formViewPlaceholder: UIView!
    
    
    var formView = SignupFormController()
    
    func addFormView(){
        formView.view.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: formViewPlaceholder.frame.width, height: formViewPlaceholder.frame.height)
        formView.tableView.separatorStyle = .singleLine
        
        addChild(formView)
        formViewPlaceholder.addSubview(formView.view)
        formView.didMove(toParent: self)
    }
    
    @IBAction func onSignupClick(_ sender: Any) {
        //let signupData = formView.getData()
        
        guard let signupData = formView.getData() else{
            return
        }
        
        WebAPIHandler.shared.sendSignupRequest(signupData: signupData, viewController: self){ response in
            switch response.result{
                
            case .failure(let error):
                print(error.localizedDescription)
                UIFuncs.popUp(title: "Error", info: "Signup failed, \(error.localizedDescription)", type: UIFuncs.BlockPopType.warning , sender: self, callback: {})
                return
                
            case .success( _):
                // signup successfully, directly send login reqeust
                let username = signupData[self.formView.USERNAME_STR] as! String
                let password = signupData[self.formView.PASSWORD_STR] as! String
                WebAPIHandler.shared.sendLoginRequest(username: username, password: password, viewController: self){response in
                    switch response.result{
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                        UIFuncs.popUp(title: "Error", info: "Login failed, \(error.localizedDescription)", type: UIFuncs.BlockPopType.warning , sender: self, callback: {})
                        return
                        
                    case .success(let value):
                        WebAPIHandler.shared.setToken(token: (value as! String))
                            self.navigationController?.popViewController(animated: true)
                        self.launchMain()
                    }
                    
                }
            }
            
        }
        
    }
    
    
    @IBAction func onBackClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func launchMain(){

        let appDel = UIApplication.shared.delegate as! AppDelegate
        if let vc = appDel.getViewControllerByName(storyboard: "Main", controllerName: "mainTabView"){
            appDel.switchRootViewController(rootViewController: vc
                , animated: true, completion: nil)
        }else{
            print("cannot find main view controller")
        }
            
            
    }
    
    
}
