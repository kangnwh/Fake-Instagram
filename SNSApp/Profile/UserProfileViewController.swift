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

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var popImageView: UIImageView!
    
    private var _userStat:ProfileModel!{
        didSet{
            self.postCountLabel.text = "\(_userStat.postCount!)"
            self.followerCountLabel.text = "\(_userStat.followerCount!)"
            self.followingCountLabel.text = "\(_userStat.followingCount!)"
            if let avatar = _userStat.avatarUrl{
                let url = URL(string: WebAPIUrls.photoResourceBaseURL + "/" + avatar)!
                avatarImageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "uploadIcon"))
            }
        }
    }
    
    private var _photoUrlList: PostListModel = PostListModel(){
        didSet{
            self.imageCollectionView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setCollectionView()
        loadStatistics()
        loadImageList()
    }
    
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var postCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    private func setCollectionView(){
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width - 40
//        let screenHeight = screenSize.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        
        imageCollectionView.collectionViewLayout = layout
    }

    
    private func loadStatistics(){
        WebAPIHandler.shared.requestStatistic(viewController: self){ (response: DataResponse<ProfileModel>) in
            if let stat = response.result.value{
                DispatchQueue.main.async {
                    self._userStat = stat
                }
            }else{
                UIFuncs.popUp(title: "Load Error", info: "User profile load error, error code:\(response.response?.statusCode ?? -1)", type: .warning, sender: self, callback: {})
            }
        }
    }
    
    private func loadImageList(){
        WebAPIHandler.shared.requestMyPhotos(viewController: self){ (response: DataResponse<PostListModel>) in
            if let urlList = response.result.value{
                DispatchQueue.main.async {
                    self._photoUrlList = urlList
                }
            }else{
                UIFuncs.popUp(title: "Load Error", info: "User photos load error, error code:\(response.response?.statusCode ?? -1)", type: .warning, sender: self, callback: {})
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension UserProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self._photoUrlList.imageUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ProfileImageCell{
            cell.imageUrl = self._photoUrlList.imageUrls![indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ProfileImageCell{
            let image = cell.imageView.image
            
            // Create the dialog
//            let imageController = PopupImageViewController()
//            imageController.view.frame = self.view.frame
//            imageController.image = image
//            let popup = PopupDialog(viewController: imageController)
            let popup = PopupDialog(title: "", message: "", image: image)
            self.present(popup, animated: true, completion: nil)
        }
    }
    
    
}
