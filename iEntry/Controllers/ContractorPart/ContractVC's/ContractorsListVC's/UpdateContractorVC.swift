//
//  UpdateContractorVC.swift
//  iEntry
//
//  Created by ZAFAR on 02/09/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class UpdateContractorVC: BaseController {
    //MARK:- here are the iboutlet 
    @IBOutlet weak var txtDutyManager: MDCOutlinedTextField!
    @IBOutlet weak var lblcontractortitle: UILabel!
    
    @IBOutlet weak var lblactive: UILabel!
    @IBOutlet weak var txtCompany: MDCOutlinedTextField!
    
    @IBOutlet weak var txtEmail: MDCOutlinedTextField!
    
    @IBOutlet weak var txtPhone: MDCOutlinedTextField!
    
    @IBOutlet weak var txtStatus: MDCOutlinedTextField!
    @IBOutlet weak var txtacronmy: MDCOutlinedTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBarHidShow(isTrue: true)
        if myDefaultLanguage == .en {
            self.lblactive.text = "ACTIVE"
        } else {
            self.lblactive.text = "ACTIVO"
        }
        
        setMDCTxtFieldDesign(txtfiled: txtacronmy, Placeholder: "ACRÓNIMO".localized, imageIcon: UIImage())
        
        setMDCTxtFieldDesign(txtfiled: txtCompany, Placeholder: "COMPAÑIA".localized, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtDutyManager, Placeholder: "ENCARGADO".localized, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtEmail, Placeholder: "CORREO".localized, imageIcon: UIImage(named: "ic-invitation")!)
        setMDCTxtFieldDesign(txtfiled: txtPhone, Placeholder: "CELULAR".localized, imageIcon: UIImage(named: "mobile-alt-solid")!)
        setMDCTxtFieldDesign(txtfiled: txtStatus, Placeholder: "ESTATUS".localized, imageIcon: UIImage(named: "ic-arrow-down")!)
        self.lblcontractortitle.text = "A G R E G A R                          C O N T R A T I S T A".localized
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func updateAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
