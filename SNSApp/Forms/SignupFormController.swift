//
//  LoginFormController.swift
//  Order
//
//  Created by Kang Ning on 17/7/18.
//  Copyright © 2018 Kang Ning. All rights reserved.
//

import Foundation
import Eureka

class SignupFormController: BaseFormController {
    
    let USERNAME_STR = "username"
    let PASSWORD_STR = "password"
    let PASSWORD_CONFIRM_STR = "password_confirm"
    let NICKNAME_STR = "name"
    let EMAIL_STR = "email"
    let PHONE_STR = "phone"
    let DOB_STR = "dob"
    let GENDER_STR = "gender"
    
    struct GenderInfo{
        static let MALE_Value = "Male"
        static let FEMALE_Value = "Female"
        static let MALE_Key = "Female" // value that will be sent to server
        static let FEMALE_Key = "Male" // value that will be sent to server
        static let GENDER_DICT = [ MALE_Value:MALE_Key,FEMALE_Value:FEMALE_Key ]
    }
    
    override func _setForm() {

        form +++ BaseFormController.createNormalFormSection(title: "Please provide your info:")
            <<< TextRow(){ row in
                row.tag = USERNAME_STR
                row.cell.textField.placeholder = USERNAME_STR
                row.value = "Ning"

        }
        
        form +++ BaseFormController.createNormalFormSection(title: "Password:")
            <<< PasswordRow(){ row in
                row.tag = PASSWORD_STR
                row.cell.textField.placeholder = PASSWORD_STR
                row.value = "111111"
            }
            <<< PasswordRow(){ row in
                row.tag = PASSWORD_CONFIRM_STR
                row.cell.textField.placeholder = PASSWORD_CONFIRM_STR
                row.value = "111111"
        }
            
        form +++ BaseFormController.createNormalFormSection(title: "Basic information")
            <<< TextRow(){ row in
                row.title = NICKNAME_STR
                row.tag = NICKNAME_STR
                row.cell.textField.placeholder = NICKNAME_STR
                row.value = "Eric"

            }
        
            <<< EmailRow(){ row in
                row.title = EMAIL_STR
                row.tag = EMAIL_STR
                row.cell.textField.placeholder = EMAIL_STR
                row.value = "a@ad.com"

            }
//
////        form +++ BaseFormController.createNormalFormSection(title: EMAIL_STR)
            <<< PhoneRow(){ row in
                row.title = PHONE_STR
                row.tag = PHONE_STR
                row.cell.textField.placeholder = PHONE_STR
                row.value = "111111"

            }
//
////        form +++ BaseFormController.createNormalFormSection(title: EMAIL_STR)
            <<< DateRow(){ row in
                row.title = DOB_STR
                row.tag = DOB_STR
                row.value = Date()
            }
//
////        form +++ BaseFormController.createNormalFormSection(title: EMAIL_STR)
            <<< ActionSheetRow<String>(){ row in
                row.title = GENDER_STR
                row.tag = GENDER_STR
                row.selectorTitle = GENDER_STR
                row.options = Array(GenderInfo.GENDER_DICT.keys)
                row.value = GenderInfo.MALE_Value
            }
//
        
    }
    
    override func _validate(){
        
        var isValid = true;
        var errorMsg:String = ""
        
        let usernameRow = form.rowBy(tag: USERNAME_STR) as! TextRow
        let passswordRow = form.rowBy(tag: PASSWORD_STR) as! PasswordRow
        let passswordConfirmRow = form.rowBy(tag: PASSWORD_STR) as! PasswordRow
        let nicknameRow = form.rowBy(tag: NICKNAME_STR) as! TextRow
        let emailRow = form.rowBy(tag: EMAIL_STR) as! EmailRow
        let phoneRow = form.rowBy(tag: PHONE_STR) as! PhoneRow
        let dobRow = form.rowBy(tag: DOB_STR) as! DateRow
        let genderRow = form.rowBy(tag: GENDER_STR) as! ActionSheetRow<String>
        
        
        if (!self.textRowRequiredValid(row: usernameRow)){
            errorMsg += "username is required\n"
            isValid = false
        }
        
        if (!self.passwordRowRequiredValid(row: passswordRow) || !self.passwordRowRequiredValid(row: passswordConfirmRow)){
            isValid = false
            errorMsg += "password is required\n"
            
        }else if passswordRow.value! != passswordConfirmRow.value!{
            errorMsg += "passwords are not matched\n"
            UIFuncs.setWarning(layer: passswordRow.cell.layer)
            UIFuncs.setWarning(layer: passswordConfirmRow.cell.layer)
        }else{
            UIFuncs.setNormal(layer: passswordRow.cell.layer)
            UIFuncs.setNormal(layer: passswordConfirmRow.cell.layer)
        }
        
        if (!self.textRowRequiredValid(row: nicknameRow)){
            errorMsg += "nickname is required\n"
            isValid = false
        }
        
        if (!self.emailRowRequiredValid(row: emailRow)){
            errorMsg += "email is required\n"
            isValid = false
        }
        
        if (!self.phoneRowRequiredValid(row: phoneRow)){
            errorMsg += "phone is required\n"
            isValid = false
        }
        
        if(!self.dateRowRequiredValid(row: dobRow)){
            errorMsg += "dob is required\n"
            isValid = false
        }
        
        if(!self.actionSheetRowRequiredValid(row: genderRow)){
            errorMsg += "gender is required\n"
            isValid = false
        }
        
        if (!isValid){
            self.data = nil
            UIFuncs.popUp(title: "", info: errorMsg, type: .warning, sender: self, callback: {})
            return 
        }
        
        self.data = [
            USERNAME_STR : usernameRow.value!,
            PASSWORD_STR : passswordRow.value!,
            NICKNAME_STR : nicknameRow.value!,
            EMAIL_STR : emailRow.value!,
            PHONE_STR : phoneRow.value!,
            DOB_STR : dobRow.value!.toString(format: .isoDate),
            GENDER_STR : (GenderInfo.GENDER_DICT[genderRow.value!])!
        ]
        
        
    }
    
    
}
