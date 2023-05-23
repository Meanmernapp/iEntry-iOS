//
//  InvitationRecordCell.swift
//  iEntry
//
//  Created by ZAFAR on 01/10/2021.
//

import UIKit

class InvitationRecordCell: UITableViewCell {
    //MARK:- here are the IBOutlet
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lblphone: UILabel!
    @IBOutlet weak var lblname: UILabel!
    
    
    
    //MARK:- call back function intializing here 
    var callBack: ((_ done: Bool) -> (Void))? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        mainView.shadowAndRoundcorner(cornerRadius: 15, shadowColor: #colorLiteral(red: 0.6822772622, green: 0.6823965311, blue: 0.682269752, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func popUpAction(_ sender: UIButton) {
          callBack?(true)
    }
}
