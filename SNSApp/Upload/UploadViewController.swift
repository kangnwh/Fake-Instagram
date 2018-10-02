//
//  UploadViewController.swift
//  SNSApp
//
//  Created by Kang Ning on 2/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit
import PhotosUI

class UploadViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    private var selectedImage: UIImage?
    
    @IBOutlet weak var locationTextView: UITextField!
    @IBOutlet weak var contentTextView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func choosePhoto(_ sender: Any) {
        self.checkPermission(hanler: self.photoLibrary)
        
        
    }
    
    
    @IBAction func takePhoto(_ sender: Any) {
        self.checkPermission(hanler: self.camera)
    }
    
    @IBAction func upload(_ sender: Any) {
        if let image = selectedImage,
            let content = contentTextView.text,
        let location = locationTextView.text{
            WebAPIHandler.shared.upload(image: selectedImage!, comment: "<#T##String#>", location: "<#T##String#>")
        }else{
            UIFuncs.popUp(title: "Warning", info: "Please select an image first", type: .caution, sender: self, callback:{})
        }
        
    }
    
}


extension UploadViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var newImage: UIImage
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        // do something interesting here!
        self.selectedImage = newImage
        self.imageView.image = newImage
//        print(newImage.size)
        
        dismiss(animated: true)
    }
    
    
    func camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            self.present(myPickerController, animated: true, completion: nil)
        }
        
    }
    
    func photoLibrary()
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .photoLibrary
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func checkPermission(hanler: @escaping () -> Void) {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            // Access is already granted by user
            hanler()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (newStatus) in
                if newStatus == PHAuthorizationStatus.authorized {
                    // Access is granted by user
                    hanler()
                }
            }
        default:
            print("Error: no access to photo album.")
        }
    }
}
