//
//  PopupImageViewController.swift
//  SNSApp
//
//  Created by Kang Ning on 9/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

class PopupImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.image = image
    }


}
