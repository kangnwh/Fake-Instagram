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
    
    var data:Dictionary<String,Any>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.sectionFooterHeight = 0
        self.tableView.backgroundColor = UIColor.clear
        resetForm()
        for r in self.form.rows{
        
            r.baseCell.backgroundColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0.8)
            UIFuncs.setBorder(layer: r.baseCell.layer, width: 1, cornerRadius: 4, color: UIColor.white.cgColor)
        }
        
    }
    
    func resetForm(){
        form.removeAll()
        _setForm()
        self.tableView.reloadData()
    }
    func _setForm(){
        assert(false, "setForm of BaseFormController must be overriden by the subclass")
    }
    
    func _validate(){
        assert(false, "_validate of BaseFormController must be overriden by the subclass")
    }
    
    func setData(newData:Dictionary<String,Any>){
        assert(false, "setData of BaseFormController  must be overriden by the subclass")
    }
    
    func getData() -> Dictionary<String,Any>?{
        self._validate()
        return data
    }
    
    
    func textRowRequiredValid(row:TextRow) -> Bool{
        if row.value == "" || row.value == nil {
            UIFuncs.setWarning(layer: row.cell.layer)
            return false
        }
        UIFuncs.setNormal(layer: row.cell.layer)
        return true
    }
    
    func passwordRowRequiredValid(row:PasswordRow) -> Bool{
        if row.value == "" || row.value == nil {
            UIFuncs.setWarning(layer: row.cell.layer)
            return false
        }
        UIFuncs.setNormal(layer: row.cell.layer)
        return true
    }
    
    func alertRowRequiredValid(row:AlertRow<String>) -> Bool{
        if row.value == "" || row.value == nil{
            UIFuncs.setWarning(layer: row.cell.layer)
            return false
        }
        UIFuncs.setNormal(layer: row.cell.layer)
        return true
    }
    
    
    func emailRowRequiredValid(row:EmailRow) -> Bool{
        if row.value == "" || row.value == nil{
            UIFuncs.setWarning(layer: row.cell.layer)
            return false
        }
        UIFuncs.setNormal(layer: row.cell.layer)
        return true
    }
    
    func dateRowRequiredValid(row:DateRow) -> Bool{
        if  row.value == nil {
            UIFuncs.setWarning(layer: row.cell.layer)
            return false
        }
        UIFuncs.setNormal(layer: row.cell.layer)
        return true
    }
    
    func phoneRowRequiredValid(row:PhoneRow) -> Bool{
        if  row.value == nil {
            UIFuncs.setWarning(layer: row.cell.layer)
            return false
        }
        UIFuncs.setNormal(layer: row.cell.layer)
        return true
    }
    
    func actionSheetRowRequiredValid(row:ActionSheetRow<String>) -> Bool{
        if  row.value == nil || row.value == "" {
            UIFuncs.setWarning(layer: row.cell.layer)
            return false
        }
        UIFuncs.setNormal(layer: row.cell.layer)
        return true
    }
    
    static func createNormalFormSection(title:String) -> Eureka.Section{
        return Section(){ section in
            var header = HeaderFooterView<FormSectionTitle>(.nibFile(name:"FormSectionTItle", bundle:nil))
            header.onSetupView = { v, _ in
                v.sectionTitle.text = title
            }
            section.header = header
        }
    }
    static func createMultipleValueFormSection(title:String, placeholder:String,tag:String) -> Eureka.MultivaluedSection{
        
        let cSection = MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete], header: title, footer: "") { (section) in
            
            var header = HeaderFooterView<FormSectionTitle>(.nibFile(name:"FormSectionTItle", bundle:nil))
            header.onSetupView = { v, _ in
                v.sectionTitle.text = title
            }
            
            section.header = header
            section.tag = tag
            section.addButtonProvider = { section in
                return ButtonRow(){
                    $0.title = title
                }
            }
            section.multivaluedRowToInsertAt = { index in
                return NameRow() {
                    $0.value = ""
                    $0.placeholder = placeholder
                }
            }
            section <<< TextRow() {
                $0.value = ""
                $0.placeholder = placeholder
            }
        }
        
        return cSection
    }
}
