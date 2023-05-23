//
//  NewInvitationCell.swift
//  iEntry
//
//  Created by ZAFAR on 01/10/2021.
//

import UIKit

class NewInvitationCell: UITableViewCell {
    //MARK:- here are the IBOutlet
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblstatus: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var lblmaptitle: UILabel!
    @IBOutlet weak var lblgenratetitle: UILabel!
    @IBOutlet weak var lblemployeetitle: UILabel!
    @IBOutlet weak var lblcompanyName: UILabel!
    
    @IBOutlet weak var lblinvitationdatetitle: UILabel!
    @IBOutlet weak var lblhostName: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    
    
    @IBOutlet weak var lblhosttitle: UILabel!
    
    
    
    //MARK:- callback function intializing here
    var callBack: ((_ done: Bool) -> (Void))? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblemployeetitle.text = "Compañia".localized
        
        self.lblhosttitle.text = "Anfitrión".localized
        self.lblinvitationdatetitle.text = "Fecha y Hora".localized
        self.lblgenratetitle.text = "GENERAR QR".localized
        self.lblmaptitle.text = "EVENTO".localized
        self.selectionStyle = .none
        mainView.shadowAndRoundcorner(cornerRadius: 15, shadowColor: #colorLiteral(red: 0.6822772622, green: 0.6823965311, blue: 0.682269752, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func mapAction(_ sender: UIButton) {
        callBack?(true)
    }
    @IBAction func QrAction(_ sender: UIButton) {
        callBack?(false)
    }
}
