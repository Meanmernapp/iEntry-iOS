//
//  LoginVC.swift
//  iEntry
//
//  Created by ZAFAR on 05/08/2021.
//

import UIKit
import Alamofire
import Foundation
import LocalAuthentication

let UUID = UIDevice.current.identifierForVendor?.uuidString

class LoginVC: BaseController {
    
    //MARK: - Here are the outlets
    
    @IBOutlet weak var btneye: UIButton!
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var btnlogin: UIButton!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var btnforgot: UIButton!
    @IBOutlet weak var lblhaveyou: UILabel!
    
    
    //MARK: - Variables
    
    var loginVM = LoginViewModel()
    var isBioMatricCanceled = false
    var callBack : ((_ isOk :Bool) -> Void)? = nil
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        unlinkUserDeviceApi()
        self.navigationController!.navigationBar.isTranslucent = false

        conFigUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBarHidShow(isTrue: true)
        if ShareData.shareInfo.Email != nil {
            self.txtemail.text = ShareData.shareInfo.Email
        }
        if ShareData.shareInfo.isBiomatric ?? false {
            if !Global.shared.isFromLogout {
                LoginBiomatric()
                Global.shared.isFromLogout = false
            }
        }
        self.navigationController?.navigationBar.setNeedsLayout()
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            self.navigationController?.navigationBar.tintColor = UIColor.white
        }
        
    }
    
    func conFigUI() {
        self.txtemail.setPlaceHolderColor(color: #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1))
        self.txtpassword.setPlaceHolderColor(color: #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1))
        self.navigationBarHidShow(isTrue: true)
        emailView.roundViiew()
        passwordView.roundViiew()
        btnlogin.roundButtonWithCustomRadius(radius: 10)
        self.txtemail.placeholder = "CORREO".localized
        self.txtpassword.placeholder = "CONTRASEÑA".localized
        self.btnlogin.setTitle("INICIAR SESIÓN".localized, for: .normal)
        self.lblhaveyou.text = "¿Has olvidado tu".localized
        self.btnforgot.setTitle("contraseña?".localized, for: .normal)
        
    }
    
    
    func checkData() -> Bool {
        if txtemail.text == "" && txtpassword.text == "" {
            AppUtility.showErrorMessage(message: "lb_title_empty_credentials".localized)
            return false
        }
        else if self.txtemail.text?.isValidEmail == false{
            AppUtility.showErrorMessage(message: "lb_warning_invalid_email".localized)
            return false
        }
        return true
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        if Network.isAvailable {
            if ShareData.shareInfo.isBiomatric ?? false {
                LoginBiomatric()
            }
            else {
                if checkData() {
                    LoginApiCall()
                }
            }
            
        } else {
            if Network.isAvailable != true {
                AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
                return
            }
        }
        
    }
    
    func unlinkUserDeviceApi(){
        self.showLoader()
        userhandler.unLinkUserDevice(userID: ShareData.shareInfo.obj?.id ?? "", Success:{response in
            if response?.success == true  {
                let storyBoard = UIStoryboard.init(name: StoryBoards.Main.rawValue, bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"LoginVC") as? LoginVC
                self.clearAllUserDefaults()
                AppUtility.showSuccessMessage(message: response?.message ?? "")
            } else {
                self.hidLoader()
                AppUtility.showErrorMessage(message: "lb_dialog_title_user_not_found".localized)
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: "lb_dialog_title_user_not_found".localized)
        })
    }
    
    
    func LoginBiomatric() {
//        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier:"ThumScaningVC") as? ThumScaningVC
//        vc?.modalPresentationStyle = .overFullScreen
        self.authenticationWithTouchID()
        self.callBack = { isok in
            if isok {
                print(isok)
                ShareData.shareInfo.isBiomatric = isok
                self.isBioMatricCanceled = false
                if ShareData.shareInfo.Email != nil {
                    self.txtemail.text = ShareData.shareInfo.Email
                }
                if ShareData.shareInfo.password != nil {
                    self.txtpassword.text = ShareData.shareInfo.password
                }
                if self.txtpassword.text != "" && self.txtemail.text != "" {
                    self.LoginApiCall()
                }
            } else {
                print(isok)
                AppUtility.showErrorMessage(message: "lb_error_biometrics_authentication_error".localized)
                self.isBioMatricCanceled = true

            }

        }
//        self.present(vc!, animated: false, completion: nil)
    }
    
    func authenticationWithTouchID() {
        DispatchQueue.main.async() {
        
            let localAuthenticationContext = LAContext()
            localAuthenticationContext.localizedFallbackTitle = "Please use your Passcode"

            var authorizationError: NSError?
            let reason = "Authentication required to access the secure data"

            if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authorizationError) {
                
                localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluateError in
                    
                    if success {
                        DispatchQueue.main.async() {
                            self.dismiss(animated: true, completion: nil)
                            self.callBack?(true)
                        }
                        
                    } else {
                        DispatchQueue.main.async() {
                            self.dismiss(animated: true, completion: nil)
                            self.callBack?(false)
                        }
                        guard let error = evaluateError else {
                            return
                        }
                        print(error)
                        
                    }
                }
            } else {
                
                guard let error = authorizationError else {
                    return
                }
                print(error)
            }
        }
        }
    
    
    //MARK: - Caling Login Api
    func LoginApiCall() {
        self.showLoader()
        ShareData.shareInfo.Email = txtemail.text ?? ""
        ShareData.shareInfo.password = txtpassword.text ?? ""
        TokenManager.shareToken.token(email: ShareData.shareInfo.Email ?? "", password: ShareData.shareInfo.password ?? "", token: {
            accessToken in
            self.hidLoader()
            if !accessToken.isEmpty {
                ShareData.shareInfo.token = accessToken
                self.loginCall()
            }else {
                self.hidLoader()
                AppUtility.showErrorMessage(message: "Token fetching failed due to Internet connection")
            }
        })
        
        
        
    }
    
    func roleData() {
        userhandler.getRoleTasks { result in
            if result?.success ?? false {
                ShareData.shareInfo.saveRoleDataV2(user: result)
                globalNewHome?.menuConfig()
                globalNewHome?.tableView.reloadData()
            }
            else {
                AppUtility.showErrorMessage(message: "Role Not Fetched")
            }

        } Failure: { error in
            AppUtility.showErrorMessage(message: "Role Not Fetched")
        }
    }
    
    
    func loginCall() {
        let dic = ["email":txtemail.text!,"password":txtpassword.text!]
        AppUtility.showInfoMessage(message: "lb_title_validate_user_credentials".localized)
        loginVM.loginApiCall(params: dic, Success: { response,trycath  in
            self.hidLoader()
            if response?.success == true {
                ShareData.shareInfo.saveUser(user: response?.data)
                UserDefaults.standard.save(customObject: response?.data, inKey: "user")
                self.sendfcmToken()
                self.getHeaders()
                ShareData.shareInfo.password = self.txtpassword.text
                ShareData.shareInfo.Email = self.txtemail.text
//                self.getuserCompanyRestrictionApi()
                print("UDID",UUID ?? "")
                if response?.data?.deviceId == UUID || response?.data?.deviceId == "" || response?.data?.deviceId?.isEmpty == true || response?.data?.deviceId == nil {
                    
                    self.userDeviceLinkApi()
                    AppUtility.showInfoMessage(message: "lb_title_downloading_data".localized)
                    if response?.data?.status?.id == 2 {
                        self.moveOnVerificationCode()
                    } else if response?.data?.userType?.id == 1 {
                        self.roleData()
                        self.getContractData()
                        self.getOnuData()
                        ShareData.shareInfo.userRole = .employees
                        self.moveOnEmployeeRole(showOnboarding: response?.data?.showOnboarding ?? true)
                        
                    }  else if response?.data?.userType?.id == 3 {
                        ShareData.shareInfo.userRole = .contractor
                        self.ContractorRole()
                    } else if response?.data?.userType?.id == 4 {
                        ShareData.shareInfo.userRole = .contractoremplyee
                        self.ContractorRole()
                        
                    }else if response?.data?.userType?.id == 5{
                        ShareData.shareInfo.userRole = .provider
                        self.providorRole()
                        
                    } else if response?.data?.userType?.id == 6{
                        ShareData.shareInfo.userRole = .provideremployee
                        self.providorRole()
                        
                    }
                    
                } else  if response?.data?.deviceId != UUID{
                    
                    AppUtility.showErrorMessage(message:"lb_unlink_device_iOS".localized )
                    return
                    
                    
                }
                
            } else {
                self.hidLoader()
//                AppUtility.showErrorMessage(message: "lb_title_validate_incorrect_credentials".localized)
                AppUtility.showErrorMessage(message: response?.message ?? "somthing is wrong")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
        
    }
    
    func getuserCompanyRestrictionApi(){
//        AppUtility.showErrorMessage(message: "lb_title_downloading_data".localized)
        userhandler.getUserCompanyRistrictionData(Success: {response in
            if response?.success == true {
                ShareData.shareInfo.saveUserCompanyRestriction(user: response?.data)
                if ShareData.shareInfo.userRestrictionObj?.biocrValidationExternal == true {
                    self.checkUserSelfiApi()
                } else {
                    
                }
            } else {
                
            }
        }, Failure: {error in
            
        })
    }
    
    func getContractData(){
        userhandler.getContractDataV2(Success: { response in
            if response?.success == true {
                ShareData.shareInfo.savecontractDataV2(user: response?.data)
            } else {
                AppUtility.showErrorMessage(message: "Contract Data Not Fetched")
            }
        }, Failure: {error in
            AppUtility.showErrorMessage(message: "Contract Data Not Fetched")
        })
    }
    
    func getOnuData(){
        userhandler.getOnuEvent(Success: { response in
            if response?.success ?? false {
                ShareData.shareInfo.isOnuEvent = response?.data?.isOnuEvent
            } else {
                ShareData.shareInfo.isOnuEvent = response?.data?.isOnuEvent
            }
        }, Failure: {error in
            AppUtility.showErrorMessage(message: "Data Not Properly Fetched")
        })
    }
    
    func checkUserSelfiApi(){
        userhandler.getCheckUserSelfiImage(userid: ShareData.shareInfo.obj?.id ?? "", Success: {response in
            if response?.success == true  {
                
            } else {
                
            }
        }, Failure: {error in
            
        })
    }
    
    func getContract(id:String) {
        userhandler.getContractByUserID(id: id) { contract in
            if ((contract?.status) != nil) {
                ShareData.shareInfo.saveContract(contract: contract?.data)
                UserDefaults.standard.save(customObject: contract?.data, inKey: "UserContractWithCompany")
            }
            else {
                AppUtility.showErrorMessage(message: "No contract")
            }
        } Failure: { error in
            AppUtility.showErrorMessage(message: "No contract")
        }
    }
    
    
    func sendfcmToken() {
        userhandler.sendFCMToken(fcmtoken: ShareData.shareInfo.fcmToken ?? "", Success: {response in
            if response?.success == true {
                
            } else {
                
            }
        }, Failure: {error in
            
        })
    }
    
    func userDeviceLinkApi(){
        userhandler.LinkUserDevice(deviceID: UUID ?? "", Success: {response in
            if response?.success == true {
                
            } else {
                
            }
        }, Failure: {error in
            
        })
    }
    
    func companyContract(showOnbaording:Bool) {
        self.showLoader()
//        AppUtility.showInfoMessage(message: "lb_title_validate_access_granted".localized)
        userhandler.getContractByUserID(id: ShareData.shareInfo.userData?.id ?? "") { responce in
            self.hidLoader()
            if responce?.success == true {
                ShareData.shareInfo.saveContract(contract: responce?.data)
                UserDefaults.standard.save(customObject: responce?.data, inKey: "UserContractWithCompany")
            }
            if showOnbaording {
                if let responceRoleId = responce?.data?.role?.id {
                    let storyBoard = UIStoryboard.init(name: StoryBoards.Main.rawValue, bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier:"EmployeeInformationViewController") as? EmployeeInformationViewController
                    vc?.roleID = responceRoleId
                    self.navigationController?.setViewControllers([vc!], animated: true)
                }
                
            }
            else {
                self.hidLoader()
                let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController
                vc?.isFirst = true
                //SelectCompanyVC//CompanyVC //NewHomeViewController///EnterEmailVC
                self.navigationController?.setViewControllers([vc!], animated: true)
            }
            
        } Failure: { error in
            self.hidLoader()
            let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController
            vc?.isFirst = true//SelectCompanyVC//CompanyVC //NewHomeViewController///EnterEmailVC
            self.navigationController?.setViewControllers([vc!], animated: true)
        }
        
    }
    
    func getHeaders() {
        userhandler.getExtraDataHeaders { responce in
            if responce?.success == true {
                ShareData.shareInfo.headersData = responce?.data
            }
            else {
                AppUtility.showErrorMessage(message: "Headers fething failed")
            }
            
            
        } Failure: { error in
            AppUtility.showErrorMessage(message: "Headers fething failed")
        }
        
    }
    
    
    
    
    
    @IBAction func forgotPassword(_ sender: UIButton) {
        self.moveOnEnterEmail()
    }
    
    @IBAction func passShwoHide(_ sender: UIButton) {
        if txtpassword.isSecureTextEntry {
            
            btneye.setImage(UIImage(named: "eye-regular"), for: .normal)
        } else {
            btneye.setImage(UIImage(named: "eye-slash-solid"), for: .normal)
        }
        txtpassword.isSecureTextEntry = !txtpassword.isSecureTextEntry
        
    }
    
    
    
    func moveOnEmployeeRole() {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController
        vc?.isFirst = true
        self.navigationController?.setViewControllers([vc!], animated: true)
    }
    
    func moveOnEmployeeRole(showOnboarding:Bool) {
        if showOnboarding {
            if let responce = ShareData.shareInfo.conractWithCompany {
                ShareData.shareInfo.contractData = responce
                if let responceRoleId = responce.role?.id {
                    let storyBoard = UIStoryboard.init(name: StoryBoards.Main.rawValue, bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier:"EmployeeInformationViewController") as? EmployeeInformationViewController
                    vc?.roleID = responceRoleId
                    self.navigationController?.setViewControllers([vc!], animated: true)
                }
            }
            else {
                companyContract(showOnbaording: showOnboarding)
            }
            
        }
        else {
            companyContract(showOnbaording: showOnboarding)
        }
        
    }
    
    
    func companyrole() {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController //SelectCompanyVC//CompanyVC //NewHomeViewController///EnterEmailVC
        vc?.isFirst = true
        self.navigationController?.setViewControllers([vc!], animated: true)
    }
    
    func ContractorRole() {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController//CompanyVC //NewHomeViewController///EnterEmailVC
        vc?.isFirst = true
        self.navigationController?.setViewControllers([vc!], animated: true)
    }
    
    func providorRole() {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController//CompanyVC //NewHomeViewController///EnterEmailVC
        vc?.isFirst = true
        self.navigationController?.setViewControllers([vc!], animated: true)
    }
    
    func moveOnEnterEmail() {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Main.rawValue, bundle: nil)
        let vc = (storyBoard.instantiateViewController(withIdentifier:"EnterEmailVC") as? EnterEmailVC)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func moveOnVerificationCode() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"VerificationCodeVC") as? VerificationCodeVC
        vc?.email = txtemail.text!
        vc?.isfrom = false
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    func scanThumb(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ThumScaningVC") as? ThumScaningVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
