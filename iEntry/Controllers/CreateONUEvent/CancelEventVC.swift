//
//  CancelEventVC.swift
//  iEntry
//
//  Created by ZAFAR on 12/05/2022.
//

import UIKit

class CancelEventVC: BaseController {

    @IBOutlet weak var btnaccepttitle: UIButton!
    @IBOutlet weak var btncanceltitle: UIButton!
    @IBOutlet weak var lbldetail: UILabel!
    @IBOutlet weak var lblcanceltitle: UILabel!
    var callBack:(()->Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblcanceltitle.text = "CANCELAR EVENTO".localized
        self.lbldetail.text = "Estás seguro de querer eliminar este evento? La reservación y todas las invitaciones serán eliminadas en conjunto de la operación.".localized
        
        btncanceltitle.setTitle("CANCELAR".localized, for: .normal)
        btnaccepttitle.setTitle("ACEPTAR".localized, for: .normal)
    
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func acceptAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
        callBack?()
    }
}
