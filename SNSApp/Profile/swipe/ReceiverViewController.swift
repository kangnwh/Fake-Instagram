//
//  ReceiverViewController.swift
//  SNSApp
//
//  Created by Kang Ning on 17/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

class ReceiverViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    private let swipeService = SwipeService()
    
    @IBOutlet weak var senderNameLabel: UILabel!
    
    
    @IBOutlet var buttonsNeedBorder: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeService.serviceDelegate = self
        UIFuncs.setBorder(views: buttonsNeedBorder, width: 1, cornerRadius: 25, color: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1))
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.swipeService.startService(type: .Receiver)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.swipeService.stopService(type: .Receiver)
    }
    
    @IBAction func saveToPhone(_ sender: Any) {
        if let image = imageView.image{
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveImageHandler(_:didFinishSavingWithError:contextInfo:)), nil)
        }else{
            UIFuncs.popUp(title: "No image received", info: "", type: .caution, sender: self, callback:{})
        }
        
    }
    
    @objc func saveImageHandler(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            
            UIFuncs.popUp(title: "Save Error", info: error.localizedDescription, type: .caution, sender: self, callback:{})
            
        } else {
            UIFuncs.popUp(title: "Saved", info: "The screenshot has been saved to your photos.", type: .success, sender: self, callback:{})
        }
    }
    
    
}


extension ReceiverViewController: SwipeServiceDelegate{
    func startLoading() {
        UIFuncs.showLoadingLabel()
    }
    
    func endLoading() {
        UIFuncs.dismissLoadingLabel()
    }
    
    func connectedDevicesChanged(manager: SwipeService, connectedDevices: [String]) {
        senderNameLabel.text = connectedDevices.joined(separator: ",")
    }
    
    func receiveImage(manager: SwipeService, image: UIImage) {
        DispatchQueue.main.async {
            NSLog("%@", "image received")
            self.imageView.image = image
            self.imageView.setNeedsDisplay()
        }
    }
    
    
    
}
