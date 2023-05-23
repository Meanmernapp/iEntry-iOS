//
//  PreRegisterVC.swift
//  iEntry
//
//  Created by ZAFAR on 25/12/2021.
//

import UIKit
import SMDatePicker
import DropDown
import PhoneNumberKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class PreRegisterVC: BaseController,UITextFieldDelegate, SMDatePickerDelegate{
    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var lbluserdatatitle: UILabel!
    var phoneNumberCode = ""
    var callback : ((_ number:String, _ name:String,_ index :Int,_ guestID:String)->Void)? = nil
    @IBOutlet weak var btnaccept: UIButton!
    var myDatePicker: SMDatePicker = SMDatePicker()
//    let phonenUmberKit= phonenUmberKit
    @IBOutlet weak var txtname: MDCOutlinedTextField!
    @IBOutlet weak var txtemail: MDCOutlinedTextField!
    @IBOutlet weak var phoneNumberTextField:PhoneNumberTextField!
    @IBOutlet weak var lastNameTxt: MDCOutlinedTextField!
    @IBOutlet weak var secondLastName: MDCOutlinedTextField!
    

    @IBOutlet weak var mainView: UIView!
    var number = ""
    var name = ""
    let phoneNumberKit = PhoneNumberKit()
    var index = -1
    var MainDrowpDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        view.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.2935282726)
        setMDCTxtFieldDesign(txtfiled: txtname, Placeholder: "NOMBRE".localized.uppercased(), imageIcon: UIImage(named: "ic-user")!)
        setMDCTxtFieldDesign(txtfiled: txtemail, Placeholder: "Email".localized.uppercased(), imageIcon: UIImage(named: "ic-invitation")!)
        setMDCTxtFieldDesign(txtfiled: lastNameTxt, Placeholder: "apellido".localized.uppercased(), imageIcon: UIImage(named: "ic-user")!)
        setMDCTxtFieldDesign(txtfiled: secondLastName, Placeholder: "Primer apellido".localized.uppercased(), imageIcon: UIImage(named: "ic-user")!)
//        setMDCTxtFieldDesign(txtfiled: phoneNumberTextField, Placeholder: "CELULAR".localized.uppercased(), imageIcon: UIImage(named: "mobile-alt-solid")!)
        
        
        phoneNumberTextField.cornerRadius = 10
        phoneNumberTextField.borderColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
        phoneNumberTextField.borderWidth = 1
        phoneNumberTextField.tintColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
        phoneNumberTextField.withFlag = true
        phoneNumberTextField.withPrefix = true
        phoneNumberTextField.withExamplePlaceholder = true
        phoneNumberTextField.placeholder = "CELULAR".localized
        phoneNumberTextField.withDefaultPickerUI = true
        
        
        
        self.lbluserdatatitle.text = "DATOS DE USUARIO".localized
        self.btncancel.setTitle("CANCELAR".localized, for: .normal)
        self.btnaccept.setTitle("ENVIAR".localized, for: .normal)
        self.navigationBarHidShow(isTrue: true)
        mainView.roundViewWithCustomRadius(radius: 8)
        btnaccept.roundButtonWithCustomRadius(radius: 6)
        if self.number.isValidEmail {
            self.txtemail.text = number
        }
        else {
            self.phoneNumberTextField.text = number
        }
        self.txtname.text = name
        self.phoneNumberTextField.delegate = self
    }

    func checkData() ->Bool {
        
        if txtname.text == "" {
            AppUtility.showErrorMessage(message: "lb_empty_event_name".localized)
            return  false }
        if lastNameTxt.text == "" {
            AppUtility.showErrorMessage(message: "lb_warning_invalid_last_name".localized)
            return  false
        } else if txtemail.text == "" {
                AppUtility.showErrorMessage(message: "lb_warning_invalid_email".localized)
            return  false
        }else if phoneNumberTextField.text == "" {
            AppUtility.showErrorMessage(message: "lb_warning_invalid_phone_number".localized)
            return  false
        }
        return true
    }
    
    
    func preRegisterUser(){
        self.showLoader()
        let freedSpaceString = phoneNumberTextField.text!.replacingOccurrences(of: " ", with: "")
        let dic : [String:Any] = ["name":txtname.text!,"email":txtemail.text!,"phoneNumber":freedSpaceString,"lastName":self.lastNameTxt.text!,"secondLastName":self.secondLastName.text!]
        print(dic)
        userhandler.preRegisteration(params: dic, Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.cancelAction(UIButton())
                self.callback!(self.phoneNumberTextField.phoneNumberKit.format(self.phoneNumberTextField.phoneNumber!, toType: .e164), self.txtname.text!,self.index, response?.data?.id ?? "")
                AppUtility.showSuccessMessage(message: response?.message ?? "")
                self.dismiss(animated: true, completion: nil)
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 20
    }
    @IBAction func registerAction(_ sender: UIButton) {
        if checkData() {
            
            self.preRegisterUser()
        }
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
