//
//  menuCell.swift
//  iEntry
//
//  Created by ZAFAR on 11/08/2021.
//

import UIKit

class menuCell: UITableViewCell {
    //MARK:- here are the IBOutlet
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lbltile: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.img.tintColor = .white
            self.lbltile.textColor = .white
        } else {
            self.img.tintColor = .white
            self.lbltile.textColor = .black
        }
        
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
          super.setHighlighted(highlighted, animated: animated)
          
          if highlighted {
              self.lbltile.textColor = .white
              self.img.tintColor = .white
          } else {
              self.lbltile.textColor = .black
              self.img.tintColor = .black
          }
      }
}
