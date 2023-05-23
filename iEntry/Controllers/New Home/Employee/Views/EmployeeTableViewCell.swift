//
//  EmployeeTableViewCell.swift
//  iEntry
//
//  Created by HaiDer's Macbook Pro on 17/01/2023.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    //MARK: - IBOutlets

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var numberLbl: UILabel!
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    //MARK: - Title Outlets
    
    @IBOutlet weak var emailTitleLbl: UILabel!
    @IBOutlet weak var numberTitleLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.shadowAndRoundcorner(cornerRadius: 8, shadowColor: #colorLiteral(red: 0.7293313146, green: 0.7294581532, blue: 0.7293233275, alpha: 1), shadowRadius: 4, shadowOpacity: 1)
        // Initialization code
    }

    func config(data:EmployeeUserDetailsData?) {
        
        //MARK: - Titles
        
        self.emailTitleLbl.text = "CORREO".localized + " :"
        self.numberTitleLbl.text = "NÚMERO".localized + " :"
        
        //MARK: - Values
        
        self.nameLbl.text = "\(data?.name ?? "") \(data?.lastName ?? "")"
        self.emailLbl.text = data?.email.putDashes()
        self.numberLbl.text = data?.phoneNumber.putDashes()
        if data?.genderID == 2 {
            self.userImg.image = UIImage(named: "employeeFemail")
        }
        else {
            self.userImg.image = UIImage(named: "employeeMale")
        }
        statusUpdate(data: data?.statusId)
    }
    
    func statusUpdate(data:Int?) {
        if data == 1 {
            self.statusLbl.text = "PRE REGISTRO".localized
            self.statusLbl.textColor = UIColor(hexString: "707070")
            self.statusView.backgroundColor = UIColor(hexString: "707070")
        }
        else
        if data == 2 {
            self.statusLbl.text = "PARA CAMBIAR CONTRASEÑA".localized
            self.statusLbl.textColor = UIColor(hexString: "A2CBF4")
            self.statusView.backgroundColor = UIColor(hexString: "A2CBF4")
        }
        else
        if data == 3 {
            self.statusLbl.text = "PARA APROBAR DOCUMENTO".localized
            self.statusLbl.textColor = UIColor(hexString: "006594")
            self.statusView.backgroundColor = UIColor(hexString: "006594")
        }
        else
        if data == 4 {
            self.statusLbl.text = "ACTIVO".localized
            self.statusLbl.textColor = UIColor(hexString: "146F62")
            self.statusView.backgroundColor = UIColor(hexString: "146F62")
        }
        if data == 5 {
            self.statusLbl.text = "DE VACACIONES".localized
            self.statusLbl.textColor = UIColor(hexString: "FF8B13")
            self.statusView.backgroundColor = UIColor(hexString: "FF8B13")
        }
        if data == 6 {
            self.statusLbl.text = "INACTIVO".localized
            self.statusLbl.textColor = UIColor(hexString: "BC0000")
            self.statusView.backgroundColor = UIColor(hexString: "BC0000")
        }
    }
    
}
