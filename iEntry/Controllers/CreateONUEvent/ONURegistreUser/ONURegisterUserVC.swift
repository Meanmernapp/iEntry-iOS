//
//  ONURegisterUserVC.swift
//  iEntry
//
//  Created by ZAFAR on 09/05/2022.
//

import UIKit
import PhoneNumberKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class ONURegisterUserVC: BaseController {
    @IBOutlet weak var lbluserdatatitle: UILabel!
    
    @IBOutlet weak var btnaccepttitle: UIButton!
    @IBOutlet weak var btncanceltitle: UIButton!
    @IBOutlet weak var lblBzYesTitle: UILabel!
    @IBOutlet weak var lblsharepdftitle: UILabel!
    @IBOutlet weak var lblagreedtitle: UILabel!
    @IBOutlet weak var txtname: MDCOutlinedTextField!
    @IBOutlet weak var txtSecondname: MDCOutlinedTextField!
    @IBOutlet weak var txtSecondlastname: MDCOutlinedTextField!
    @IBOutlet weak var txtemail: MDCOutlinedTextField!
    
    @IBOutlet weak var txtphone: PhoneNumberTextField!
    
    @IBOutlet weak var txtorganization: MDCOutlinedTextField!
    
    
    @IBOutlet weak var lblbzBadgetitle: UILabel!
    @IBOutlet weak var txtpickupsite: MDCOutlinedTextField!
    
    @IBOutlet weak var lblpdfShareyestitle: UILabel!
    
    @IBOutlet weak var txtnumberofcompanies: MDCOutlinedTextField!
    
    var callBack:((_ name:String, _ email:String, _ phone: String, _ organization:String, _ pickupSite:String, _ numberofCompanoin:String, _ bzbadge:Bool,_ ispdfShare:Bool )->Void)? = nil
    var ispdfshare = false
    var isbzBadge = false
    
    var number = ""
    var name = ""
    var lastName = ""
    var secondLastname = ""
    var email = ""
    var isAlreadyRegister = false
    @IBOutlet weak var sharePDFSwitch: UISwitch!
    @IBOutlet weak var gzBadgSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbluserdatatitle.text = "DATOS DE USUARIO".localized
        self.lblagreedtitle.text  = "Agrega el código de tu país.".localized
        self.lblbzBadgetitle.text = "GZ BADGE".localized
        self.lblsharepdftitle.text = "COMPARTIR PDF".localized
        self.lblpdfShareyestitle.text = "SÍ".localized
        self.lblBzYesTitle.text = "SÍ".localized
        self.btncanceltitle.setTitle("CANCELAR".localized, for: .normal)
        self.btnaccepttitle.setTitle("CONFIMRMAR".localized, for: .normal)
        self.setUpView()
        
        if isAlreadyRegister == true  {
            txtemail.text =  email
            txtphone.text = number
            txtname.text = name
            txtSecondname.text = lastName
            txtSecondlastname.text = secondLastname
            txtemail.isUserInteractionEnabled = false
            txtphone.isUserInteractionEnabled = false
            txtname.isUserInteractionEnabled = false
            txtSecondname.isUserInteractionEnabled = false
            txtSecondlastname.isUserInteractionEnabled = false
            txtname.backgroundColor = #colorLiteral(red: 0.8822566867, green: 0.8824083209, blue: 0.8822471499, alpha: 1)
            txtSecondlastname.backgroundColor = #colorLiteral(red: 0.8822566867, green: 0.8824083209, blue: 0.8822471499, alpha: 1)
            txtSecondname.backgroundColor = #colorLiteral(red: 0.8822566867, green: 0.8824083209, blue: 0.8822471499, alpha: 1)
            txtphone.backgroundColor = #colorLiteral(red: 0.8822566867, green: 0.8824083209, blue: 0.8822471499, alpha: 1)
            txtemail.backgroundColor = #colorLiteral(red: 0.8822566867, green: 0.8824083209, blue: 0.8822471499, alpha: 1)
        } else {
            txtemail.isUserInteractionEnabled = true
            txtphone.isUserInteractionEnabled = true
            txtname.isUserInteractionEnabled = true
            txtSecondname.isUserInteractionEnabled = true
            txtSecondlastname.isUserInteractionEnabled = true
            if number.isValidEmail == true {
                txtemail.text =  number
            } else {
                txtphone.text = number
            }
            
            txtname.text = name
            txtSecondlastname.text = secondLastname
            txtSecondname.text = lastName
        }
    }
    

    func setUpView(){
        setMDCTxtFieldDesign(txtfiled: txtname, Placeholder: "NOMBRE".localized + "*", imageIcon:UIImage(named: "ic-user")!)
        setMDCTxtFieldDesign(txtfiled: txtSecondname, Placeholder: "apellido".localized.uppercased(), imageIcon: UIImage(named: "ic-user")!)
        setMDCTxtFieldDesign(txtfiled: txtSecondlastname, Placeholder: "Primer apellido".localized.uppercased(), imageIcon: UIImage(named: "ic-user")!)
        setMDCTxtFieldDesign(txtfiled: txtemail, Placeholder: "CORREO".localized + "*", imageIcon:UIImage(named: "ic-invitation")!)
//        setMDCTxtFieldDesign(txtfiled: txtphone, Placeholder: "CELULAR".localized + "*", imageIcon:UIImage(named: "mobile-alt-solid")!)
       
        
        txtphone.cornerRadius = 10
        txtphone.borderColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
        txtphone.borderWidth = 1
        txtphone.tintColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
        txtphone.withFlag = true
        txtphone.withPrefix = true
        txtphone.withExamplePlaceholder = true
        txtphone.placeholder = "CELULAR".localized
        txtphone.withDefaultPickerUI = true
        
        setMDCTxtFieldDesign(txtfiled: txtorganization, Placeholder: "ORGANIZACIÓN".localized + "*", imageIcon:UIImage())
        
        setMDCTxtFieldDesign(txtfiled: txtpickupsite, Placeholder: "SITIO PARA RECOGER".localized + "*", imageIcon:UIImage())
        setMDCTxtFieldDesign(txtfiled: txtnumberofcompanies, Placeholder: "NÚMERO DE ACOMPAÑANTES".localized + "*", imageIcon:UIImage())
    }
    
    
    func preRegisterUser(){
        self.showLoader()
        let freedSpaceString = (txtphone.text ?? "").replacingOccurrences(of: " ", with: "")
        let dic : [String:Any] = ["name":txtname.text ?? "","email":txtemail.text ?? "","phoneNumber":freedSpaceString,"lastName":self.txtSecondname.text!,"secondLastName":self.txtSecondlastname.text!]
        print(dic)
        userhandler.preRegisteration(params: dic, Success: {response in
            self.hidLoader()
            if response?.success == true {
                //self.cancelAction(UIButton())
                //self.callback!(self.phoneNumberTextField.text!, self.txtname.text!)
                AppUtility.showErrorMessage(message: response?.message ?? "")
                self.callBack?(self.txtname.text ?? "", self.txtemail.text ?? "", self.txtphone.text ?? "", self.txtorganization.text ?? "", self.txtpickupsite.text ?? "",self.txtnumberofcompanies.text ?? "",self.isbzBadge,self.ispdfshare)
                   self.dismiss(animated: true, completion: nil)
            } else {
                self.dismiss(animated: true, completion: nil)
                let storyBoard = UIStoryboard.init(name: "ONUEvent", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"UserAlreadyExistVC") as? UserAlreadyExistVC
                vc?.email = self.txtemail.text ?? ""
                vc?.name = self.txtname.text ?? ""
                vc?.phone = self.txtphone.text ?? ""
                vc?.modalPresentationStyle = .overFullScreen
                
                self.present(vc!, animated: false, completion: nil)
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    @IBAction func gzBadgeAction(_ sender: UISwitch) {
        
        if sender.isOn == true {
            isbzBadge = true
        } else {
            isbzBadge = false
        }
        
    }
    
    @IBAction func pdfShareAction(_ sender: UISwitch) {
        if sender.isOn == true {
            ispdfshare = true
        } else {
            ispdfshare = false
        }
    }
    
    func checkData() -> Bool {
        
        if txtname.text == "" {
            AppUtility.showErrorMessage(message: "lb_empty_event_name".localized)
            return false
        }
        if txtSecondname.text == "" {
            AppUtility.showErrorMessage(message: "lb_warning_invalid_last_name".localized)
            return false
        }
        else if txtemail.text == "" {
            AppUtility.showErrorMessage(message: "lb_warning_invalid_email".localized)
            return false
        } else if txtphone.text == "" {
            AppUtility.showErrorMessage(message: "lb_warning_invalid_phone_number".localized)
            return false
        } else if txtpickupsite.text == "" {
            AppUtility.showErrorMessage(message: "lb_title_place_to_pick_up".localized)
            return false
        } else if txtorganization.text == "" {
            AppUtility.showErrorMessage(message: "Please Enter Organization")
            return false
        } else if txtnumberofcompanies.text == "" {
            AppUtility.showErrorMessage(message: "Please Enter Companoin Number")
            return false
        }
        return true
    }
    
    
    
    @IBAction func confirmAction(_ sender: UIButton) {
        
        if checkData() {
            
            if isAlreadyRegister == false {
                
                preRegisterUser()
                
            } else {
                if let phone = txtphone.phoneNumber {
                    self.callBack?(txtname.text ?? "", txtemail.text ?? "", self.txtphone.phoneNumberKit.format(phone, toType: .e164),txtorganization.text ?? "" , txtpickupsite.text ?? "",txtnumberofcompanies.text ?? "",self.isbzBadge,ispdfshare)
                    self.dismiss(animated: true, completion: nil)
                }
                else {
                    AppUtility.showErrorMessage(message: "lb_warning_invalid_phone_number".localized)
                }
            }
        }
        
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }

}
