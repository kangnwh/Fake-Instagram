//
//  DiscoverViewController.swift
//  SNSApp
//
//  Created by Kang Ning on 9/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import PopupDialog
import YPImagePicker

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var popImageView: UIImageView!
    var userId = -1
    
    
    private var _userStat:ProfileModel!{
        didSet{
            self.postCountBtn.setTitle("\(_userStat.postCount!)", for: .normal)
            self.followingCountBtn.setTitle("\(_userStat.followingCount!)", for: .normal)
            self.followerCountBtn.setTitle("\(_userStat.followerCount!)", for: .normal)
            
            if let avatar = _userStat.avatarUrl{
                let url = URL(string: WebAPIUrls.photoResourceBaseURL + "/" + avatar)!
                
                avatarImageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "uploadIcon"))
                avatarImageView.image = avatarImageView.image?.af_imageRoundedIntoCircle()
            }
        }
    }
    
    private var _postList: [PostModel] = []{
        didSet{
            self.imageCollectionView.reloadData()
        }
    }
    
    
    @IBOutlet var buttonsNeedBorder: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setCollectionView()
        initAvatorPicker()
        
        UIFuncs.setBorder(layer: avatarImageView.layer, width: 1, cornerRadius: 25, color: UIColor.white.cgColor)
        UIFuncs.setBorder(views: buttonsNeedBorder, width: 1, cornerRadius: 25, color: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1))
    }
    
    override func viewWillAppear (_ animated: Bool) {
        if self.userId == -1{
            avatarImageView.isUserInteractionEnabled = true
            avatarIndicator.isHidden = false
        }else{
            avatarImageView.isUserInteractionEnabled = false
            avatarIndicator.isHidden = true
        }
        loadStatistics()
        loadPostList()
    }
    
    @IBOutlet weak var gridView: UIImageView!
    var picker:YPImagePicker!
    @IBOutlet weak var avatarIndicator: UIImageView!
    
    func initAvatorPicker(){
        
        // add tap gesture for image view to allow select image
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.pickImage))
        
        // add it to the image view;
        avatarImageView.addGestureRecognizer(tapGesture)
        
        // make sure imageView can be interacted with by user
        avatarImageView.isUserInteractionEnabled = true
        
        // 3rd photo library
        var config = YPImagePickerConfiguration()
        config.library.mediaType = .photoAndVideo
        config.library.onlySquare  = false
        config.onlySquareImagesFromCamera = true
        config.targetImageSize = .original
        config.usesFrontCamera = true
        config.showsFilters = true
        config.screens = [.library, .photo]
        config.hidesStatusBar = false
        config.usesFrontCamera = false
        
        config.showsCrop = .rectangle(ratio: (1/1))
        config.overlayView = gridView
        
        picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { [picker] items, _ in
            if let photo = items.singlePhoto {
                WebAPIHandler.shared.updateAvator(image: photo.image){ response in
                    switch response.result{
                    case .failure(let error):
                        print(error.localizedDescription)
                        UIFuncs.popUp(title: "Error", info: "Upload avatar failed", type: UIFuncs.BlockPopType.warning , sender: self, callback: {})
                    case .success:
                        self.avatarImageView.image = photo.image
                    }
                    
                }
            }
            
            self.picker.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc func pickImage(){
        present(picker, animated: true, completion: nil)
    }
    
 
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
//    @IBOutlet weak var postCountLabel: UILabel!
    
    @IBOutlet weak var postCountBtn: UIButton!
    @IBAction func postDetail(_ sender: Any) {
    }
    
    @IBOutlet weak var followerCountBtn: UIButton!
    
    @IBAction func followerCountDetail(_ sender: Any) {
    }
    
    @IBOutlet weak var followingCountBtn: UIButton!
    @IBAction func followingCountDetail(_ sender: Any) {
    }
    
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
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

    
    private func loadStatistics(){
        WebAPIHandler.shared.requestStatistic(userId: self.userId){ (response: DataResponse<ProfileModel>) in
            if let stat = response.result.value{
                DispatchQueue.main.async {
                    self._userStat = stat
                }
            }else{
                UIFuncs.popUp(title: "Load Error", info: "User profile load error, error code:\(response.response?.statusCode ?? -1)", type: .warning, sender: self, callback: {})
            }
        }
    }
    
    private func loadPostList(){
        WebAPIHandler.shared.requestUserPosts(userId: self.userId){ (response: DataResponse<[PostModel]>) in
            if let urlList = response.result.value{
                DispatchQueue.main.async {
                    self._postList = urlList
                }
            }else{
                UIFuncs.popUp(title: "Load Error", info: "User photos load error, error code:\(response.response?.statusCode ?? -1)", type: .warning, sender: self, callback: {})
            }
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            switch(identifier){
            case "toFollowedBy":
                if let followView = segue.destination as? FollowListViewController{
                    followView.userId = self.userId
                    followView.listType = .followedBy
                }
            case "toFollowingWhom":
                if let followView = segue.destination as? FollowListViewController{
                    followView.userId = self.userId
                    followView.listType = .followingWho
                }
            case "toSwipe":
                if let dest = segue.destination as? SwipeViewController{
                    dest._postList = self._postList
                }
            default:
                break
            }
        }
    }


}


extension UserProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self._postList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ProfileImageCell{
            cell.post = self._postList[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ProfileImageCell{
            let image = cell.imageView.image
            
            // Create the dialog
//            let p = PopupDialog(title: "", message: cell.post.postContent, image: image, buttonAlignment: .vertical, transitionStyle: .fadeIn, preferredWidth: 340, tapGestureDismissal: true, panGestureDismissal: true, hideStatusBar: false, completion: nil)
            
            let popup = PopupDialog(title: cell.post.postContent, message: "Location:\(cell.post.postLocation ?? "N/A")", image: image)
            let cancleBtn =  CancelButton(title: "OK", action: nil)
            popup.addButton(cancleBtn)
            
            self.present(popup, animated: true, completion: nil)
        }
    }
    
    
}
