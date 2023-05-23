//
//  InvitarCell.swift
//  iEntry
//
//  Created by ZAFAR on 04/10/2021.
//

import UIKit

class InvitarCell: UITableViewCell {
    //MARK:- here are the IBOutlet
    
    @IBOutlet weak var lblphonetitle: UILabel!
    @IBOutlet weak var lblnametitle: UILabel!
    @IBOutlet weak var indicatorimg: UIImageView!
    @IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var lblnumber: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var mainView: UIView!
    //MARK:- call back function intializing
    var callBack: ((_ done: Bool) -> (Void))? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblnametitle.text = "Nombre:".localized
        self.lblphonetitle.text = "Celular:".localized
        self.selectionStyle = .none
        mainView.shadowAndRoundcorner(cornerRadius: 15, shadowColor: #colorLiteral(red: 0.6822772622, green: 0.6823965311, blue: 0.682269752, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    @IBAction func statusAction(_ sender: UIButton) {
        callBack?(true)
    }
}
