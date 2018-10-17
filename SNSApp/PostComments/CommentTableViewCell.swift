//
//  CommentTableViewCell.swift
//  SNSApp
//
//  Created by Raelyn Lyu on 17/10/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentPlaceholder: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    
    @IBAction func SubmitActionButton(_ sender: Any) {
          let id = 
          let context = commentPlaceholder.text
        WebAPIHandler.shared.postComments(postid:postid!,commentContent: context){ response in
            switch response.result{
            case .failure(let error):
                print("error.localizedDescription")
            case .success(let value):
                print("success")
            }
    }
    
  }
}
