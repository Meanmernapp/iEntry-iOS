//
//  OrderHistoryCell.swift
//  iEntry
//
//  Created by ZAFAR on 15/11/2021.
//

import UIKit

class OrderHistoryCell: UITableViewCell {
    //MARK:- here the iboutlet
    
    @IBOutlet weak var lbldeliverytitle: UILabel!
    
    @IBOutlet weak var lbldeliveryproducttitle: UILabel!
    @IBOutlet weak var lbletatitle: UILabel!
    
    @IBOutlet weak var lblmoretitle: UILabel!
    @IBOutlet weak var lbldeadlinetitle: UILabel!
    @IBOutlet weak var lblreceivedbytitle: UILabel!
    @IBOutlet weak var lbldeliverydetailtitle: UILabel!
    @IBOutlet weak var lbldeliverycompanytitle: UILabel!
    @IBOutlet weak var lblprovideremployeetitle: UILabel!
    @IBOutlet weak var lblprovidercompanytitle: UILabel!
    @IBOutlet weak var lblprovidertitle: UILabel!
    
    @IBOutlet weak var lblstatus: UILabel!
    
    @IBOutlet weak var statusView: UIView!
    
    @IBOutlet weak var lblprovidervehicletitle: UILabel!
    @IBOutlet weak var lblcompany: UILabel!
    
    @IBOutlet weak var lblemployee: UILabel!
    
    @IBOutlet weak var lblvehicle: UILabel!
    
    @IBOutlet weak var lbldeliverydate: UILabel!
    @IBOutlet weak var lbldeliverycompany: UILabel!
    
    @IBOutlet weak var lbldeliveryproduct: UILabel!
    @IBOutlet weak var lbldeliverydetail: UILabel!
    
    
    @IBOutlet weak var lblrecieverdate: UILabel!
    @IBOutlet weak var lblreceiver: UILabel!
    @IBOutlet weak var folioTxt: UILabel!
    @IBOutlet weak var mainView: UIView!
    //MARK:- calback funtion intializing here
    var callBack: ((_ done: Bool) -> (Void))? = nil
    var moreDetailcallBack: ((_ done: Bool) -> (Void))? = nil
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        viewDesign()
        
        self.lblprovidertitle.text = "INFORMACIÓN DEL PROVEEDOR".localized
        self.lblprovidercompanytitle.text = "Compañia".localized
        self.lblprovideremployeetitle.text = "Empleado".localized
        self.lblprovidervehicletitle.text = "Vehículo".localized
        self.lbldeliverytitle.text = "INFORMACIÓN DE ENTREGA".localized
        self.lbletatitle.text = "ETA".localized
        self.lbldeliverycompanytitle.text = "Compañia".localized
        
        self.lbldeliveryproducttitle.text = "Producto".localized
        
        self.lbldeliverydetailtitle.text = "Descripción".localized
        self.lblreceivedbytitle.text = "Recibido por".localized
        self.lbldeadlinetitle.text = "Fecha de entrega".localized
        self.lblmoretitle.text = "VER DETALLES".localized
        
    }

    func viewDesign() {
        mainView.layer.cornerRadius = 8
        mainView.layer.shadowColor = #colorLiteral(red: 0.423489809, green: 0.4235547483, blue: 0.4234756231, alpha: 1)
        mainView.layer.shadowRadius = 4.0
        mainView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        mainView.layer.shadowOpacity = 1.0
        mainView.layer.masksToBounds = false
    }
    
    
    @IBAction func moreDetailAction(_ sender: UIButton) {
        moreDetailcallBack?(true)
    }
    
}
