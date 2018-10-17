//
//  FollowListViewController.swift
//  SNSApp
//
//  Created by Kang Ning on 16/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

class FollowListViewController: UIViewController {
    
    var userId:Int!
    var userList: [FollowUserModel] = []{
        didSet{
            self.followListTableView.reloadData()
        }
    }
    
    
    public enum FollowType {
        case followedBy
        case followingWho
    }

    @IBOutlet weak var followListTableView: UITableView!
    var listType:FollowType = .followingWho
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.followListTableView.allowsSelection = false

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        queryFollowInfo()
    }
    
    func queryFollowInfo(){
        WebAPIHandler.shared.requestFollowInfo(type: self.listType, userId: self.userId){ response in
            DispatchQueue.main.async {
                if let list = response.result.value{
                    self.userList = list
                }else{
                    UIFuncs.popUp(title: "Follow Info Error", info: "Failed to load follow info", type: .warning, sender: self, callback: {})
                }
            }
        }
    }

}


extension FollowListViewController: UITableViewDataSource, UITableViewDelegate{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "followUserCell") as? FollowTableViewCell{
            cell.user = self.userList[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FollowTableViewCell else{
            return
        }
        
        
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "userprofile") as? UserProfileViewController{
            vc.userId = cell.user.userId!
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            UIFuncs.popUp(title: "Error", info: "Cannot find profile view", type: .warning, sender: self, callback: {})
        }
        
    }
    
    
}
