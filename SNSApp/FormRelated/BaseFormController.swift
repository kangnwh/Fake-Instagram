//
//  BaseFormController.swift
//  Order
//
//  Created by Kang Ning on 16/7/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import Foundation
import Eureka
import CloudKit


class BaseFormController :Eureka.FormViewController{
    
    var record:CKRecord?
    override func viewDidLoad() {
        super.viewDidLoad()
        resetForm()
        self.tableView.sectionFooterHeight = 0
        self.tableView.backgroundColor = UIColor.clear
        for r in self.form.rows{
            r.baseCell.backgroundColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0.8)
            UICommonFuncs.setBorder(layer: r.baseCell.layer, width: 1, cornerRadius: 4, color: UIColor(named: "background")!.cgColor)
        }
    }
    
    func resetForm(){
        self.record = nil
        form.removeAll()
        _setForm()
        self.tableView.reloadData()
    }
    func _setForm(){
        assert(false, "setForm of BaseFormController must be overriden by the subclass")
    }
    func setData(entity:BaseModel){
        assert(false, "setData of BaseFormController  must be overriden by the subclass")
    }
    func saveData(callback:@escaping (Bool,String) -> Void){
        assert(false, "saveData of BaseFormController must be overriden by the subclass")
    }
    
  
    func textRowRequiredValid(row:TextRow) -> Bool{
        if row.value == "" || row.value == nil {
            UICommonFuncs.setWarning(layer: row.cell.layer)
            return false
        }
        return true
    }
    
    func passwordRowRequiredValid(row:PasswordRow) -> Bool{
        if row.value == "" || row.value == nil {
            UICommonFuncs.setWarning(layer: row.cell.layer)
            return false
        }
        return true
    }
    
    func alertRowRequiredValid(row:AlertRow<String>) -> Bool{
        if row.value == "" || row.value == nil{
            UICommonFuncs.setWarning(layer: row.cell.layer)
            return false
        }
        return true
    }
    
    
    func emailRowRequiredValid(row:AlertRow<String>) -> Bool{
        if row.value == "" || row.value == nil{
            UICommonFuncs.setWarning(layer: row.cell.layer)
            return false
        }
        return true
    }
}
