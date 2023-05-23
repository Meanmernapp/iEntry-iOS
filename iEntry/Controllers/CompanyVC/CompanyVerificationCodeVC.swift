//
//  CompanyVerificationCodeVC.swift
//  iEntry
//
//  Created by ZAFAR on 14/09/2021.
//

import UIKit
import XLPagerTabStrip
class CompanyVerificationCodeVC: BaseController, UITextFieldDelegate,IndicatorInfoProvider {
    //MARK:- tab delegate
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TOKEN".localized)
    }
    @IBOutlet weak var lbltokentitle: UILabel!
    @IBOutlet weak var lblusername: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    //MARK:- here are iboutlet
    @IBOutlet weak var roleTxt: UILabel!
    @IBOutlet weak var mainView: UIView!
    //@IBOutlet weak var btncode: UIButton!
    @IBOutlet weak var usrimg: UIImageView!
    @IBOutlet weak var txtSix: UITextField!
    @IBOutlet weak var txtFive: UITextField!
    @IBOutlet weak var txtFour: UITextField!
    @IBOutlet weak var txtThree: UITextField!
    @IBOutlet weak var txtTwo: UITextField!
    @IBOutlet weak var txtOne: UITextField!
    @IBOutlet weak var CodeViewOne: UIView!
    @IBOutlet weak var CodeViewTwo: UIView!
    @IBOutlet weak var CodeViewThree: UIView!
    @IBOutlet weak var CodeViewFour: UIView!
    @IBOutlet weak var CodeViewFive: UIView!
    @IBOutlet weak var CodeViewSix: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    
    var otpTex = ""
    var loginVM = LoginViewModel()
    var tokenData : SixDigitCodeModel?
    private var timer: Timer?
    var count = 1*5 //59
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbltokentitle.text = "TOKEN DE ACCESO".localized
        self.bottomView.isHidden = true
        if ShareData.shareInfo.obj?.userType?.name == "EMPLOYEE" {
            if myDefaultLanguage == .en {
                self.roleTxt.text = "EMPLOYEE"
            } else {
                self.roleTxt.text = "EMPLEADO"
            }
        } else if ShareData.shareInfo.obj?.userType?.name == "GUEST"  {
            if myDefaultLanguage == .en {
                self.roleTxt.text = "GUEST"
            } else {
                self.roleTxt.text = "INVITADO"
            }
        }else if ShareData.shareInfo.obj?.userType?.name == "CONTRACTOR_IN_CHARGE"  {
            if myDefaultLanguage == .en {
                self.roleTxt.text = "CONTRACTOR IN CHARGE"
            } else {
                self.roleTxt.text = "CONTRATISTA A CARGO"
            }
        }
        else if ShareData.shareInfo.obj?.userType?.name == "CONTRACTORS_EMPLOYEE"  {
            if myDefaultLanguage == .en {
                self.roleTxt.text = "CONTRACTORS EMPLOYEE"
            } else {
                self.roleTxt.text = "EMPLEADO DE CONTRATISTA"
            }
        }
        else if ShareData.shareInfo.obj?.userType?.name == "PROVIDER_IN_CHARGE"  {
            if myDefaultLanguage == .en {
                self.roleTxt.text = "PROVIDER IN CHARGE"
            } else {
                self.roleTxt.text = "PROVEEDOR A CARGO"
            }
        }
        else if ShareData.shareInfo.obj?.userType?.name == "PROVIDER_EMPLOYEE"  {
            if myDefaultLanguage == .en {
                self.roleTxt.text = "PROVIDER EMPLOYEE"
            } else {
                self.roleTxt.text = "EMPLEADO DE PROVEEDOR"
            }
        }
        
        self.lblusername.text = ShareData.shareInfo.obj?.name
        self.lbltime.text = self.getCurrentTime()
        self.lbldate.text = self.getCurrentDate()
        mainView.shadowAndRoundcorner(cornerRadius: 5, shadowColor: #colorLiteral(red: 0.8626509309, green: 0.8627994061, blue: 0.8626416326, alpha: 1), shadowRadius: 2.0, shadowOpacity: 1)
        self.navigationBarHidShow(isTrue: true)
        self.usrimg.roundViiew()
        
        txtOne.delegate = self
        txtTwo.delegate = self
        txtThree.delegate = self
        txtFour.delegate = self
        txtFive.delegate = self
        txtSix.delegate = self
        
        txtOne.textContentType = .oneTimeCode
        txtTwo.textContentType = .oneTimeCode
        txtThree.textContentType = .oneTimeCode
        txtFour.textContentType = .oneTimeCode
        txtFive.textContentType = .oneTimeCode
        txtSix.textContentType = .oneTimeCode
        //txtOne.becomeFirstResponder()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.placeHolder()
        if Network.isAvailable {
            self.geneRateOtpApiCall()
        } else{
            AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
            
        }
        DispatchQueue.main.async {
            if let image = Global.shared.selfiImage {
                self.userImg.image = image
            }
            else {
                self.userImg.image = UIImage(named: "user-png")!
            }
            
            
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
        timer = nil
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
        timer = nil
    }
    
    
    
    @IBAction func menuAction(_ sender: UIButton) {
        
        let manager = ZSideMenuManager(isRTL: false)
        manager.openSideMenu(vc: self)
        timer?.invalidate()
        timer = nil
    }
    
    
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        self.geneRateOtpApiCall()
    }
    
    //MARK:- this funtion to start timer
    func startTime() {
        
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    //MARK:- stop the timer
    @objc func updateTimer() {
        if count > 0 {
            count -= 1
            // lbltimedetail.text = "Valido por los siguientes \(count),s segundos."
        } else {
            timer?.invalidate()
            timer = nil
            // lbltimedetail.text = "Resend Code"
            if Network.isAvailable {
                self.geneRateOtpApiCall()
            } else{
                AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
                
            }
        }
    }
    
    
    
    //MARK:- this funtion use to generate the otp
    func geneRateOtpApiCall() {
        userhandler.getSixDigitCode(Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.count = 1*5 //59
                self.startTime()
                self.tokenData = response
                
                let token = "\(self.tokenData?.data ?? "")"
                print("my token new:",token.digits)
                self.assigntoken(arr: token.digits)
            } else {
                self.placeHolder()
                
                
            }
        }, Failure: {error in
            self.hidLoader()
            self.placeHolder()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    //MARK:- assignening OTP
    func assigntoken(arr:[Int]){
        txtOne.text = "\(arr[0])"
        txtTwo.text = "\(arr[1])"
        txtThree.text = "\(arr[2])"
        txtFour.text = "\(arr[3])"
        txtFive.text = "\(arr[4])"
        txtSix.text = "\(arr[5])"
        //txtSix.becomeFirstResponder()
    }
    func placeHolder() {
        self.txtOne.placeholder = "0"
        self.txtTwo.placeholder = "0"
        self.txtThree.placeholder = "0"
        self.txtFour.placeholder = "0"
        self.txtFive.placeholder = "0"
        self.txtSix.placeholder = "0"
    }
    
    //MARK:- textfield delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
        // Range.length == 1 means,clicking backspace
        if (range.length == 0){
            if textField == txtOne {
                //txtTwo?.becomeFirstResponder()
            }
            if textField == txtTwo {
                //txtThree?.becomeFirstResponder()
            }
            if textField == txtThree {
                //txtFour?.becomeFirstResponder()
            }
            if textField == txtFour {
                //txtFive?.becomeFirstResponder()
            }
            if textField == txtFive {
                //txtSix?.becomeFirstResponder()
            }
            
            
            if textField == txtSix {
                //txtSix?.resignFirstResponder()
                /*After the otpbox6 is filled we capture the All the OTP textField and do the server call. If you want to capture the otpbox6 use string.*/
                self.otpTex = "\((txtOne?.text)!)\((txtTwo?.text)!)\((txtThree?.text)!)\((txtFour?.text)!)\((txtFive?.text)!)\(string)"
                
                
            }
            textField.text? = string
            return false
        }else if (range.length == 1) {
            if textField == txtSix {
                //txtFive?.becomeFirstResponder()
            }
            if textField == txtFive {
                //txtFour?.becomeFirstResponder()
            }
            if textField == txtFour {
                //txtThree?.becomeFirstResponder()
            }
            if textField == txtThree {
                //txtTwo?.becomeFirstResponder()
            }
            if textField == txtTwo {
                //txtOne?.becomeFirstResponder()
            }
            if textField == txtOne {
                //txtOne?.resignFirstResponder()
            }
            textField.text? = ""
            return false
        }
        return true
    }
    
    
    
    
    func dismissKeyboard(){
        
        self.otpTex = "\(self.txtOne.text ?? "")\(self.txtTwo.text ?? "")\(self.txtThree.text ?? "")\(self.txtFour.text ?? "")\(self.txtFive.text ?? "")\(self.txtSix.text ?? "")"
        
        print(self.otpTex)
        self.view.endEditing(true)
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController
        self.navigationController?.setViewControllers([vc!], animated: true)
    }
    
    func verifycode(){
        self.showLoader()
        userhandler.verifySixDigitCode(Success: {response in
            self.hidLoader()
            if response?.success == true {
                
                self.navigationController?.popViewController(animated: true)
                AppUtility.showSuccessMessage(message: response?.message ?? "")
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    
    
    @IBAction func sendCodeAction(_ sender: UIButton) {
        if Network.isAvailable {
            verifycode()
        }
        else {
            AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
        }
        
    }
    
}
