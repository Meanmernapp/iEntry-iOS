//
//  ChangePasswordVC.swift
//  iEntry
//
//  Created by ZAFAR on 05/08/2021.
//

import UIKit
import Alamofire
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class ChangePasswordVC: BaseController {
    
    @IBOutlet weak var lblenternewpassword: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnEnter: UIButton!

    @IBOutlet weak var txtpassword: MDCOutlinedTextField!
    var userData : GetUserByEmailModel?
     var email = ""
    var isfrom = false
    var loginVM = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.roundViewWithCustomRadius(radius: 10)
        self.navigationBarHidShow(isTrue: true)
        btnEnter.roundButtonWithCustomRadius(radius: 8)
        TextFieldConfig()
        self.getuserUserByEmail()
        
        
        
//        "INGRESE NUEVA CONTRASEÑA PARA CONTINUAR" = "INGRESE NUEVA CONTRASEÑA PARA CONTINUAR";
//        "PASSWORD" = "PASSWORD";
//        "ENTRAR" = "ENTRAR";
        
        self.lblenternewpassword.text = "INGRESE NUEVA CONTRASEÑA PARA CONTINUAR".localized
        self.txtpassword.placeholder = "PASSWORD".localized
        self.btnEnter.setTitle("ENTRAR".localized, for: .normal)
    }
    
    
    func TextFieldConfig() {
        setMDCTxtFieldDesign(txtfiled: txtpassword, Placeholder: "PASSWORD", imageIcon: trailingImage)
        let number = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        txtpassword.trailingView?.addGestureRecognizer(number)
        txtpassword.trailingView?.isUserInteractionEnabled = true
    }
    
    
    
    
    var leadingImage: UIImage = {
      return UIImage.init(named: "eye-regular",
                          in: Bundle(for: ChangePasswordVC.self),
                          compatibleWith: nil) ?? UIImage()
    }()
    
    var trailingImage: UIImage = {
      return UIImage.init(named: "eye-regular",
                          in: Bundle(for: ChangePasswordVC.self),
                          compatibleWith: nil) ?? UIImage()
    }()
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if  txtpassword.isSecureTextEntry {
            trailingImage = UIImage.init(named: "eye-regular")!
        } else {
            trailingImage = UIImage.init(named: "eye-slash-solid")!
        }
        
        
    
        txtpassword.isSecureTextEntry = !txtpassword.isSecureTextEntry
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    
    func checkData() -> Bool {
        
        if txtpassword.text == "" {
            AppUtility.showErrorMessage(message: "lb_warning_empty_password".localized)
            return false
        }
        
        if txtpassword.text!.count < 6 {
            AppUtility.showErrorMessage(message: "Password Minimum Length 6 Characters")
            return false
        }
        if txtpassword.text!.count > 15 {
            AppUtility.showErrorMessage(message: "Password Maximum Length 15 Characters")
            return false
        }
        return true
    }
    
    func getuserUserByEmail() {
        self.showLoader()
        loginVM.getUserByEmail(email: email, Success: { response  in
            self.hidLoader()
            if response?.success == true {
                self.userData = response
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
            
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    func changePassword() {
        
        self.showLoader()
        let stringurl = Constant.MainUrl + Constant.URLs.updatepassword + "\(self.userData?.data?.id ?? "")"
        let url = URL(string: stringurl)
        var request = URLRequest(url: url!)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "\(txtpassword.text ?? "")".data(using: .utf8)
        AF.request(request).responseJSON { response in
            self.hidLoader()
                print("all data ",response)
            do {
                if response.data == nil {
                    return
                }
                let responseModel = try JSONDecoder().decode(GetUserByEmailModel.self, from: response.data!)
                if responseModel.success == true {
                    if self.isfrom {
                        self.moveOnLogin()
                        AppUtility.showSuccessMessage(message: responseModel.message ?? "")
                    } else{
                      self.moveOnPermission()
                    }
                } else {
                    AppUtility.showErrorMessage(message:  "lb_error_email_not_exists".localized)
                    self.hidLoader()
                }
            }
            catch {
                self.hidLoader()
            }

        }
    }
    
    
    
    
    
    func moveOnPermission() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"PermissionVC") as? PermissionVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func moveOnLogin() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"LoginVC") as? LoginVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func EnterAction(_ sender: UIButton) {
        if checkData() {
            if Network.isAvailable {
                self.changePassword()
            }
            else {
                AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
            }
            
        }
    }
    
}
