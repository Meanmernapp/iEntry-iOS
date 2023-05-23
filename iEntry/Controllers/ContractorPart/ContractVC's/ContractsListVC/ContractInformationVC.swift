//
//  ContractInformationVC.swift
//  iEntry
//
//  Created by ZAFAR on 12/11/2021.
//

import UIKit

class ContractInformationVC: UIViewController {
    @IBOutlet weak var lblhomecontracttitle: UILabel!
    @IBOutlet weak var lblcumpnaytitle: UILabel!
    @IBOutlet weak var lblcimissionstitle: UILabel!
    @IBOutlet weak var lblendDate: UILabel!
    @IBOutlet weak var lblstartDate: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var lblstatus: UILabel!
    @IBOutlet weak var lblusername: UILabel!
    @IBOutlet weak var lblbusinessname: UILabel!
    @IBOutlet weak var lblcontractnumber: UILabel!
    @IBOutlet weak var lblinformationtitle: UILabel!
    @IBOutlet weak var lblendofcontracttitle: UILabel!
    
    var contractListdata: IncomingContractListModelData?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        configData()
    }
    
    func configData(){
        let name:String?  = "\(self.contractListdata?.contractorName ?? "") \(self.contractListdata?.contractorLastName ?? "") \(self.contractListdata?.contractorSecondLastName ?? "")"
        self.lblendDate.text = getMilisecondstoDate(seconds: "\(contractListdata?.endDate ?? 0)", formatter: "")
        self.lblstartDate.text = getMilisecondstoDate(seconds: "\(contractListdata?.starDate ?? 0)", formatter: "")
        self.lblusername.text = name
        lblbusinessname.text = contractListdata?.contractorCompanyName
        self.lblcontractnumber.text = "Folio #".localized +  "\(self.contractListdata?.folio.putDashes() ?? "-")"
        
        if self.contractListdata?.statusId == 22 {
            statusView.backgroundColor = UIColor(hexString: "0C4523")
            lblstatus.textColor =  UIColor(hexString: "0C4523")
            if myDefaultLanguage == .en {
                lblstatus.text = "CONTRACT ACTIVE" //self.contractListdata[indexPath.row].status?.name
            } else {
                
                lblstatus.text = "CONTRATO ACTIVO"
                
            }
            
            
            
        } else if self.contractListdata?.statusId == 21 {
            statusView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            lblstatus.textColor = #colorLiteral(red: 0.9481226802, green: 0.630784452, blue: 0, alpha: 1)
            if myDefaultLanguage == .en {
                lblstatus.text = "CONTRACT FINISH"
            } else {
                lblstatus.text =  "CONTRATO FINALIZADO"
            }
            
            
        } else if self.contractListdata?.statusId == 23 {
            statusView.backgroundColor = #colorLiteral(red: 0.9991626143, green: 0.1742511094, blue: 0.3347000182, alpha: 1)
            lblstatus.textColor = #colorLiteral(red: 0.9991626143, green: 0.1742511094, blue: 0.3347000182, alpha: 1)
            if myDefaultLanguage == .en {
                lblstatus.text = "CONTRACT CANCEL"
            } else {
                lblstatus.text = "CONTRATO CANCELADO"
            }
        }
        
        
        self.lblinformationtitle.text = "I N F O R M A C I Ó N".localized
        self.lblcimissionstitle.text = "Contratista encargado".localized
        self.lblcumpnaytitle.text = "Compañia".localized
        self.lblhomecontracttitle.text = "Inicio Contrato".localized
        self.lblendofcontracttitle.text = "Fin Contrato".localized
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getMilisecondstoDate(seconds: String , formatter:String) -> String{
        
        let epocTime = TimeInterval(Int(seconds) ?? 0)
        
        let myDate = Date(timeIntervalSince1970: epocTime / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"  //UTC
        dateFormatter.timeZone = NSTimeZone(name: "en_US") as TimeZone?
        let dateString = dateFormatter.string(from: myDate)
        return dateString
    }
}
