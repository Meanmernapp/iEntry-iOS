//
//  PayRollCell.swift
//  iEntry
//
//  Created by ZAFAR on 03/09/2021.
//

import UIKit

class PayRollCell: UITableViewCell {
    //MARK:- here are the IBOutlet
    @IBOutlet weak var mainView: UIView!
    //MARK:- callback function intializing here 
    var callBack:((_ iSDetail:Bool) ->Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        mainView.shadowAndRoundcorner(cornerRadius: 15, shadowColor: #colorLiteral(red: 0.6822772622, green: 0.6823965311, blue: 0.682269752, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deatilAction(_ sender: UIButton) {
        callBack?(true)
    }
    
}
