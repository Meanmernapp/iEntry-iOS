//
//  CancelEventInvitationVC.swift
//  iEntry
//
//  Created by ZAFAR on 20/08/2021.
//

import UIKit

class CancelEventInvitationVC: UIViewController {
    //MARK:- here are iboutlet
    @IBOutlet weak var btncancel: UIButton!
//    @IBOutlet weak var lblinvitationNametitle: UILabel!
    @IBOutlet weak var lblcancelinvitationtitle: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnconfirm: UIButton!
    
    @IBOutlet weak var descriptionText: UILabel!
    var callBack: ((Bool)->Void)? = nil
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBarHidShow(isTrue: true)
        btnconfirm.roundViewWithCustomRadius(radius: 5)
        mainView.roundViewWithCustomRadius(radius: 8)
        self.descriptionText.text = "Deseas cancelar la invitación para".localized + "\(name)?"
        self.lblcancelinvitationtitle.text = "CANCELAR INVITACIÓN".localized
//        self.lblinvitationNametitle.text = "NOMBRE".localized
        self.btncancel.setTitle("CANCELAR".localized, for: .normal)
        self.btnconfirm.setTitle("ACEPTAR".localized, for: .normal)
        
    }
    
    //MARK:- dismiss the  controller 
    @IBAction func crossAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func acceptAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        callBack?(true)
    }
}
