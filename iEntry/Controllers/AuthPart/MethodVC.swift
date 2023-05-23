//
//  MethodVC.swift
//  iEntry
//
//  Created by ZAFAR on 05/08/2021.
//

import UIKit

class MethodVC: UIViewController {
//MARK:- Here Are IBoutlet
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lbldetail: UILabel!
    @IBOutlet weak var lblemailmethod: UILabel!
    @IBOutlet weak var lblphoneMethos: UILabel!
  var email = ""
    
    //MARK:- Viewdidload Funtion 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.roundViewWithCustomRadius(radius: 10)
        self.navigationBarHidShow(isTrue: true)
        let number = UITapGestureRecognizer(target: self, action: #selector(self.handleTapNumber(_:)))
        lblphoneMethos.addGestureRecognizer(number)
        
        let email = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        lblemailmethod.addGestureRecognizer(email)
        lblemailmethod.isUserInteractionEnabled = true
        lblphoneMethos.isUserInteractionEnabled = true
        

        self.lbldetail.text = "SELECCIONE EL MÉTODO CON EL CUAL DESEA RECUPERAR LA CONTRASEÑA:".localized
        self.lblphoneMethos.text = "ENVIAR SMS AL CELULAR VINCULADO ".localized
        self.lblemailmethod.text = "ENVIAR CÓDIGO AL CORREO DE LA CUENTA".localized
    }
    
    //MARK:- this funtion use to move on next screen
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"VerificationCodeVC") as? VerificationCodeVC ///SendEmailVC
        vc?.email = email
        vc?.isfrom = true
        vc?.fromEmail = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @objc func handleTapNumber(_ sender: UITapGestureRecognizer? = nil) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"VerificationCodeVC") as? VerificationCodeVC ///SendEmailVC
        vc?.email = email
        vc?.fromEmail = false
        vc?.isfrom = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

   

   

}
