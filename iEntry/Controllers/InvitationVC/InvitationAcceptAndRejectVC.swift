//
//  InvitationAcceptAndRejectVC.swift
//  iEntry
//
//  Created by ZAFAR on 11/04/2022.
//

import UIKit

class InvitationAcceptAndRejectVC: UIViewController {

    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var btnaccept: UIButton!
    
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var descrptionTc: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    var acceptInvition : ((_ option:Int) ->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.acceptBtn.setTitle("ASISTIRÉ".localized, for: .normal)
        self.cancelBtn.setTitle("NO ASISTIRÉ".localized, for: .normal)
        self.titleLbl.text = "ATENDER INVITACIÓN".localized
        self.descrptionTc.text = "¿Deseas confirmar tu participación en el evento?".localized
    }
    

    @IBAction func btnCancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
       acceptInvition?(39)
    }
    
    @IBAction func btnAcceptionAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        acceptInvition?(38)
        
        
    }
    @IBAction func closePopUp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
