//
//  UserNotRegisterPopUpVC.swift
//  iEntry
//
//  Created by ZAFAR on 12/05/2022.
//

import UIKit

class ONUUserNotRegisterPopUpVC: BaseController {
    @IBOutlet weak var lblinvitortitle: UILabel!
    @IBOutlet weak var lbldetail: UILabel!
   
    @IBOutlet weak var btncanceltitle: UIButton!
    @IBOutlet weak var btnaccepttitle: UIButton!
    
    var callBack:(()->Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.lblinvitortitle.font = UIFont(name: "Montserrat-Bold", size: 18)
        self.lblinvitortitle.text = "USUARIO NO\nENCONTRADO".localized
        
        self.lbldetail.text = "No sé encontró asociado ningún celular correo en nuestros servidores, para poder invitarlo es necesario proporcionar ciertos datos para nuestros registros.".localized
        self.btncanceltitle.setTitle("CANCELAR".localized, for: .normal)
        self.btnaccepttitle.setTitle("ACEPTAR".localized, for: .normal)
    }
    

    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func acceptAction(_ sender: UIButton) {
        
        
        self.dismiss(animated: true, completion: nil)
        self.callBack?()
    }

}
