//
//  NewNotificationCell.swift
//  iEntry
//
//  Created by ZAFAR on 08/02/2022.
//

import UIKit

class NewNotificationCell: UITableViewCell {
    //MARK:- here are the IBOutlet
    @IBOutlet weak var mainView: UIView!
//    @IBOutlet weak var lblrole: UILabel!
//    @IBOutlet weak var lblname: UILabel!
//    @IBOutlet weak var tick: UIImageView!
//    @IBOutlet weak var lblphone: UILabel!
    @IBOutlet weak var lblrole: UILabel!
    @IBOutlet weak var lblphone: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var btncheckbox: UIButton!
    var callBack: ((_ done: Bool) -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        mainView.shadowAndRoundcorner(cornerRadius: 15, shadowColor: #colorLiteral(red: 0.6822772622, green: 0.6823965311, blue: 0.682269752, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    @IBAction func cancelAction(_ sender: UIButton) {
//        callBack?(true)
    //}
    
}
