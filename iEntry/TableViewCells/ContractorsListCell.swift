//
//  ContractorsListCell.swift
//  iEntry
//
//  Created by ZAFAR on 01/09/2021.
//

import UIKit

class ContractorsListCell: UITableViewCell {
    //MARK:- here are the IBOutlet
    @IBOutlet weak var lblactive: UILabel!
    @IBOutlet weak var mainView: UIView!
    //MARK:- call back funtion intializing here 
    var callBack : ((_ isBack:Bool) ->Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        mainView.shadowAndRoundcorner(cornerRadius: 15, shadowColor: #colorLiteral(red: 0.6822772622, green: 0.6823965311, blue: 0.682269752, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1)

        if myDefaultLanguage == .en {
            self.lblactive.text = "ACTIVE"
        } else {
            self.lblactive.text = "ACTIVO"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func DeatilAction(_ sender: UIButton) {
        callBack?(true)
    }
}
