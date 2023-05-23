//
//  EmployeeCell.swift
//  iEntry
//
//  Created by ZAFAR on 16/08/2021.
//

import UIKit

class EmployeeCell: UICollectionViewCell {
    @IBOutlet weak var lblgender: UILabel!
    
    @IBOutlet weak var btnedit: UIButton!
    @IBOutlet weak var lblBOD: UILabel!
    @IBOutlet weak var lblphone: UILabel!
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var lblactive: UILabel!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var employeeimg: UIImageView!
    @IBOutlet weak var mainView: UIView!
       
    
    override func awakeFromNib() {
        super.awakeFromNib()
        employeeimg.roundViiew()
        mainView.shadowAndRoundcorner(cornerRadius: 6, shadowColor: #colorLiteral(red: 0.7293313146, green: 0.7294581532, blue: 0.7293233275, alpha: 1), shadowRadius: 4, shadowOpacity: 1)
    }
    
    @IBAction func editAction(_ sender: UIButton) {
    }
    
}
