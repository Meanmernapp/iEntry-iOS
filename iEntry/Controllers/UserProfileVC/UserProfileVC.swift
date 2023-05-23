//
//  UserProfileVC.swift
//  iEntry
//
//  Created by ZAFAR on 24/08/2021.
//

import UIKit
import SDWebImage
class UserProfileVC: BaseController {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var lblspanishtitle: UILabel!
    @IBOutlet weak var btninformation: UIButton!
    @IBOutlet weak var lbldevicetitle: UILabel!
    @IBOutlet weak var lblbiomatrictitle: UILabel!
    @IBOutlet weak var lblaccetypetitle: UILabel!
    @IBOutlet weak var lblextradatatitle: UILabel!
    @IBOutlet weak var lblgendertitle: UILabel!
    @IBOutlet weak var lblnametitle: UILabel!
    @IBOutlet weak var lbldateofBirhTitle: UILabel!
    @IBOutlet weak var lblpasswordtitle: UILabel!
    @IBOutlet weak var lblinformationpersonaltitle: UILabel!
    @IBOutlet weak var lblpersonalinfotitle: UILabel!
    @IBOutlet weak var lbltypeAccess: UILabel!
    @IBOutlet weak var hideshowtype: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblLastname: UILabel!
    @IBOutlet weak var lblSecondLastName: UILabel!
    @IBOutlet weak var lblpassword: UILabel!
    @IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lbllanguage: UILabel!
    @IBOutlet weak var lblmailtitle: UILabel!
    @IBOutlet weak var liveSessionBtn: UISwitch!
    @IBOutlet weak var liveSessionLbl: UILabel!
    @IBOutlet weak var lblgender: UILabel!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var extradataicon: UIImageView!
    @IBOutlet weak var lblenglishtitle: UILabel!
    @IBOutlet weak var lblphonetitle: UILabel!
    @IBOutlet weak var spanishView: UIView!
    @IBOutlet weak var btnswitch: UISwitch!
    @IBOutlet weak var btnextradata: UIButton!
    @IBOutlet weak var frechView: UIView!
    @IBOutlet weak var englishView: UIView!
    @IBOutlet weak var extraData: UIStackView!
    @IBOutlet weak var lblphone: UILabel!
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var lastNameTitleLbl: UILabel!
    @IBOutlet weak var secondLastNameLbl: UILabel!
    //MARK: - Headers Outlet
    
    @IBOutlet weak var header1: UILabel!
    @IBOutlet weak var header2: UILabel!
    @IBOutlet weak var header3: UILabel!
    @IBOutlet weak var header4: UILabel!
    @IBOutlet weak var header5: UILabel!
    @IBOutlet weak var header6: UILabel!
    @IBOutlet weak var header7: UILabel!
    @IBOutlet weak var header8: UILabel!
    @IBOutlet weak var header9: UILabel!
    @IBOutlet weak var header10: UILabel!
    @IBOutlet weak var header11: UILabel!
    @IBOutlet weak var header12: UILabel!
    @IBOutlet weak var header13: UILabel!
    @IBOutlet weak var header14: UILabel!
    @IBOutlet weak var header15: UILabel!
    
    
    //MARK: - HeadersLbl Outlets
    
    @IBOutlet weak var header1Lbl: UILabel!
    @IBOutlet weak var header2Lbl: UILabel!
    @IBOutlet weak var header3Lbl: UILabel!
    @IBOutlet weak var header4Lbl: UILabel!
    @IBOutlet weak var header5Lbl: UILabel!
    @IBOutlet weak var header6Lbl: UILabel!
    @IBOutlet weak var header7Lbl: UILabel!
    @IBOutlet weak var header8Lbl: UILabel!
    @IBOutlet weak var header9Lbl: UILabel!
    @IBOutlet weak var header10Lbl: UILabel!
    @IBOutlet weak var header11Lbl: UILabel!
    @IBOutlet weak var header12Lbl: UILabel!
    @IBOutlet weak var header13Lbl: UILabel!
    @IBOutlet weak var header14Lbl: UILabel!
    @IBOutlet weak var header15Lbl: UILabel!
    
