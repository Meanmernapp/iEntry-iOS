//
//  BiomatricLoginVC.swift
//  iEntry
//
//  Created by ZAFAR on 07/08/2021.
//

import UIKit

class BiomatricLoginVC: UIViewController {

    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var btnpassword: UIButton!
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var passwordView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordView.roundViiew()
        btnpassword.roundButtonWithCustomRadius(radius: 10)
        
        
//        "Biometric credentials" = "Biometric credentials";
//        "Log in using yout biometric credential" = "Log in using yout biometric credential";
//        "Use password App" = "Use password App";
        txtemail.placeholder = "Biometric credentials"
        self.btnpassword.setTitle("INICIAR SESIÓN".localized, for: .normal)
        self.txtpassword.placeholder = "CONTRASEÑA".localized
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ThumScaningVC") as? ThumScaningVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func passShwoHide(_ sender: UIButton) {
        if txtpassword.isSecureTextEntry {
            btnpassword.setImage(UIImage(named: "eye-regular"), for: .normal)
        } else {
            btnpassword.setImage(UIImage(named: "eye-slash-solid"), for: .normal)
        }
        txtpassword.isSecureTextEntry = !txtpassword.isSecureTextEntry
    }

}
