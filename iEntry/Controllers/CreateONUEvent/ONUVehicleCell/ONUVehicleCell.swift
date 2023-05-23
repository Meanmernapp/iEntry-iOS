//
//  ONUVehicleCell.swift
//  iEntry
//
//  Created by ZAFAR on 30/04/2022.
//

import UIKit

class ONUVehicleCell: UITableViewCell {
    @IBOutlet weak var lblbrandtitle: UILabel!
    
    @IBOutlet weak var lblvintitle: UILabel!
    @IBOutlet weak var lblplatetitle: UILabel!
    @IBOutlet weak var lblsubmodeltitle: UILabel!
    @IBOutlet weak var lblplate: UILabel!
    @IBOutlet weak var lblvin: UILabel!
    @IBOutlet weak var lblsubbrand: UILabel!
    @IBOutlet weak var lblbrand: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.lblbrandtitle.text = "Marca:".localized
        self.lblsubmodeltitle.text = "Sub-Marca:".localized
        self.lblplatetitle.text = "Placas: ".localized
        self.lblvintitle.text = "VIN:".localized
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
