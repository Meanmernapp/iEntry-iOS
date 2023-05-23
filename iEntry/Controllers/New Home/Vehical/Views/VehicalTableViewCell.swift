//
//  VehicalTableViewCell.swift
//  iEntry
//
//  Created by HaiDer's Macbook Pro on 17/01/2023.
//

import UIKit

class VehicalTableViewCell: UITableViewCell {
    
    
    //MARK: - IBOutlets

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var subName: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var colorLbl: UILabel!
    @IBOutlet weak var modelnumberLbl: UILabel!
    @IBOutlet weak var snLbl: UILabel!
    @IBOutlet weak var placeLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    //MARK: - Title Outlets
    
    @IBOutlet weak var colorTitleLbl: UILabel!
    @IBOutlet weak var modelTitleLbl: UILabel!
    @IBOutlet weak var snTitleLbl: UILabel!
    @IBOutlet weak var placeTitleLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    //MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.shadowAndRoundcorner(cornerRadius: 8, shadowColor: #colorLiteral(red: 0.7293313146, green: 0.7294581532, blue: 0.7293233275, alpha: 1), shadowRadius: 4, shadowOpacity: 1)
    }
    
    func config(data:VehicalModelData?) {
        
        //MARK: - Titles
        
        self.colorTitleLbl.text = "COLOR".localized + " :"
        self.modelTitleLbl.text = "MODELO".localized + " :"
        self.placeTitleLbl.text = "PLACAS".localized + " :"
        //MARK: - Values
        
        self.nameLbl.text = "\(data?.brand ?? "") : "
        self.subName.text = data?.subBrand
        self.modelnumberLbl.text = "\(data?.model ?? 0)"
        self.colorLbl.text = data?.color.putDashes()
        self.placeLbl.text = data?.plate.putDashes()
        self.snLbl.text = data?.vin.putDashes()
        statusUpdate(data: data)
    }
    
    func statusUpdate(data:VehicalModelData?) {
        if data?.status == 1 {
            self.statusLbl.text = "PRE REGISTRO".localized
            self.statusLbl.textColor = UIColor(hexString: "707070")
            self.statusView.backgroundColor = UIColor(hexString: "707070")
        }
        else
        if data?.status == 2 {
            self.statusLbl.text = "PARA CAMBIAR CONTRASEÑA".localized
            self.statusLbl.textColor = UIColor(hexString: "F2A100")
            self.statusView.backgroundColor = UIColor(hexString: "F2A100")
        }
        else
        if data?.status == 3 {
            self.statusLbl.text = "PARA APROBAR DOCUMENTO".localized
            self.statusLbl.textColor = UIColor(hexString: "006594")
            self.statusView.backgroundColor = UIColor(hexString: "006594")
        }
        else
        if data?.status == 4 {
            self.statusLbl.text = "ACTIVO".localized
            self.statusLbl.textColor = UIColor(hexString: "146F62")
            self.statusView.backgroundColor = UIColor(hexString: "146F62")
        }
        if data?.status == 5 {
            self.statusLbl.text = "DE VACACIONES".localized
            self.statusLbl.textColor = UIColor(hexString: "FF8B13")
            self.statusView.backgroundColor = UIColor(hexString: "FF8B13")
        }
        if data?.status == 6 {
            self.statusLbl.text = "INACTIVO".localized
            self.statusLbl.textColor = UIColor(hexString: "BC0000")
            self.statusView.backgroundColor = UIColor(hexString: "BC0000")
        }
    }
    
}
