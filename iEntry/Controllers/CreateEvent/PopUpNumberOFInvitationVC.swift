//
//  PopUpNumberOFInvitationVC.swift
//  iEntry
//
//  Created by ZAFAR on 24/01/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class PopUpNumberOFInvitationVC: BaseController {
    @IBOutlet weak var lblextradatadetail: UILabel!
    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var btnaccept: UIButton!
    @IBOutlet weak var lbldetail: UILabel!
    @IBOutlet weak var txtnumber: MDCOutlinedTextField!
    var callBack: ((_ number:String) ->Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        view.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.2935282726)
        setMDCTxtFieldDesign(txtfiled: txtnumber, Placeholder: "NO INIVITADOS".localized, imageIcon: UIImage())
        btncancel.setTitle("CANCELAR".localized, for: .normal)
        btnaccept.setTitle("ENVIAR".localized, for:.normal)
        self.lblextradatadetail.text = "D A T O S E X T R A".localized
        self.lbldetail.text = "Ingrese el número de invitados permitidos por invitación".localized
    }
    

    @IBAction func acceptAction(_ sender: UIButton) {
        if txtnumber.text == "" {
            AppUtility.showErrorMessage(message: "please enter invitation number")
            return
        }
        self.callBack?(txtnumber.text!)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
