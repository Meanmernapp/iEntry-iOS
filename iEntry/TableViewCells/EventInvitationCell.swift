//
//  EventInvitationCell.swift
//  iEntry
//
//  Created by ZAFAR on 13/08/2021.
//

import UIKit

class EventInvitationCell: UITableViewCell {
    //MARK:- here are the IBOutlet
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        mainView.shadowAndRoundcorner(cornerRadius: 10, shadowColor: #colorLiteral(red: 0.6822772622, green: 0.6823965311, blue: 0.682269752, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
