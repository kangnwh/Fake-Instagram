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

class UserProfileViewController: UIViewController {
    private var _userStat:StatisticsModel!{
        didSet{
            self.postCountLabel.text = "\(_userStat.postCount!)"
            self.followerCountLabel.text = "\(_userStat.followerCount!)"
            self.followingCountLabel.text = "\(_userStat.followingCount!)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadStatistics()
    }
    
    @IBOutlet weak var postCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!

    private func loadStatistics(){
        WebAPIHandler.shared.requestStatistic(viewController: self){ (response: DataResponse<StatisticsModel>) in
            if let stat = response.result.value{
                DispatchQueue.main.async {
                    self._userStat = stat
                }
                
            }else{
                UIFuncs.popUp(title: "Load Error", info: "User profile load error, error code:\(response.response?.statusCode ?? -1)", type: .warning, sender: self, callback: {})
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
