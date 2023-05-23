//
//  UserAlreadyExistVC.swift
//  iEntry
//
//  Created by ZAFAR on 12/05/2022.
//

import UIKit

class UserAlreadyExistVC: UIViewController {
    @IBOutlet weak var lblusernotexisttitle: UILabel!
    @IBOutlet weak var lblphone: UILabel!
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var btncanceltitle: UIButton!
    @IBOutlet weak var lblusernotexistdetail: UILabel!
    @IBOutlet weak var lblnumbertitle: UILabel!
    @IBOutlet weak var btnaccepttitle: UIButton!
    @IBOutlet weak var lblemailtitle: UILabel!
    var phone = ""
    var email = ""
    @IBOutlet weak var lblphonetitle: UILabel!
    var name = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnaccepttitle.setTitle("ACEPTAR".localized, for: .normal)
        self.btncanceltitle.setTitle("CANCELAR".localized, for: .normal)
        self.lblnumbertitle.text = "NOMBRE".localized
        self.lblemailtitle.text = "EMAIL".localized
        self.lblphone.text = phone
        self.lblname.text = name
        self.lblemail.text = email
        self.lblphonetitle.text = "NÚMERO TELEFÓNICO".localized
        self.lblusernotexisttitle.text = "USUARIO YA EXISTE".localized
        self.lblusernotexistdetail.text = "Ya existe el correo/número en la base deseas, son de este usuario, deseas seleccionarlo?".localized
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func acceptAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
