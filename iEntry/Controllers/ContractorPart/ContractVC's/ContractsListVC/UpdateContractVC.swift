//
//  UpdateContractVC.swift
//  iEntry
//
//  Created by ZAFAR on 02/09/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class UpdateContractVC: BaseController {
    //MARK:- here are iboutlet
    @IBOutlet weak var txtstartDate: MDCOutlinedTextField!
    @IBOutlet weak var txtendDate: MDCOutlinedTextField!
    
    @IBOutlet weak var lblactive: UILabel!
    @IBOutlet weak var lblupdatetitle: UILabel!
    @IBOutlet weak var lblcompanytitle: UILabel!
    @IBOutlet weak var lblmaxicotitle: UILabel!
    @IBOutlet weak var lblbottomupdatetitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblupdatetitle.text = "A C T U A L I Z A R C O N T R A T O".localized
        self.navigationBarHidShow(isTrue: true)
        setMDCTxtFieldDesign(txtfiled: txtstartDate, Placeholder: "INICIO DE CONTRATO".localized, imageIcon: UIImage(named: "ic-calendar-2")!)
        setMDCTxtFieldDesign(txtfiled: txtendDate, Placeholder: "FIN DE CONTRATO".localized, imageIcon: UIImage(named: "ic-calendar-2")!)
   
        self.lblmaxicotitle.text = "Grupo Tepeyac Mexico".localized
        self.lblcompanytitle.text = "Compañia".localized
        self.lblupdatetitle.text = "ACTUALIZAR".localized
    
        if myDefaultLanguage == .en {
            self.lblactive.text = "ACTIVE"
        } else {
            self.lblactive.text = "ACTIVO"
        }
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func UpdateAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
