//
//  LogOutPopUpVC.swift
//  iEntry
//
//  Created by ZAFAR on 09/02/2022.
//

import UIKit

class LogOutPopUpVC: UIViewController {
    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var btnaccept: UIButton!
    @IBOutlet weak var lblsessiontitle: UILabel!
    @IBOutlet weak var lbldetail: UILabel!
    var callBack : (() ->Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblsessiontitle.text = "CERRAR SESIÓN".localized
        self.lbldetail.text = "Estás apunto de cerrar sesión, se desvinculará el dispositivo en el que esta la sesión activa. ¿Deseas continuar?".localized
        self.btncancel.setTitle("CANCELAR".localized, for: .normal)
        self.btnaccept.setTitle("ACEPTAR".localized, for: .normal)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func crossAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

   
    @IBAction func acceptAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        callBack?()
    }
    

}
