//
//  ViewController.swift
//  SNSApp
//
//  Created by Kang Ning on 9/9/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

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


}

