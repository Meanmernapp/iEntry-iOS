//
//  VehicalDataViewController.swift
//  iEntry
//
//  Created by HaiDer's Macbook Pro on 19/01/2023.
//

import UIKit

class VehicalDataViewController: UIViewController {
    
    
    var data : VehicalModelData?
    
    //MARK: - IBOutlets
    
    //MARK: - translationlabel
    
    @IBOutlet weak var curvView: UIView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var vehicalImg: UIImageView!
    @IBOutlet weak var dataLbl: UILabel!
    @IBOutlet weak var infromationLbl: UILabel!
    @IBOutlet weak var marcaLbl: UILabel!
    @IBOutlet weak var subMarcaLbl: UILabel!
    @IBOutlet weak var colorLbl: UILabel!
    @IBOutlet weak var snLbl: UILabel!
    @IBOutlet weak var vinLbl: UILabel!
    @IBOutlet weak var placeLbl: UILabel!
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var mainStatusView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    //MARK: - ValuesLabel
    
    @IBOutlet weak var marcaValueLbl: UILabel!
    @IBOutlet weak var placeValueLbl: UILabel!
    @IBOutlet weak var modelValueLbl: UILabel!
    @IBOutlet weak var colorValueLbl: UILabel!
    @IBOutlet weak var subMarcaValueLbl: UILabel!
    @IBOutlet weak var vinValueLbl: UILabel!
    @IBOutlet weak var sinValueLbl: UILabel!
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    //MARK: - Functions
    
    func setup() {
        curvView.roundCorners([.topLeft,.bottomLeft], radius: 5)
        mainView.layer.cornerRadius = 36
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        mainView.layer.masksToBounds = true
        if let data = data {
            self.marcaValueLbl.text = data.brand.putDashes()
            self.subMarcaValueLbl.text = data.subBrand.putDashes()
            self.placeValueLbl.text = data.plate.putDashes()
            let model : String? = "\(data.model ?? 0)"
            self.modelValueLbl.text = model.putDashes()
            self.colorValueLbl.text = data.color.putDashes()
            self.vinValueLbl.text = data.vin.putDashes()
            self.sinValueLbl.text = data.serialNumber.putDashes()
            statusUpdate(data: data)
            
        }
        self.infromationLbl.text = "INFORMACIÓN GENERAL".localized
        self.dataLbl.text = "Datos".localized
        self.colorLbl.text = "COLOR".localized
        self.modelLbl.text = "MODELO".localized
        self.marcaLbl.text = "MARCA".localized
        self.subMarcaLbl.text = "SUB-MARCA".localized
        self.placeLbl.text = "PLACAS".localized
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
//        else {
//            self.statusLbl.text = ""
//            self.statusView.backgroundColor = .clear
//            self.mainStatusView.backgroundColor = .clear
//        }
    }
    //MARK: - IBAction
    
    

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
