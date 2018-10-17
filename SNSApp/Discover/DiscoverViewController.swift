//
//  DiscoverViewController.swift
//  SNSApp
//
//  Created by Kang Ning on 9/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var userList: [FollowUserModel] = []{
        didSet{
            self.suggestionTableView.reloadData()
        }
    }
    
    @IBOutlet weak var suggestionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadDiscoverUserList()
    }
    
    
    func loadDiscoverUserList(){
        WebAPIHandler.shared.requestDiscoverUserList{ response in
            DispatchQueue.main.async {
                if let r = response.result.value{
                    self.userList = r
                }
            }
            
        }
    }
    
    
}

extension DiscoverViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "suggestionCell") as? DiscoverTableViewCell{
            cell.user = self.userList[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            guard let cell = tableView.cellForRow(at: indexPath) as? DiscoverTableViewCell else{
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

extension DiscoverViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        WebAPIHandler.shared.requestUserInfo(username: searchBar.text!){response in
            if let ul = response.result.value{
                self.userList = ul
            }
            
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}
