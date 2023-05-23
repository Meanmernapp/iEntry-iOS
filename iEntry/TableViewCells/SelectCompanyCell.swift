//
//  SelectCompanyCell.swift
//  iEntry
//
//  Created by ZAFAR on 16/10/2021.
//

import UIKit

class SelectCompanyCell: UITableViewCell {
    //MARK:- here are the IBOutlet
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
