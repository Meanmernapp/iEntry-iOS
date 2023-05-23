//
//  UserPersonalInfoVC.swift
//  iEntry
//
//  Created by ZAFAR on 24/08/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import DropDown
import SMDatePicker
class UserPersonalInfoVC: BaseController ,UITextFieldDelegate,SMDatePickerDelegate{
    
    
    //MARK: - IBOutlets
    
    
    @IBOutlet weak var btndropdown: UIButton!
    @IBOutlet weak var lblupdatetitle: UILabel!
    @IBOutlet weak var btnupdate: UIButton!
    @IBOutlet weak var lblinformationtitle: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var eyeButton: UIButton!
    //@IBOutlet weak var txtCURP: MDCOutlinedTextField!
    @IBOutlet weak var txtDob: MDCOutlinedTextField!
    @IBOutlet weak var ttxphoneNumber: MDCOutlinedTextField!
    @IBOutlet weak var txtemail: MDCOutlinedTextField!
    @IBOutlet weak var txtpassword: MDCOutlinedTextField!
    @IBOutlet weak var txtgender: MDCOutlinedTextField!
    //@IBOutlet weak var txtactive: MDCOutlinedTextField!
    @IBOutlet weak var txtname: MDCOutlinedTextField!
    //@IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblLastname: MDCOutlinedTextField!
    @IBOutlet weak var lblSecondLastName: MDCOutlinedTextField!
    
    
    //MARK: - Variables
    
    var MainDrowpDown = DropDown()
    var timeInMiliSec = ShareData.shareInfo.obj?.dob ?? 0
    var myDatePicker: SMDatePicker = SMDatePicker()
    
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtpassword.isSecureTextEntry = true
        self.lblinformationtitle.font = UIFont(name: "Montserrat-Bold", size: 20)
        self.lblinformationtitle.text = "I N F O R M A T I Ó N".localized
        //        self.lblinformationtitle.text = "Información".localized
        configData()
        self.navigationBarHidShow(isTrue: true)
        mainView.roundCorners([.topLeft,.topRight], radius: 20)
        self.lblupdatetitle.text = "ACTUALIZAR DATOS".localized
        
        bottomView.roundViewWithCustomRadius(radius:8 )
        
        setMDCTxtFieldDesign(txtfiled: txtname, Placeholder: "NOMBRE".localized, imageIcon: UIImage(named: "user-regular")!)
        setMDCTxtFieldDesign(txtfiled: lblLastname, Placeholder: "apellido".localized.uppercased(), imageIcon: UIImage(named: "user-regular")!)
        setMDCTxtFieldDesign(txtfiled: lblSecondLastName, Placeholder: "Primer apellido".localized.uppercased(), imageIcon: UIImage(named: "user-regular")!)
        //setMDCTxtFieldDesign(txtfiled: txtactive, Placeholder: "Activo", imageIcon: UIImage(named: "sort-down-solid")!)
        setMDCTxtFieldDesign(txtfiled: txtgender, Placeholder: "Masculino".localized, imageIcon: UIImage(named: "sort-down-solid")!)
        setMDCTxtFieldDesign(txtfiled: txtpassword, Placeholder: "CONTRASEÑA".localized, imageIcon: UIImage(named: "eye-regular")!)
        setMDCTxtFieldDesign(txtfiled: txtemail, Placeholder: "CORREO".localized, imageIcon: UIImage(named: "ic-invitation")!)
        setMDCTxtFieldDesign(txtfiled: ttxphoneNumber, Placeholder: "NO CELULAR".localized, imageIcon: UIImage(named: "mobile-alt-solid")!)
        setMDCTxtFieldDesign(txtfiled: txtDob, Placeholder: "CUMPLEAÑOS".localized, imageIcon: UIImage(named: "ic-calendar-1")!)
        //setMDCTxtFieldDesign(txtfiled: txtCURP, Placeholder: "CURP", imageIcon: UIImage())
        txtDob.delegate = self
        
