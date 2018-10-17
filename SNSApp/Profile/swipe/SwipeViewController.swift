//
//  SwipeViewController.swift
//  SNSApp
//
//  Created by Kang Ning on 17/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit


class SwipeViewController: UIViewController {
    
    
    @IBOutlet weak var deviceNameLabel: UILabel!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    private let swipeService = SwipeService()
    
    public var _postList: [PostModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSwipeGesture()
        swipeService.startService(type: .Sender)
        deviceNameLabel.text = "Device Name:\(swipeService.myPeerId.displayName)"
    }
    override func viewWillAppear(_ animated: Bool) {
        self.imageCollectionView.reloadData()
    }
    
    @objc func swipeToFriend(){
        if let img = self.mainImageView.image{
            UIFuncs.showLoadingLabel()
            swipeService.send(image: img)
            UIFuncs.dismissLoadingLabel()
        }
    }
    
    func setSwipeGesture(){
        // add tap gesture for image view to allow select image
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeToFriend))
        leftSwipeGesture.direction = .left
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeToFriend))
        rightSwipeGesture.direction = .right
        
        // add it to the image view;
        mainImageView.addGestureRecognizer(leftSwipeGesture)
        mainImageView.addGestureRecognizer(rightSwipeGesture)
        
        // make sure imageView can be interacted with by user
        mainImageView.isUserInteractionEnabled = true
        
    }
    

}


extension SwipeViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    private func setCollectionView(){
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width - 40
        //        let screenHeight = screenSize.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.itemSize = CGSize(width: (screenWidth-25)/3, height: screenWidth/3)
        
        imageCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self._postList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "swipeCell", for: indexPath) as? SwipeCell{
            cell.post = self._postList[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = self._postList[indexPath.row]
        let url = URL(string: WebAPIUrls.photoResourceBaseURL + "/" + post.img!)!
        self.mainImageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "loading"))
    }
    
}

