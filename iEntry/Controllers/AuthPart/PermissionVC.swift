//
//  PermissionVC.swift
//  iEntry
//
//  Created by ZAFAR on 05/08/2021.
//

import UIKit

class PermissionVC: UIViewController {
    
    
    @IBOutlet weak var lblwouldyoulike: UILabel!
    
    @IBOutlet weak var lblsubjecthard: UILabel!
    @IBOutlet weak var btnnowithPassword: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btncontinue: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.roundViewWithCustomRadius(radius: 10)
        self.navigationBarHidShow(isTrue: true)
        btncontinue.roundButtonWithCustomRadius(radius: 8)
        
        
        let yourAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Montserrat-Regular", size: 12)!,
              .foregroundColor:#colorLiteral(red: 0.5803269744, green: 0.5804297328, blue: 0.5803204775, alpha: 1),
              .underlineStyle: NSUnderlineStyle.single.rawValue
          ]
        
        let attributeString = NSMutableAttributedString(
                string: "no, con contraseña",
                attributes: yourAttributes
             )
        btnnowithPassword.setAttributedTitle(attributeString, for: .normal)
       
        
    
        
        self.lblwouldyoulike.text = "TE GUSTARÍA INICIAR SESIÓN CON TU HUELLA Y/O ESCANER FACIAL*?".localized
        self.btncontinue.setTitle("SÍ, CONTINUAR".localized, for: .normal)
        
        self.btnnowithPassword.setTitle("no, con contraseña".localized, for: .normal)
        self.lblsubjecthard.text = "*Sujeto a disponibilidad de hardware".localized
    }
    

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func moveOnLogin() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"LoginVC") as? LoginVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func continueAction(_ sender: UIButton) {
        self.moveOnLogin()
        ShareData.shareInfo.isBiomatric = true
//        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//        let vc = storyBoar                                                                                                 d.instantiateViewController(withIdentifier:"PasswordRecoveryVC") as? PasswordRecoveryVC
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func WithPasswordAction(_ sender: UIButton) {
        ShareData.shareInfo.isBiomatric = false
        self.moveOnLogin()
//        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier:"EnterEmailVC") as? EnterEmailVC
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