    //MARK: - Top Menu
    
    @IBOutlet weak var contractView: UIView!
    @IBOutlet weak var contractLbl: UILabel!
    @IBOutlet weak var contractMainView: UIView!
    @IBOutlet weak var profileMainView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileLbl: UILabel!
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contractorView: UIView!
    
    //MARK: - Contract Outlet
    @IBOutlet weak var contractorName: UILabel!
    @IBOutlet weak var contractorRole: UILabel!
    @IBOutlet weak var departmentName: UILabel!
    @IBOutlet weak var contractorZoneName: UILabel!
    @IBOutlet weak var contractDates: UILabel!
    @IBOutlet weak var contractBeginning: UILabel!
    @IBOutlet weak var contractEnd: UILabel!
    
    @IBOutlet weak var contractortypeLbl: UILabel!
    @IBOutlet weak var contractRoleLbl: UILabel!
    @IBOutlet weak var contractorBegningLbl: UILabel!
    @IBOutlet weak var contractBeginningLbl : UILabel!
    @IBOutlet weak var contractEndLbl : UILabel!
    //MARK: - Variables
    
    var isenglish = true
    var isespainssion = true
    var isfrench = true
    var istypeAccess =  true
    var langugge = "es"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if ShareData.shareInfo.userRole == .employees {
            setupContract()
        }
        setupProfile()
        if let image = Global.shared.selfiImage {
            self.userimg.image = image
            self.backGroundImage.image =  image
        }
        else
        {
            self.userimg.image = UIImage(named: "user-png")!
            self.backGroundImage.image =  UIImage(named: "user-png")!
        }

        
        if ShareData.shareInfo.headersData == nil {
            self.getHeaders()
        }
        else {
            self.setupHeaders()
        }
        if ShareData.shareInfo.userRole == .employees {
            if ShareData.shareInfo.conractWithCompany?.role?.roleRestriction?.extraDataEmployee == true  {
                // if its true then he can see
                self.extraData.isHidden = false
                if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 12 })) != nil {
                    // he is also able to edit
                    
                    btninformation.isHidden = false
                    btnextradata.isHidden = false
                    extradataicon.isHidden = false
                } else {
                    //he is not able to edit
                    btninformation.isHidden = true
                    btnextradata.isHidden = true
                    extradataicon.isHidden = true
                }
                
            }  else {
                // he is not able to see
                self.extraData.heightAnchor.constraint(equalToConstant: 0).isActive = true
                
                self.extraData.isHidden = true
                btnextradata.isHidden = true
                extradataicon.isHidden = true
            }
        } else {
            if ShareData.shareInfo.userRole == .contractor || ShareData.shareInfo.userRole == .provider {
                // able to edit
                
                btninformation.isHidden = false
                btnextradata.isHidden = false
                extradataicon.isHidden = false
                
                if ShareData.shareInfo.userCompanyRestrictionData?.extraDataExternal == true {
                    //extra data show
                    self.extraData.isHidden = false
                    
                }
                else {
                    // extra data hide
                    self.extraData.heightAnchor.constraint(equalToConstant: 0).isActive = true
                    self.extraData.isHidden = true
                    btnextradata.isHidden = true
                    extradataicon.isHidden = true
                }
                
                
            } else {
                
                btninformation.isHidden = true
                btnextradata.isHidden = true
                extradataicon.isHidden = true
            }
            
        }
        
        
        
        if ShareData.shareInfo.saveLanguage == "en" {
            //englishAction(UIButton())
            isfrench = false
            isespainssion = false
            isenglish = true
            
            englishimg.image = UIImage(named: "ic-check-2")
            frenchimg.image = UIImage(named: "")
            espainimg.image = UIImage(named: "")
            ShareData.shareInfo.saveLanguage = "en"
            myDefaultLanguage = .en
        } else if ShareData.shareInfo.saveLanguage == "es" {
            //espanission(UIButton())
            
            isfrench = false
            isespainssion = true
            isenglish = false
            
            englishimg.image = UIImage(named: "")
            frenchimg.image = UIImage(named: "")
            espainimg.image = UIImage(named: "ic-check-2")
            ShareData.shareInfo.saveLanguage = "es"
            myDefaultLanguage = .es
        }
        else {
            isfrench = true
            isespainssion = false
            isenglish = false
            
            englishimg.image = UIImage(named: "")
            frenchimg.image = UIImage(named: "ic-check-2")
            espainimg.image = UIImage(named: "")
            ShareData.shareInfo.saveLanguage = "fr"
            myDefaultLanguage = .fr
        }
        
        
        
        self.lblpersonalinfotitle.text = "Datos".localized
        
        self.lblinformationpersonaltitle.text = "Información personal".localized.uppercased()
        
        self.lblnametitle.text = "Nombre".localized
        self.lblpasswordtitle.text = "Contraseña".localized
        self.lblmailtitle.text = "Correo".localized
        self.lblphonetitle.text = "Celular".localized
        self.lbldateofBirhTitle.text = "Fecha de cumpleaños".localized
        self.lastNameTitleLbl.text = "apellido".localized
        self.secondLastNameLbl.text = "Primer apellido".localized
        self.lblgendertitle.text = "Género".localized
        self.lblextradatatitle.text = "Información extra".localized.uppercased()
        
        self.lbllanguage.text = "Idiomas".localized
        
        self.lblspanishtitle.text = "Español".localized
        self.lblenglishtitle.text = "Ingles".localized
        self.lblaccetypetitle.text = "Tipo de Acceso".localized
        self.lblbiomatrictitle.text = "Use biometrics store in the phone".localized
        self.lbldevicetitle.text = "DESVINCULAR DISPOSITIVO".localized
        if ShareData.shareInfo.isBiomatric == true {
            btnswitch.isOn = true
        } else {
            btnswitch.isOn = false
        }
        if ShareData.shareInfo.isLiveSession == true {
            liveSessionBtn.isOn = true
        } else {
            liveSessionBtn.isOn = false
        }
        
        self.navigationBarHidShow(isTrue: true)
        mainView.roundCorners([.topLeft,.topRight], radius: 20)
        userimg.roundViiew()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupProfile()
        if ShareData.shareInfo.obj != nil {
            
            self.setDate()
        }
        
        if Network.isAvailable {
            print("Internet connection OK")
            
            getUserInfo()
            self.setDate()
        } else {
            print("Internet connection FAILED")
            self.setDate()
        }
        
        
    }
    
    func setupProfile() {
        let profileTap = UITapGestureRecognizer(target: self, action: #selector(self.profileTap(_:)))
        self.profileMainView.isUserInteractionEnabled = true
        self.profileMainView.addGestureRecognizer(profileTap)
        let contractorTap = UITapGestureRecognizer(target: self, action: #selector(self.contractorTap(_:)))
        self.contractMainView.isUserInteractionEnabled = true
        self.contractMainView.addGestureRecognizer(contractorTap)
        mainView.isHidden = false
        contractorView.isHidden = true
        if ShareData.shareInfo.userRole == .employees {
            stackViewHeight.constant = 50
            profileView.backgroundColor = UIColor(named: "primary")
            profileLbl.textColor = UIColor(named: "primary")
        }
        else {
            stackViewHeight.constant = 0
        }
    }
    
    func setupContract() {
        self.contractRoleLbl.text = "Rol".localized
        self.contractorBegningLbl.text = "Fechas de Contrato".localized
        self.contractBeginningLbl.text = "Inicio".localized
        self.contractEndLbl.text = "Fin".localized
        if let contract = ShareData.shareInfo.contractDataV2 {
            self.contractorName.text = contract.employeeId.putDashes()
            self.departmentName.text = contract.departmentName.putDashes()
            self.contractorZoneName.text = contract.zoneName.putDashes()
            self.contractorRole.text = contract.roleName.putDashes()
            self.contractDates.text = "---"
            self.contractBeginning.text = self.getMilisecondstoDate(seconds: "\(contract.startDate ?? 0)", formatter: "")
            self.contractEnd.text = self.getMilisecondstoDate(seconds: "\(contract.endDate ?? 0)", formatter: "")
        }
    }
    
    @objc func profileTap(_ sender: UITapGestureRecognizer) {
        mainView.isHidden = false
        contractorView.isHidden = true
        profileView.backgroundColor = UIColor(named: "primary")
        profileLbl.textColor = UIColor(named: "primary")
        contractLbl.textColor = UIColor(named: "lightColor")
        contractView.backgroundColor = .clear
    }
    
    @objc func contractorTap(_ sender: UITapGestureRecognizer) {
        mainView.isHidden = true
        contractorView.isHidden = false
        profileView.backgroundColor = .clear
        profileLbl.textColor = UIColor(named: "lightColor")
        contractLbl.textColor = UIColor(named: "primary")
        contractView.backgroundColor = UIColor(named: "primary")
    }
    
    func getHeaders() {
        userhandler.getExtraDataHeaders { responce in
            if responce?.success == true {
                ShareData.shareInfo.headersData = responce?.data
                self.setupHeaders()
            }
            else {
//                AppUtility.showErrorMessage(message: "Headers fething failed")
            }
            
            
        } Failure: { error in
//            AppUtility.showErrorMessage(message: "Headers fething failed")
        }
        
    }
    func setupHeaders() {
        self.header1.text = ShareData.shareInfo.headersData?.header1
        self.header2.text = ShareData.shareInfo.headersData?.header2
        self.header3.text =  ShareData.shareInfo.headersData?.header3
        self.header4.text = ShareData.shareInfo.headersData?.header4
        self.header5.text = ShareData.shareInfo.headersData?.header5
        self.header6.text = ShareData.shareInfo.headersData?.header6
        self.header7.text = ShareData.shareInfo.headersData?.header7
        self.header8.text = ShareData.shareInfo.headersData?.header8
        self.header9.text = ShareData.shareInfo.headersData?.header9
        self.header10.text =  ShareData.shareInfo.headersData?.header10
        self.header11.text = ShareData.shareInfo.headersData?.header11
        self.header12.text = ShareData.shareInfo.headersData?.header12
        self.header13.text = ShareData.shareInfo.headersData?.header13
        self.header14.text = ShareData.shareInfo.headersData?.header14
        self.header15.text = ShareData.shareInfo.headersData?.header15
    }
    
    func setDate() {
        
        self.lblname.text =  ShareData.shareInfo.obj?.name.putDashes()
        self.lblSecondLastName.text = ShareData.shareInfo.obj?.secondLastName.putDashes()
        self.lblLastname.text = ShareData.shareInfo.obj?.lastName.putDashes()
        self.lblemail.text =  ShareData.shareInfo.obj?.email.putDashes()
        self.lblphone.text = ShareData.shareInfo.obj?.phoneNumber.putDashes()
        self.lblgender.text = ShareData.shareInfo.obj?.gender?.name.putDashes()
        self.lblDOB.text = ShareData.shareInfo.obj?.dob?.getDateStringFromUTC().putDashes()
        self.lblpassword.text = "*********" //ShareData.shareInfo.obj?.user?.password
        
        //MARK: - Headers
        
        
        //MARK: - Headers Fields
        
        self.header1Lbl.text = ShareData.shareInfo.obj?.extraData?.field1
        self.header2Lbl.text = ShareData.shareInfo.obj?.extraData?.field2
        self.header3Lbl.text =  ShareData.shareInfo.obj?.extraData?.field3
        self.header4Lbl.text = ShareData.shareInfo.obj?.extraData?.field4
        self.header5Lbl.text = ShareData.shareInfo.obj?.extraData?.field5
        self.header6Lbl.text = ShareData.shareInfo.obj?.extraData?.field6
        self.header7Lbl.text = ShareData.shareInfo.obj?.extraData?.field7
        self.header8Lbl.text = ShareData.shareInfo.obj?.extraData?.field8
        self.header9Lbl.text = ShareData.shareInfo.obj?.extraData?.field9
        self.header10Lbl.text =  ShareData.shareInfo.obj?.extraData?.field10
        self.header11Lbl.text = ShareData.shareInfo.obj?.extraData?.field11
        self.header12Lbl.text = ShareData.shareInfo.obj?.extraData?.field12
        self.header13Lbl.text = ShareData.shareInfo.obj?.extraData?.field13
        self.header14Lbl.text = ShareData.shareInfo.obj?.extraData?.field14
        self.header15Lbl.text = ShareData.shareInfo.obj?.extraData?.field15
    }
    
    
    func getUserInfo(){
        //        showLoader()
        userhandler.getUser(id: ShareData.shareInfo.obj?.id ?? "", Success: {response in
            //            self.hidLoader()
            ShareData.shareInfo.saveUser(user: response?.data)
            self.getUSerImageByIDApi()
            UserDefaults.standard.save(customObject: response?.data, inKey: "user")
            self.setDate()
            
        }, Failure: {error in
            //            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    func getUSerImageByIDApi(){
        if let base =  ShareData.shareInfo.obj?.selfie {
            if let image = self.convierteImagen(base64String: base) {
                self.userimg.image = image
                self.backGroundImage.image = image
                Global.shared.selfiImage = image
            }
        }
        else {
            Global.shared.selfiImage = UIImage(named: "user-png")!
//            getUSerImageByIDApii()
        }
    }
    
    
    @IBAction func accessType(_ sender: UIButton) {
        if istypeAccess == true {
            self.lbltypeAccess.text = ShareData.shareInfo.obj?.userType?.name
            self.hideshowtype.image = UIImage(named: "eye-regular")
        } else {
            self.lbltypeAccess.text = "*****"
            self.hideshowtype.image = UIImage(named: "HideEye")
        }
        self.istypeAccess = !istypeAccess
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        if sender.isOn == true {
            AppUtility.showInfoMessage(message: "lb_value_access_with_biometrics".localized + "lb_title_enable".localized)
            ShareData.shareInfo.isBiomatric = true
        } else {
            AppUtility.showInfoMessage(message: "lb_value_access_with_biometrics".localized + "lb_title_disable".localized)
            ShareData.shareInfo.isBiomatric = false
            
        }
    }
    
    @IBAction func liveSwitchAction(_ sender: UISwitch) {
        if sender.isOn == true {
            AppUtility.showInfoMessage(message: "lb_value_keep_session_alive".localized + ": " + "lb_title_enable".localized)
            ShareData.shareInfo.isLiveSession = true
        } else {
            AppUtility.showInfoMessage(message: "lb_value_keep_session_alive".localized + ": " + "lb_title_disable".localized)
            ShareData.shareInfo.isLiveSession = false
            
        }
    }
    @IBAction func personalInfoAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"UserPersonalInfoVC") as? UserPersonalInfoVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBOutlet weak var englishimg: UIImageView!
    @IBOutlet weak var frenchimg: UIImageView!
    @IBOutlet weak var espainimg: UIImageView!
    
    
    @IBAction func logoutAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"LogOutPopUpVC") as? LogOutPopUpVC
        
        vc?.callBack = {
            //            if Network.isAvailable {
            self.langugge = ShareData.shareInfo.saveLanguage ?? "es"
            Global.shared.isFromLogout = true
            self.clearAllUserDefaults()
            ShareData.shareInfo.saveLanguage = self.langugge
            let storyBoard = UIStoryboard.init(name: StoryBoards.Main.rawValue, bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"LoginVC") as? LoginVC
            self.navigationController?.setViewControllers([vc!], animated: true)
            //            }
            //            else {
            //                AppUtility.showErrorMessage(message: "lb_error_can_not_log_out".localized)
            //            }
            
            
        }
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
        
        
        
        
    }
    
    
    @IBAction func infoAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"InformationVC") as? InformationVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func englishAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"LanguageChangeAlertVC") as? LanguageChangeAlertVC
        vc?.language = .en
        vc?.modalPresentationStyle = .overFullScreen
        vc?.callBack = {
            self.isfrench = false
            self.isespainssion = false
            self.isenglish = true
            self.englishimg.image = UIImage(named: "ic-check-2")
            self.frenchimg.image = UIImage(named: "")
            self.espainimg.image = UIImage(named: "")
            ShareData.shareInfo.saveLanguage = "en"
            myDefaultLanguage = .en
            self.view.setNeedsLayout()
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
            self.viewDidLoad()
        }
        self.present(vc!, animated: false, completion: nil)
        
    }
    
    @IBAction func espanission(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"LanguageChangeAlertVC") as? LanguageChangeAlertVC
        vc?.language = .es
        vc?.modalPresentationStyle = .overFullScreen
        vc?.callBack = {
            self.isfrench = false
            self.isespainssion = true
            self.isenglish = false
            self.englishimg.image = UIImage(named: "")
            self.frenchimg.image = UIImage(named: "")
            self.espainimg.image = UIImage(named: "ic-check-2")
            ShareData.shareInfo.saveLanguage = "es"
            myDefaultLanguage = .es
            self.view.setNeedsLayout()
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
            self.viewDidLoad()
        }
        self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func frenchAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"LanguageChangeAlertVC") as? LanguageChangeAlertVC
        vc?.language = .fr
        vc?.modalPresentationStyle = .overFullScreen
        vc?.callBack = {
            self.isfrench = true
            self.isespainssion = false
            self.isenglish = false
            self.englishimg.image = UIImage(named: "")
            self.frenchimg.image = UIImage(named: "ic-check-2")
            self.espainimg.image = UIImage(named: "")
            ShareData.shareInfo.saveLanguage = "fr"
            myDefaultLanguage = .fr
            self.view.setNeedsLayout()
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
            self.viewDidLoad()
        }
        self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func LinkDeviceAction(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationDownloadImageAlertVC") as? NotificationDownloadImageAlertVC
        vc?.titlofDialog = "DESVINCULAR DISPOSITIVO".localized
        vc?.detailofDialog = "¿Estas seguro que deseas desvincular este dispositivo? En automáico se cerrará tu sesión y se eliminaran los datos de esta aplicación.".localized
        vc?.acceptbuttontitle = "ACEPTAR".localized
        vc?.modalPresentationStyle = .overFullScreen
        vc?.callBack = { isok in
            vc?.dismiss(animated: true, completion: nil)
            self.unlinkUserDeviceApi()
            //self.navigationController?.popViewController(animated: true)
        }
        self.present(vc!, animated: false, completion: nil)
    }
    
    func unlinkUserDeviceApi(){
        self.showLoader()
        userhandler.unLinkUserDevice(userID: ShareData.shareInfo.obj?.id ?? "", Success:{ response in
            self.hidLoader()
            if response?.success == true  {
                self.langugge = ShareData.shareInfo.saveLanguage ?? "es"
                Global.shared.isFromLogout = true
                self.clearAllUserDefaults()
                ShareData.shareInfo.saveLanguage = self.langugge
                let storyBoard = UIStoryboard.init(name: StoryBoards.Main.rawValue, bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"LoginVC") as? LoginVC
                //                ShareData.shareInfo.saveUser(user: nil)
                //                ShareData.shareInfo.saveContract(contract: nil)
                //                let defaults = UserDefaults.standard
                //                defaults.set(nil, forKey: "checkuserExist")
                //                defaults.set(nil, forKey: "contractList")
                //                defaults.set(nil, forKey: "contractorData")
                //                defaults.set(nil, forKey: "notification")
                //                defaults.set(nil, forKey: "contactList")
                //                defaults.set(nil, forKey: "contractorData")
                //                defaults.set(nil, forKey: "providerEmployeeData")
                //                defaults.set(nil, forKey: "contractorEmployeeData")
                //                defaults.set(nil, forKey: "invitation")
                //                defaults.set(nil, forKey: "UserContractWithCompany")
                //                defaults.set(nil, forKey: "userRestriction")
                //                ShareData.shareInfo.password = nil
                //                ShareData.shareInfo.Email = nil
                //                ShareData.shareInfo.token = nil
                //                ShareData.shareInfo.fcmToken = nil
                self.navigationController?.setViewControllers([vc!], animated: true)
                AppUtility.showSuccessMessage(message: response?.message ?? "")
                
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    
}

