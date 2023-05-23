//
//  SchedualCell.swift
//  iEntry
//
//  Created by ZAFAR on 11/08/2021.
//

import UIKit

class SchedualCell: UITableViewCell {
    //MARK:- here are the IBOutlet
    @IBOutlet weak var lblplacetitle: UILabel!
    @IBOutlet weak var lblhosttitle: UILabel!
    @IBOutlet weak var lbleventtitle: UILabel!
    @IBOutlet weak var qrView: UIView!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lbleventName: UILabel!
    @IBOutlet weak var lblhostName: UILabel!
    
    @IBOutlet weak var lbldurationtitle: UILabel!
    @IBOutlet weak var lbldurationmin: UILabel!
    @IBOutlet weak var lblqrCodeTitle: UILabel!
    @IBOutlet weak var lblmoredetail: UILabel!
    @IBOutlet weak var lblreservationtitle: UILabel!
    @IBOutlet weak var lblstartdatetitle: UILabel!
    @IBOutlet weak var lblinvitationtitle: UILabel!
    @IBOutlet weak var lbltitleEnddate: UILabel!
    @IBOutlet weak var lblstatus: UILabel!
    @IBOutlet weak var lblplace: UILabel!
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var lblinvitations: UILabel!
    @IBOutlet weak var lblstartDate: UILabel!
    
    @IBOutlet weak var lblendDate: UILabel!
    
    @IBOutlet weak var lblreservation: UILabel!
    
    
    
    
    //MARK:- back function intializing here 
    var callBack: ((_ done: Bool) -> (Void))? = nil
    var moreDetailcallBack: ((_ done: Bool) -> (Void))? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        viewDesign()
        
        self.lbleventtitle.text = "Nombre del evento".localized
        self.lblhosttitle.text = "Anfitrión".localized
        self.lblplacetitle.text = "Lugar".localized
        self.lblinvitationtitle.text = "Invitaciones";
        self.lblstartdatetitle.text = "Inicio".localized
        self.lbltitleEnddate.text = "Fin".localized
        self.lblreservationtitle.text = "Reservación".localized
        self.lblmoredetail.text = "MAS DETALLES".localized
        //self.lblqrCodeTitle.text = "GENERAR QR".localized
        self.lbldurationtitle.text = "Duración".localized
    }

    
    func viewDesign() {
        mapView.roundViewWithCustomRadius(radius: 5)
        qrView.roundViewWithCustomRadius(radius: 5)
        mainView.layer.cornerRadius = 8
        mainView.layer.shadowColor = #colorLiteral(red: 0.423489809, green: 0.4235547483, blue: 0.4234756231, alpha: 1)
        mainView.layer.shadowRadius = 4.0
        mainView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        mainView.layer.shadowOpacity = 1.0
        mainView.layer.masksToBounds = false
    }
    
    
    
    @IBAction func mapAction(_ sender: UIButton) {
        callBack?(true)
    }
    
    
    @IBAction func qrAction(_ sender: UIButton) {
        callBack?(false)
    }
    
    
    @IBAction func moreDetailAction(_ sender: UIButton) {
        moreDetailcallBack?(true)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
