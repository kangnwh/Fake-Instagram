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
    var userId = -1
    
    private var _userStat:ProfileModel!{
        didSet{
            self.postCountBtn.setTitle("\(_userStat.postCount!)", for: .normal)
            self.followingCountBtn.setTitle("\(_userStat.followingCount!)", for: .normal)
            self.followerCountBtn.setTitle("\(_userStat.followerCount!)", for: .normal)
            
            if let avatar = _userStat.avatarUrl{
                let url = URL(string: WebAPIUrls.photoResourceBaseURL + "/" + avatar)!
                avatarImageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "uploadIcon"))
            }
        }
    }
    
    private var _postList: [PostModel] = []{
        didSet{
            self.imageCollectionView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setCollectionView()
//        loadStatistics()
//        loadPostList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadStatistics()
        loadPostList()
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
    
    private func loadPostList(){
        WebAPIHandler.shared.requestUserPosts(viewController: self, userId: self.userId){ (response: DataResponse<[PostModel]>) in
            if let urlList = response.result.value{
                DispatchQueue.main.async {
                    self._postList = urlList
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
            let popup = PopupDialog(title: "", message: cell.post.postContent, image: image)
            self.present(popup, animated: true, completion: nil)
        }
    }
    
    
}
