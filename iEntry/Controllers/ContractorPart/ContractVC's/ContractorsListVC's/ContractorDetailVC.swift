//
//  ContractorDetailVC.swift
//  iEntry
//
//  Created by ZAFAR on 02/09/2021.
//

import UIKit

class ContractorDetailVC: UIViewController {
    //MARK:- here are the iboutlet
    @IBOutlet weak var lblactive: UILabel!
    @IBOutlet weak var lblnumbertitle: UILabel!
    @IBOutlet weak var lblemailtitle: UILabel!
    @IBOutlet weak var lblmanagertitle: UILabel!
    @IBOutlet weak var lblupdatetitle: UILabel!
    @IBOutlet weak var lbldetailtitle: UILabel!
    @IBOutlet weak var lblcompanytitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBarHidShow(isTrue: true)
        self.lbldetailtitle.text = "D E T A L L E S".localized
        self.lblupdatetitle.text = "ACTUALIZAR".localized
        self.lblcompanytitle.text = "COMPAÑIA".localized
        self.lblmanagertitle.text = "ENCARGADO".localized
        self.lblemailtitle.text = "CORREO".localized
        self.lblnumbertitle.text = "NÚMERO".localized
        
        
        if myDefaultLanguage == .en {
            self.lblactive.text = "ACTIVE"
        } else {
            self.lblactive.text = "ACTIVO"
        }
    }
    

    @IBAction func updateAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name:StoryBoards.Contract.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"UpdateContractorVC") as? UpdateContractorVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
