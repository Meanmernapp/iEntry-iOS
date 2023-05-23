//
//  UserNotRegisterPopUpVC.swift
//  iEntry
//
//  Created by ZAFAR on 25/12/2021.
//

import UIKit

class UserNotRegisterPopUpVC: BaseController {
    //MARK:- here are iboutlet
    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var lblusertitl: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lbldetailtitle: UILabel!
    @IBOutlet weak var btnconfirm: UIButton!
    var number = ""
    var name = ""
    var index = -1
    var callback : ((_ number:String, _ name:String,_ index:Int,_ guestID:String)->Void)? = nil
    var callbackSimple : (()->Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblusertitl.text = "USUARIO NO\n ENCONTRADO".localized
        self.lbldetailtitle.text = "No sé encontró asociado ningún celular correo en nuestros servidores, para poder invitarlo es necesario proporcionar ciertos datos para nuestros registros.".localized
        self.btncancel.setTitle("CANCELAR".localized, for: .normal)
        self.btnconfirm.setTitle("ACEPTAR".localized, for: .normal)
        
        self.navigationBarHidShow(isTrue: true)
        btnconfirm.roundViewWithCustomRadius(radius: 5)
        mainView.roundViewWithCustomRadius(radius: 8)
    }
    
    //MARK:- dismiss the  controller
    @IBAction func crossAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

   
    @IBAction func acceptAction(_ sender: UIButton) {
        let parentVC = presentingViewController
                dismiss(animated: true) {
                    let storyboard  =  UIStoryboard.init(name: "Home", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "PreRegisterVC") as?PreRegisterVC
                    
                    vc?.number = self.number
                    vc?.name = self.name
                    vc?.index = self.index
                    vc?.callback = {number , name,index,guestID in
                        self.callback!(number, name,index, guestID)
                    }
                    parentVC?.present(vc!, animated: true)
                }
    }
    
}

