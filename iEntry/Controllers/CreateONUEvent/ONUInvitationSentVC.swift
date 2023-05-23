//
//  ONUInvitationSentVC.swift
//  iEntry
//
//  Created by ZAFAR on 10/05/2022.
//

import UIKit

class ONUInvitationSentVC: BaseController {
    @IBOutlet weak var lbltitlecancel: UILabel!
    
    @IBOutlet weak var btnaccepttitle: UIButton!
    @IBOutlet weak var lbldetailtitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lbltitlecancel.text = "INVITACIÓN YA HA SIDO CREADA".localized
        self.lbldetailtitle.text = "La invitación ha sido creada, si deseas cambiar algún dato, debes eliminarla y volver a invitar a esa persona.".localized
        self.btnaccepttitle.setTitle("ACEPTAR".localized, for: .normal)
    }
    

    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func acceptAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
