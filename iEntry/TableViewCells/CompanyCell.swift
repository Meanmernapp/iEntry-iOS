//
//  CompanyCell.swift
//  iEntry
//
//  Created by ZAFAR on 01/09/2021.
//

import UIKit

class CompanyCell: UITableViewCell {
    //MARK:- here are the IBOutlet
    @IBOutlet weak var lblmap: UILabel!
    @IBOutlet weak var lblemployee: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var qrCodeView: UIView!
    @IBOutlet weak var mapView: UIView!
    
    @IBOutlet weak var lblqrcodetitle: UILabel!
    @IBOutlet weak var lblcontractdate: UILabel!
    @IBOutlet weak var lblrole: UILabel!
    @IBOutlet weak var lblownername: UILabel!
    
    @IBOutlet weak var lbladdress: UILabel!
    
    @IBOutlet weak var lblstartDate: UILabel!
    @IBOutlet weak var lblendDate: UILabel!
    @IBOutlet weak var lblenddatetitle: UILabel!
    
    @IBOutlet weak var lblstartdatetitle: UILabel!
    
    
    //MARK:- call back funtion intializing here 
    var callBack: ((_ done: Bool) -> (Void))? = nil
    var moreDetailcallBack: ((_ done: Bool) -> (Void))? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        viewDesign()
        updatelanguage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func mapAction(_ sender: UIButton) {
        callBack?(true)
    }
    @IBAction func qrAction(_ sender: UIButton) {
        callBack?(false)
    }
    
    func viewDesign() {
        mapView.roundViewWithCustomRadius(radius: 5)
        qrCodeView.roundViewWithCustomRadius(radius: 8)
        mainView.layer.cornerRadius = 8
        mainView.layer.shadowColor = #colorLiteral(red: 0.423489809, green: 0.4235547483, blue: 0.4234756231, alpha: 1)
        mainView.layer.shadowRadius = 4.0
        mainView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        mainView.layer.shadowOpacity = 1.0
        mainView.layer.masksToBounds = false
    }
    
    @IBAction func moreDetailAction(_ sender: UIButton) {
        moreDetailcallBack?(true)
    }
    
    
    func updatelanguage() {
        self.lblmap.text = "MAPA".localized
        self.lblemployee.text = "Empleado".localized
        self.lblrole.text = "Rol".localized
        self.lblcontractdate.text = "Fechas de Contrato".localized
        self.lblstartdatetitle.text = "Inicio".localized
        self.lblenddatetitle.text = "Fin".localized
        self.lblqrcodetitle.text = "OPCIONES".localized
    }
}
