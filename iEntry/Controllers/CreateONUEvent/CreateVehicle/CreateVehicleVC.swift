//
//  CreateVehicleVC.swift
//  iEntry
//
//  Created by ZAFAR on 30/04/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class CreateVehicleVC: BaseController {

    @IBOutlet weak var btnconfirmtitle: UIButton!
    @IBOutlet weak var lbluserdatatitle: UILabel!
    @IBOutlet weak var txtvin: MDCOutlinedTextField!
    
    @IBOutlet weak var btncanceltitle: UIButton!
    @IBOutlet weak var txtmarca: MDCOutlinedTextField!
    
    @IBOutlet weak var txtsubmarca: MDCOutlinedTextField!
    
    @IBOutlet weak var txtmodel: MDCOutlinedTextField!
    @IBOutlet weak var txtcolor: MDCOutlinedTextField!
    @IBOutlet weak var txtsn: MDCOutlinedTextField!
    
    @IBOutlet weak var txtplaces: MDCOutlinedTextField!
    
    var callBack: (()->Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbluserdatatitle.text = "D A T O S  D E V E H Í C U L O".localized
        setMDCTxtFieldDesign(txtfiled: txtmarca, Placeholder: "MARCA".localized, imageIcon:UIImage())
        setMDCTxtFieldDesign(txtfiled: txtsubmarca, Placeholder: "SUB - MARCA".localized, imageIcon:UIImage())
        
        setMDCTxtFieldDesign(txtfiled: txtmodel, Placeholder: "MODELO".localized, imageIcon:UIImage())
        setMDCTxtFieldDesign(txtfiled: txtplaces, Placeholder: "PLACAS".localized, imageIcon:UIImage())
        
        setMDCTxtFieldDesign(txtfiled: txtcolor, Placeholder: "COLOR".localized, imageIcon:UIImage())
        
        setMDCTxtFieldDesign(txtfiled: txtsn, Placeholder: "S/N".localized, imageIcon:UIImage())
        
        setMDCTxtFieldDesign(txtfiled: txtvin, Placeholder: "VIN".localized, imageIcon:UIImage())
        
        self.btncanceltitle.setTitle("CANCELAR".localized, for: .normal)
        self.btnconfirmtitle.setTitle("CONFIMRMAR".localized, for: .normal)
    }
    
    
    
    func checkData() -> Bool {
        if txtmarca.text == "" {
            AppUtility.showErrorMessage(message: "lb_empty_brand".localized)
            return false
        } else if txtsubmarca.text == "" {
            AppUtility.showErrorMessage(message: "lb_empty_sub_brand".localized)
            return false
        } else if Int(txtmodel.text ?? "-1") == -1 {
            AppUtility.showErrorMessage(message: "lb_empty_model".localized)
            return false
        } else if txtcolor.text == "" {
            AppUtility.showErrorMessage(message: "lb_empty_color".localized)
            return false
        } else if txtplaces.text == "" {
            AppUtility.showErrorMessage(message: "lb_empty_plates".localized)
            return false
        } else if txtsn.text == "" {
            AppUtility.showErrorMessage(message: "lb_empty_serial_number".localized)
            return false
        } else if txtvin.text == "" {
            AppUtility.showErrorMessage(message: "Please Enter VIN")
            return false
        }
        return true
    }
    
    
    @IBAction func confirmAction(_ sender: UIButton) {
        if checkData() {
            createVehicleApi()
        }
        else {
            AppUtility.showErrorMessage(message: "All data not selected")
        }
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func createVehicleApi(){
        self.showLoader()
        
        let dic : [String:Any] = ["brand":self.txtmarca.text!,"color":txtcolor.text!,"createdAt":0,"model":Int(txtmodel.text ?? "0") ?? 0,"plate":txtplaces.text!,"serialNumber":txtsn.text!,"subBrand":txtsubmarca.text!,"updatedAt":0,"vin":txtvin.text!]
        
        userhandler.createVehicle(parms: dic, Success: {response in
            self.hidLoader()
            if response?.success == true  {
                self.dismiss(animated: true, completion: nil)
                self.callBack?()
            } else {
                self.hidLoader()
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    
    
}
