//
//  ViewController.swift
//  SNSApp
//
//  Created by Kang Ning on 9/9/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIFuncs.setBorder(layer: loginButton.layer, width: 1, cornerRadius: 5, color: #colorLiteral(red: 0, green: 0.6196078431, blue: 0.7058823529, alpha: 1))
        UIFuncs.setBorder(layer: registerButton.layer, width: 1, cornerRadius: 5, color: #colorLiteral(red: 0, green: 0.6196078431, blue: 0.7058823529, alpha: 1))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: Any) {
        
        guard let _ = usernameText.text else{
            UIFuncs.setBorder(layer: usernameText.layer, width: 2, cornerRadius: 5, color: UIColor.red.cgColor)
            return
        }
        guard let _ = passwordText.text else{
            UIFuncs.setBorder(layer: passwordText.layer, width: 2, cornerRadius: 5, color: UIColor.red.cgColor)
            return 
        }
        
        WebAPIHandler.shared.sendLoginRequest(username: usernameText.text!, password: passwordText.text!, viewController: self){ response in
            switch response.result{
                case .failure(let error):
                    print(error.localizedDescription)
                    UIFuncs.popUp(title: "Error", info: "Login failed, \(error.localizedDescription)", type: UIFuncs.BlockPopType.warning , sender: self, callback: {})
                case .success(let value):
                    WebAPIHandler.shared.token = "Bearer \((value as! String))"
                    // TODO: just to new ViewController
                    self.launchMain()
                
            }
            
            
        }

        
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

