//
//  EnterEmailVC.swift
//  iEntry
//
//  Created by ZAFAR on 05/08/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class EnterEmailVC: BaseController {
    //MARK:- Here are IBOutlet
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnEnter: UIButton!
    @IBOutlet weak var btncancel: UIButton!
    
    @IBOutlet weak var lbldetail: UILabel!
    @IBOutlet weak var txtemail: MDCOutlinedTextField!
    
    var loginVM = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.roundViewWithCustomRadius(radius: 10)
        self.navigationBarHidShow(isTrue: true)
        btnEnter.roundButtonWithCustomRadius(radius: 8)
        setMDCTxtFieldDesign(txtfiled: txtemail, Placeholder: "EMAIL".localized, imageIcon: trailingImage)
        self.lbldetail.text = "INGRESE CORREO DEL LA CUENTA A RECUPERAR CONTRASEÑA".localized
        self.txtemail.placeholder = "EMAIL".localized
        self.btncancel.setTitle("CANCELAR".localized, for: .normal)
        self.btnEnter.setTitle("ACEPTAR".localized, for: .normal)
        
        
    }
    let trailingImage: UIImage = {
      return UIImage.init(named: "ic-invitation",
                          in: Bundle(for: ChangePasswordVC.self),
                          compatibleWith: nil) ?? UIImage()
    }()
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
//MARK:- Checking the null able paramters
    func checkData() -> Bool{
        if txtemail.text == "" {
            AppUtility.showErrorMessage(message: "lb_warning_invalid_email".localized)
            return false
        }
        if txtemail.text?.isValidEmail != true {
            AppUtility.showErrorMessage(message: "lb_warning_invalid_email".localized)
            return false
        }
        return true
        
    }
    
    @IBAction func EnterAction(_ sender: UIButton) {
        if checkData() {
            self.moveOnMethod()
        }
    }
    
    func moveOnMethod(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"MethodVC") as? MethodVC
        vc?.email = txtemail.text!
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func cancelAction(_ sender: UIButton) {
       
        self.navigationController?.popViewController(animated: true)
    }
}
