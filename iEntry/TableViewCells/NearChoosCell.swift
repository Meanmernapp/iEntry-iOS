//
//  NearChoosCell.swift
//  iEntry
//
//  Created by ZAFAR on 12/08/2021.
//

import UIKit

class NearChoosCell: UITableViewCell {
    //MARK:- here are the IBOutlet
    
    
    @IBOutlet weak var iscommenareaicon: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblvenu: UILabel!
    
    @IBOutlet weak var lblactive: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        viewDesign()
        if myDefaultLanguage == .en {
            self.lblactive.text = "ACTIVE"
        } else {
            self.lblactive.text = "ACTIVO"
        }
    }
    
    //MARK:- design set here
    func viewDesign() {
        
        mainView.layer.cornerRadius = 8
        mainView.layer.shadowColor = #colorLiteral(red: 0.6744349003, green: 0.6745528579, blue: 0.6744274497, alpha: 1)
        mainView.layer.shadowRadius = 4.0
        mainView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        mainView.layer.shadowOpacity = 1.0
        mainView.layer.masksToBounds = false
        
        img.roundImageWithCustomRadius(radius: 8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
