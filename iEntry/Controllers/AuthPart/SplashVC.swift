//
//  ViewController.swift
//  iEntry
//
//  Created by ZAFAR on 04/08/2021.
//

import UIKit
import Firebase
import FirebaseMessaging
class SplashVC: BaseController {
    
    //MARK:- Splash screen
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBarHidShow(isTrue: true)
        //moveOnLang()
        //fatalError()
        if let token = Messaging.messaging().fcmToken {
            print("FCM Token", token)
            ShareData.shareInfo.fcmToken = token
        }
        
        TokenManager.shareToken.token(email: ShareData.shareInfo.Email ?? "", password: ShareData.shareInfo.password ?? "", token: { accessToken in
            ShareData.shareInfo.token = accessToken
        })
        
        
        if (ShareData.shareInfo.obj != nil) {
            
            if Network.isAvailable {
                print("Internet connection OK")
                if ShareData.shareInfo.saveLanguage?.isEmpty == true  {
                    moveOnLang()
                }
                if ShareData.shareInfo.isLiveSession ?? false {
                    moveOnHome()
                }
                else {
                    
                    moveOnLogin()
                }
                
            } else {
                moveOnHome()
                AppUtility.showSuccessMessage(message: "Continuing Without Internet Connection")
            }
        } else {
            if ShareData.shareInfo.saveLanguage?.isEmpty == nil  {
                moveOnLang()
            } else {
                if ShareData.shareInfo.isLiveSession ?? false {
                    moveOnHome()
                }
                else {
                    
                    moveOnLogin()
                }
            }
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBarHidShow(isTrue: true)
    }
    
    //MARK:- This is funtion helps to move on other Screen
    
    func moveOnLang() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"LanguageVC") as? LanguageVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func moveOnLogin() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"LoginVC") as? LoginVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func moveOnHome() {
        if ShareData.shareInfo.obj?.status?.id == 2 {
            self.moveOnVerificationCode()
        } else if ShareData.shareInfo.obj?.userType?.id == 1 {
            ShareData.shareInfo.userRole = .employees
            self.moveOnEmployeeRole(showOnboarding: ShareData.shareInfo.obj?.showOnboarding ?? true)
            
        }  else if ShareData.shareInfo.obj?.userType?.id == 3 {
            ShareData.shareInfo.userRole = .contractor
            self.ContractorRole()
        } else if ShareData.shareInfo.obj?.userType?.id == 4 {
            ShareData.shareInfo.userRole = .contractoremplyee
            self.ContractorRole()
            
        }else if ShareData.shareInfo.obj?.userType?.id == 5{
            ShareData.shareInfo.userRole = .provider
            self.providorRole()
            
        } else if ShareData.shareInfo.obj?.userType?.id == 6{
            ShareData.shareInfo.userRole = .provideremployee
            self.providorRole()
            
        }
    }
    
    func userDeviceLinkApi(){
        userhandler.LinkUserDevice(deviceID: UUID ?? "", Success: {response in
            if response?.success == true {
                
            } else {
                
            }
        }, Failure: {error in
            
        })
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
                companyContract()
            }
            
        }
        else {
            let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController //SelectCompanyVC//CompanyVC //HomeVC///EnterEmailVC
            self.navigationController?.setViewControllers([vc!], animated: true)
        }
        
    }
    
    
    
    func companyrole() {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController //SelectCompanyVC//CompanyVC //HomeVC///EnterEmailVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func ContractorRole() {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController//CompanyVC //HomeVC///EnterEmailVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func providorRole() {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController//CompanyVC //HomeVC///EnterEmailVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func moveOnEnterEmail() {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Main.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"EnterEmailVC") as? EnterEmailVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func moveOnVerificationCode() {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"VerificationCodeVC") as? VerificationCodeVC
        vc?.email = ShareData.shareInfo.Email ?? ""
        vc?.isfrom = true
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    
    func companyContract() {
        userhandler.getContractByUserID(id: ShareData.shareInfo.obj?.id ?? "") { responce in
            if responce?.success == true {
                ShareData.shareInfo.saveContract(contract: responce?.data)
                UserDefaults.standard.save(customObject: responce?.data, inKey: "UserContractWithCompany")
            }
            if let responceRoleId = responce?.data?.role?.id {
                let storyBoard = UIStoryboard.init(name: StoryBoards.Main.rawValue, bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"EmployeeInformationViewController") as? EmployeeInformationViewController
                vc?.roleID = responceRoleId
                self.navigationController?.setViewControllers([vc!], animated: true)
            }
            else {
                let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController
                self.navigationController?.setViewControllers([vc!], animated: true)
            }
        } Failure: { error in
            let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController //SelectCompanyVC//CompanyVC //HomeVC///EnterEmailVC
            self.navigationController?.setViewControllers([vc!], animated: true)
        }
        
    }
    
}

