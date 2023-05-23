//
//  ContractsListCell.swift
//  iEntry
//
//  Created by ZAFAR on 01/09/2021.
//

import UIKit

class ContractsListCell: UITableViewCell {
    //MARK:- here are the IBOutlet
    @IBOutlet weak var lblstatrdatetitle: UILabel!
    
    @IBOutlet weak var lbldetailtitle: UILabel!
    @IBOutlet weak var lblbusinesstitle: UILabel!
    @IBOutlet weak var lblenddatetitle: UILabel!
    @IBOutlet weak var lbltypeofmaxicogrouptitle: UILabel!
    @IBOutlet weak var lblcompanyName: UILabel!
    @IBOutlet weak var lblendDate: UILabel!
    @IBOutlet weak var lblstartDate: UILabel!
    @IBOutlet weak var lblusername: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var lblstatsu: UILabel!
    @IBOutlet weak var lblcontractNumber: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var folioTxt: UILabel!
    //MARK:- call back function intializing here
    var callBack: ((_ done: Bool) -> (Void))? = nil
    var moreDetailcallBack: ((_ done: Bool) -> (Void))? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        viewDesign()
    }
    //MARK:- set the design 
    func viewDesign() {
        mainView.layer.cornerRadius = 8
        mainView.layer.shadowColor = #colorLiteral(red: 0.423489809, green: 0.4235547483, blue: 0.4234756231, alpha: 1)
        mainView.layer.shadowRadius = 4.0
        mainView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        mainView.layer.shadowOpacity = 1.0
        mainView.layer.masksToBounds = false
        self.lblbusinesstitle.text = "Empresa".localized
        self.lblstatrdatetitle.text = "Inicio de contrato".localized
        self.lblenddatetitle.text = "Fin de contrato".localized
        self.lbltypeofmaxicogrouptitle.text = "Grupo Tepeyac Mexico".localized
    }
    
    
    @IBAction func moreDetailAction(_ sender: UIButton) {
        moreDetailcallBack?(true)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