        txtpassword.delegate = self
    }
    
    
    //MARK: - Functions
    
    func configData(){
        txtDob.text = ShareData.shareInfo.obj?.dob?.getDateStringFromUTC()
        ttxphoneNumber.text = ShareData.shareInfo.obj?.phoneNumber
        txtemail.text = ShareData.shareInfo.obj?.email
        lblLastname.text = ShareData.shareInfo.obj?.lastName
        lblSecondLastName.text = ShareData.shareInfo.obj?.secondLastName
        //        txtpassword.text = "1234556"
        txtpassword.text = ShareData.shareInfo.password
//        self.txtpassword.isUserInteractionEnabled = false
        txtgender.text = ShareData.shareInfo.obj?.gender?.name
        txtname.text = ShareData.shareInfo.obj?.name
        
        //ShareData.shareInfo.contractData?.company?.id
        
        if ShareData.shareInfo.userRole == .contractoremplyee || ShareData.shareInfo.userRole == .provideremployee{
            btndropdown.isUserInteractionEnabled = false
            txtDob.isUserInteractionEnabled = false
            ttxphoneNumber.isUserInteractionEnabled = false
            txtemail.isUserInteractionEnabled = false
            txtpassword.isUserInteractionEnabled = false
            txtgender.isUserInteractionEnabled = false
            txtname.isUserInteractionEnabled = false
            lblSecondLastName.isUserInteractionEnabled = false
            lblLastname.isUserInteractionEnabled = false
            btnupdate.isUserInteractionEnabled = false
        } else {
            txtDob.isUserInteractionEnabled = true
            ttxphoneNumber.isUserInteractionEnabled = true
            txtemail.isUserInteractionEnabled = false
            txtpassword.isUserInteractionEnabled = true
            txtgender.isUserInteractionEnabled = true
            lblLastname.isUserInteractionEnabled = true
            lblSecondLastName.isUserInteractionEnabled = true
            //@IBOutlet weak var txtactive: MDCOutlinedTextField!
            txtname.isUserInteractionEnabled = true
            btnupdate.isUserInteractionEnabled = true
            btndropdown.isUserInteractionEnabled = true
        }
        
        
        
    }
    
    //MARK: - textfield delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtDob {
            hideKeyboard()
            self.datePickerConfig(DatePickerMood:.date)
            myDatePicker.showPickerInView(view, animated: true)
        }
    }
    
    
    
    //MARK: - general datepicker funtion
    func datePickerConfig(DatePickerMood:UIDatePicker.Mode) {
        myDatePicker.delegate = self
        myDatePicker.maximumDate = Date()
        myDatePicker.toolbarBackgroundColor = UIColor.white
        myDatePicker.pickerBackgroundColor = UIColor.white
        myDatePicker.pickerMode = DatePickerMood
        // Customize title
        myDatePicker.title = ""
        myDatePicker.titleFont = UIFont.systemFont(ofSize: 16)
        myDatePicker.titleColor = UIColor.white
        if #available(iOS 13.4, *) {
            myDatePicker.picker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        myDatePicker.picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        let cancel = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(canceleDatePicker))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action:#selector(onClickDoneButton))
        myDatePicker.leftButtons = [ cancel]
        myDatePicker.rightButtons = [doneButton]
    }
    @objc func canceleDatePicker() {
        /// myDatePicker.hidePicker(true)
        myDatePicker.pressedCancel(self)
    }
    
    //Toolbar done button function
    @objc func onClickDoneButton() {
        myDatePicker.hidePicker(true)
        
    }
    
    
    @objc func datePickerValueChanged(_ picker : UIDatePicker) {
        if picker.datePickerMode == .date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
            let stringDate = dateFormatter.string(from: picker.date)
            let timeInMiliSecDate = picker.date
            timeInMiliSec = StartDayMiliSeconds(newdate: timeInMiliSecDate) ?? 0
            print(timeInMiliSec)
            self.txtDob.text = stringDate
            
        }
    }
    
    
    //MARK: - datepicker delegates
    func  datePickerWillAppear(_ picker: SMDatePicker){
        print(picker.pickerDate)
        self.hideKeyboard()
        if picker.pickerMode == .date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
            let _ = dateFormatter.string(from: picker.pickerDate)
        }
    }
    
    func datePickerDidAppear(_ picker: SMDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let _ = dateFormatter.string(from: picker.pickerDate)
        
    }
    
    private func  datePicker(picker: SMDatePicker, didPickDate date: NSDate) {
        print(date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        let _ = picker.pickerDate
        timeInMiliSec = StartDayMiliSeconds(newdate: picker.pickerDate.startOfDay()!) ?? 0
        print(timeInMiliSec)
        self.txtDob.text = stringDate
    }
    func  datePickerDidCancel(_ picker: SMDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let _ = dateFormatter.string(from: picker.pickerDate)
        
    }
    
    func  datePickerWillDisappear(_ picker: SMDatePicker) {
        print(picker.pickerDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let _ = dateFormatter.string(from: picker.pickerDate)
        
    }
    func  datePickerDidDisappear(_ picker: SMDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let _ = dateFormatter.string(from: picker.pickerDate)
        
    }
    
    
    
    //MARK: - Functions
    
    
    func updateuserApi(){
        showLoader()
        var dic = [String:Any]()
        if self.txtpassword.text == ShareData.shareInfo.password {
            dic = ["id":ShareData.shareInfo.obj?.id ?? "","name":txtname.text!,"secondLastName":lblSecondLastName.text!,"lastName":lblLastname.text!,"phoneNumber":ttxphoneNumber.text!,"dob":self.timeInMiliSec,"email":txtemail.text!,"deviceId":UUID ?? "","firebaseId":ShareData.shareInfo.obj?.firebaseId ?? "","secret":ShareData.shareInfo.obj?.secret ?? "","gender":["id": txtgender.text!.lowercased() == "male" ? "1":"2"],"userType":["id":ShareData.shareInfo.obj?.userType?.id ?? 0],"status":["id":ShareData.shareInfo.obj?.status?.id ?? 0]]
        }
        else {
            dic = ["id":ShareData.shareInfo.obj?.id ?? "","name":txtname.text!,"secondLastName":lblSecondLastName.text!,"lastName":lblLastname.text!,"phoneNumber":ttxphoneNumber.text!,"dob":self.timeInMiliSec,"email":txtemail.text!,"password":self.txtpassword.text ?? "rootroot","deviceId":UUID ?? "","firebaseId":ShareData.shareInfo.obj?.firebaseId ?? "","secret":ShareData.shareInfo.obj?.secret ?? "","gender":["id": txtgender.text!.lowercased() == "male" ? "1":"2"],"userType":["id":ShareData.shareInfo.obj?.userType?.id ?? 0],"status":["id":ShareData.shareInfo.obj?.status?.id ?? 0]]
        }
        userhandler.updateuser(companyid: ShareData.shareInfo.contractData?.company?.id ?? "", param: dic, Success: {response in
            self.hidLoader()
            if response?.success == true {
                ShareData.shareInfo.saveUser(user: response?.data)
                UserDefaults.standard.save(customObject: response?.data, inKey: "user")
                self.navigationController?.popViewController(animated: true)
            } else {
                
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message:error.message)
        })
    }
    @IBAction func eyeButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            txtpassword.isSecureTextEntry = false
            setMDCTxtFieldDesign(txtfiled: txtpassword, Placeholder: "CONTRASEÑA".localized, imageIcon: UIImage(named: "HideEye")!)
        }
        else {
            txtpassword.isSecureTextEntry = true
            
            setMDCTxtFieldDesign(txtfiled: txtpassword, Placeholder: "CONTRASEÑA".localized, imageIcon: UIImage(named: "eye-regular")!)
        }
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        if checkDataChanges() {
            let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationDownloadImageAlertVC") as? NotificationDownloadImageAlertVC
            vc?.titlofDialog = "CAMBIOS EN EL PERFIL".localized
            vc?.detailofDialog = "Si sales sin guardar los cambios, todo lo registrado se perderá y tendrás nuevamente que volver a hacer los cambios. ¿Estás seguro que quieres descartar los cambios?".localized
            vc?.acceptbuttontitle = "ACEPTAR".localized
            vc?.modalPresentationStyle = .overFullScreen
            vc?.callBack = { isok in
                if Network.isAvailable {
                    print("Internet connection OK")
                    if self.checkData() {
                        self.updateuserApi()
                    }
                } else {
                    print("Internet connection FAILED")
                    AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
                    self.navigationController?.popViewController(animated: true)
                }
            }
            self.present(vc!, animated: false, completion: nil)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    func checkData() -> Bool {
        if txtname.text == ""{
            AppUtility.showErrorMessage(message: "lb_empty_event_name".localized)
            return false
            
        }
        if lblLastname.text == ""{
            AppUtility.showErrorMessage(message: "lb_warning_invalid_last_name".localized)
            return false
            
        }  else if ttxphoneNumber.text! == "" {
            AppUtility.showErrorMessage(message: "lb_warning_invalid_phone_number".localized)
            return false
        }else if txtemail.text! == "" {
            AppUtility.showErrorMessage(message: "lb_warning_invalid_email".localized)
            return false
        }else if txtpassword.text! == "" {
            AppUtility.showErrorMessage(message: "lb_warning_empty_password".localized)
            return false
        }else if txtgender.text! == "" {
            AppUtility.showErrorMessage(message: "Enter the Gender ")
            return false
        }
        return true
    }
    
    
    @IBAction func bottomAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationDownloadImageAlertVC") as? NotificationDownloadImageAlertVC
        vc?.titlofDialog = "Guardar cambios".localized
        vc?.detailofDialog = "Para aplicar los datos de usuario,confirma la acción en este dialogo.".localized
        vc?.acceptbuttontitle = "ACEPTAR".localized
        vc?.modalPresentationStyle = .overFullScreen
        vc?.callBack = { isok in
            if Network.isAvailable {
                print("Internet connection OK")
                if self.checkData() {
                    self.updateuserApi()
                }
            } else {
                print("Internet connection FAILED")
                AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
            }
        }
        self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func genderDropDownAction(_ sender: UIButton) {
        dropDownConfig(txtField : txtgender, data:["Male","Female"])
    }
    //MARK:- its a genral dropdown function to appear the dropdown
    func dropDownConfig(txtField : UITextField, data:[String]) {
        MainDrowpDown.anchorView = txtField
        MainDrowpDown.backgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        MainDrowpDown.selectionBackgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        MainDrowpDown.dataSource =  data
        DropDown.appearance().textColor = #colorLiteral(red: 0.5527616143, green: 0.5568413734, blue: 0.5609211326, alpha: 1)
        DropDown.appearance().selectedTextColor = UIColor.red
        //DropDown.appearance().textFont = UIFont(name: "JosefinSans-Regular", size: 18)!
        self.MainDrowpDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            
            cell.optionLabel.textAlignment = .left
            
        }
        
        MainDrowpDown.bottomOffset = CGPoint(x: 0, y: txtField.bounds.height)
        MainDrowpDown.selectionAction = { [self](index: Int, item: String) in
            print(item)
            self.txtgender.text = item
            
        }
        MainDrowpDown.show()
    }
    
    
    func checkDataChanges() -> Bool {
        
        if  txtDob.text == ShareData.shareInfo.obj?.dob?.getDateStringFromUTC() && ttxphoneNumber.text == ShareData.shareInfo.obj?.phoneNumber && txtemail.text == ShareData.shareInfo.obj?.email && txtpassword.text == ShareData.shareInfo.password && txtgender.text == ShareData.shareInfo.obj?.gender?.name && txtname.text == ShareData.shareInfo.obj?.name && lblLastname.text == ShareData.shareInfo.obj?.lastName && lblSecondLastName.text == ShareData.shareInfo.obj?.secondLastName {
            return false
        }
        else {
            return true
        }
    }
}

extension Int {
    func getDateStringFromUTC() -> String? {
        
        let date = Date(timeIntervalSince1970: TimeInterval((self)/1000))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    func getDays(start:TimeInterval, end : TimeInterval) -> Int? {
        
        let date1 = Date(timeIntervalSince1970: TimeInterval((self)/1000))
        
        let date2 = Date(timeIntervalSince1970: TimeInterval((self)/1000))
        let days = Date.gDay(recent: date1, previous: date2)
        
        return days.day
    }
    
}

extension Date {

    static func gDay(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second

        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }

}
