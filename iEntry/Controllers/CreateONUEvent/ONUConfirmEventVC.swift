//
//  ONUConfirmEventVC.swift
//  iEntry
//
//  Created by ZAFAR on 14/05/2022.
//

import UIKit

class ONUConfirmEventVC: BaseController {

    
    @IBOutlet weak var lblvisitortitle: UILabel!
    @IBOutlet weak var lblreservationtitle: UILabel!
    
    @IBOutlet weak var lblattitle: UILabel!
    
    @IBOutlet weak var lblvehicletitle: UILabel!
    @IBOutlet weak var lblunitsectiontitle: UILabel!
    @IBOutlet weak var lblvalidcommenttitle: UILabel!
    @IBOutlet weak var lblduration: UILabel!
    @IBOutlet weak var lblmint: UILabel!
    @IBOutlet weak var lblthetitle: UILabel!
    @IBOutlet weak var lbldatestitle: UILabel!
    @IBOutlet weak var lblnumbertitle: UILabel!
    //@IBOutlet weak var btncancel: UIStackView!
    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var btnconfirm: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lblendtime: UILabel!
    @IBOutlet weak var lblreservation: UILabel!
    
    @IBOutlet weak var lblacompindtitle: UILabel!
    @IBOutlet weak var lblcreateeventtitle: UILabel!
    
    @IBOutlet weak var lblvehicle: UILabel!
    @IBOutlet weak var lblvisitor: UILabel!
    @IBOutlet weak var lblunitsection: UILabel!
    @IBOutlet weak var lblpurposevisit: UILabel!
    @IBOutlet weak var lblacompaint: UILabel!
    var name = ""
    var secondName = ""
    var secondLasTName = ""
    var startDate = 0
    var endDate = 0
    var resevationid = ""
    var reservationName = ""
    var eventid = ""
    var usersIDsarr = [String]()
    var guestNumber = 0
    var duration = ""
    
    
    var visitPurpose =  ""
    var accompanied =  ""
    var unitSection =  ""
    var requiredTransportation = false
    var validationComment = ""
    var vehiclcount = ""
    var usercount = ""
    
    
    
    
    var callBack : (()->Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblvehicletitle.text = "VEHÍCULOS".localized
        self.lblvisitortitle.text = "VISITANTES".localized
        self.lblacompindtitle.text = "ACOMPAÑAMIENTO".localized
        self.lblvalidcommenttitle.text = "PROPOSITO DE LA VISITA".localized
        self.lblunitsectiontitle.text = "UNIDAD / SECCIÓN".localized
        mainView.roundViewWithCustomRadius(radius: 8)
        btnconfirm.roundButtonWithCustomRadius(radius: 5)
        
        self.lblname.text = name
        self.lbltime.text = getMilisecondstoDate(seconds: "\(startDate)", formatter: "")
        
        self.lblendtime.text =  getMilisecondstoTime(seconds: "\(endDate)", formatter: "")
        self.lblreservation.text = reservationName
        
        
        lblvehicle.text = vehiclcount
        lblvisitor.text =  usercount
        lblunitsection.text = unitSection
        lblpurposevisit.text = visitPurpose
        lblacompaint.text = accompanied
        
        
        
        self.lblcreateeventtitle.text = "C O N F I R M A R E V E N T O".localized
        self.lblnumbertitle.text = "NOMBRE".localized
    
        self.lbldatestitle.text = "FECHAS".localized
        self.lblthetitle.text = "EL".localized
    
        lblattitle.text = "A LAS".localized
        self.lblreservationtitle.text = "RESERVACIONES".localized
        self.btncancel.setTitle("CANCELAR".localized, for: .normal)
        self.btnconfirm.setTitle("CONFIMRMAR".localized, for: .normal)
        self.lblmint.text = "\(duration) MIN"
        self.lblduration.text = "DURACIÓN".localized
    }
    
    @IBAction func crossAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func confirmAction(_ sender: UIButton) {
        callBack?()
    }
   

}
