//
//  ContractDetailVC.swift
//  iEntry
//
//  Created by ZAFAR on 02/09/2021.
//

import UIKit

class ContractDetailVC: UIViewController {
    
    
    //MARK: - IBOutlets

    @IBOutlet weak var lblgenrateqrtitle: UILabel!
    @IBOutlet weak var lblnumberofemployeetitle: UILabel!
    @IBOutlet weak var lbldetaillbltitle: UILabel!
    
    @IBOutlet weak var lblactive: UILabel!
    @IBOutlet weak var lblupdatetitle: UILabel!
    @IBOutlet weak var lblnumberofvehicletitle: UILabel!
    @IBOutlet weak var lblbusinesstitle: UILabel!
    @IBOutlet weak var lblendcontrarcttitle: UILabel!
    @IBOutlet weak var lblcontractstarttitle: UILabel!
    @IBOutlet weak var lblcompanytitle: UILabel!
    @IBOutlet weak var lbltypegrouptitle: UILabel!
    @IBOutlet weak var folioNumber: UILabel!
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if myDefaultLanguage == .en {
            self.lblactive.text = "ACTIVE"
        } else {
            self.lblactive.text = "ACTIVO"
        }
        self.navigationBarHidShow(isTrue: true)
    
        self.lbldetaillbltitle.text = "D E T A L L E S".localized
        self.lbltypegrouptitle.text = "Grupo Tepeyac Mexico".localized
        self.lblcompanytitle.text = "Compañia".localized
    
        self.lblcontractstarttitle.text = "Inicio de contrato".localized
    
        self.lblendcontrarcttitle.text  = "Fin de contrato".localized
    
        self.lblbusinesstitle.text = "Empresa".localized
    
        
        
        self.lblnumberofemployeetitle.text = "No. de empleados".localized
        self.lblnumberofvehicletitle.text = "No. vehículos".localized
    
        self.lblupdatetitle.text = "ACTUALIZAR".localized
    
        self.lblgenrateqrtitle.text = "GENERAR QR".localized
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func UpDateAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Contract.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"UpdateContractVC") as? UpdateContractVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func qrCodeAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"GeneralQRCodeVC") as? GeneralQRCodeVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
