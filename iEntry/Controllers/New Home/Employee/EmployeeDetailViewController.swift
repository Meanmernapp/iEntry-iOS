//
//  EmployeeDetailViewController.swift
//  iEntry
//
//  Created by HaiDer's Macbook Pro on 27/01/2023.
//

import UIKit

class EmployeeDetailViewController: UIViewController {
    
    
    
    //MARK: - IBOutlets

    @IBOutlet weak var curvView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var statusColorView: UIView!
    
    //MARK: - Titles
    
    @IBOutlet weak var dataTitleLbl: UILabel!
    @IBOutlet weak var informationTitleLbl: UILabel!
    @IBOutlet weak var extrainformationTitleLbl: UILabel!
    @IBOutlet weak var nameTitleLbl: UILabel!
    @IBOutlet weak var passwordTitleLbl: UILabel!
    @IBOutlet weak var emailTitleLbl: UILabel!
    @IBOutlet weak var phoneNumberTitleLbl: UILabel!
    @IBOutlet weak var birthDayTitleLbl: UILabel!
    @IBOutlet weak var genderTitleLbl: UILabel!
    @IBOutlet weak var lastNameTitleLbl: UILabel!
    @IBOutlet weak var secondLastNameLbl: UILabel!
    
    //MARK: - Values
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var secondname: UILabel!
    @IBOutlet weak var secondLastName: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var dateOfBirthLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    
    
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
    
    //MARK: - Variables
    
    var data : EmployeeUserDetailsData?
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        if ShareData.shareInfo.headersData == nil {
            self.getHeaders()
        }
        else {
            self.setupHeaders()
        }
        self.setupValues()
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getHeaders() {
        userhandler.getExtraDataHeaders { responce in
            if responce?.success == true {
                ShareData.shareInfo.headersData = responce?.data
                self.setupHeaders()
            }
            else {
                AppUtility.showErrorMessage(message: "Headers failed to set")
            }
            
            
        } Failure: { error in
            AppUtility.showErrorMessage(message: "Headers fething failed")
        }
        
    }
    
    
    //MARK: - Functions
    func setup() {
        curvView.roundCorners([.topLeft,.bottomLeft], radius: 5)
        mainView.layer.cornerRadius = 36
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        mainView.layer.masksToBounds = true
        if data?.genderID == 2 {
            self.userImg.image = UIImage(named: "employeeFemail")
        }
        else {
            self.userImg.image = UIImage(named: "employeeMale")
        }
        self.dataTitleLbl.text = "Datos".localized
        self.informationTitleLbl.text = "Información personal".localized.uppercased() //todo
        self.nameTitleLbl.text = "Nombre".localized
        self.lastNameTitleLbl.text = "apellido".localized
        self.secondLastNameLbl.text = "Primer apellido".localized
        self.passwordTitleLbl.text = "Contraseña".localized
        self.emailTitleLbl.text = "Correo".localized
        self.phoneNumberTitleLbl.text = "Celular".localized
        self.birthDayTitleLbl.text = "Fecha de cumpleaños".localized
        self.genderTitleLbl.text = "Género".localized
        self.extrainformationTitleLbl.text = "Información extra".localized.uppercased() //todo
        
        //MARK: - SetupValues
        self.nameLbl.text = self.data?.name.putDashes()
        self.secondname.text = self.data?.lastName.putDashes()
        self.secondLastName.text = self.data?.secondLastName.putDashes()
        self.emailLbl.text = self.data?.email.putDashes()
        self.phoneNumberLbl.text = self.data?.phoneNumber.putDashes()
        self.dateOfBirthLbl.text = self.data?.dob?.getDateStringFromUTC().putDashes()
        if data?.genderID == 2 {
            self.genderLbl.text = "Femenina".localized
        }
        else {
            self.genderLbl.text = "Masculina".localized
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
    func setupValues() {
        self.header1Lbl.text = data?.field1
        self.header2Lbl.text = data?.field2
        self.header3Lbl.text =  data?.field3
        self.header4Lbl.text = data?.field4
        self.header5Lbl.text = data?.field5
        self.header6Lbl.text = data?.field6
        self.header7Lbl.text = data?.field7
        self.header8Lbl.text = data?.field8
        self.header9Lbl.text = data?.field9
        self.header10Lbl.text =  data?.field10
        self.header11Lbl.text = data?.field11
        self.header12Lbl.text = data?.field12
        self.header13Lbl.text = data?.field13
        self.header14Lbl.text = data?.field14
        self.header15Lbl.text = data?.field15
        self.statusUpdate(data: data?.statusId)
    }
    
    func statusUpdate(data:Int?) {
        if data == 1 {
            self.statusLbl.text = "PRE REGISTRO".localized
            self.statusLbl.textColor = UIColor(hexString: "707070")
            self.statusColorView.backgroundColor = UIColor(hexString: "707070")
        }
        else
        if data == 2 {
            self.statusLbl.text = "CAMBIO DE CONTRASEÑA".localized
            self.statusLbl.textColor = UIColor(hexString: "A2CBF4")
            self.statusColorView.backgroundColor = UIColor(hexString: "A2CBF4")
        }
        else
        if data == 3 {
            self.statusLbl.text = "PARA APROBAR DOCUMENTO".localized
            self.statusLbl.textColor = UIColor(hexString: "006594")
            self.statusColorView.backgroundColor = UIColor(hexString: "006594")
        }
        else
        if data == 4 {
            self.statusLbl.text = "ACTIVO".localized
            self.statusLbl.textColor = UIColor(hexString: "146F62")
            self.statusColorView.backgroundColor = UIColor(hexString: "146F62")
        }
        if data == 5 {
            self.statusLbl.text = "DE VACACIONES".localized
            self.statusLbl.textColor = UIColor(hexString: "FF8B13")
            self.statusColorView.backgroundColor = UIColor(hexString: "FF8B13")
        }
        if data == 6 {
            self.statusLbl.text = "INACTIVO".localized
            self.statusLbl.textColor = UIColor(hexString: "BC0000")
            self.statusColorView.backgroundColor = UIColor(hexString: "BC0000")
        }
    }
}

extension Optional where Wrapped == String {
    func putDashes() -> String? {
        if self == " " || self == "" || self == nil {
            return "-"
        }
        else {
            return self
        }
    }
}
