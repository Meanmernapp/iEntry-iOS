//
//  ProviderDetailVC.swift
//  iEntry
//
//  Created by ZAFAR on 10/03/2022.
//

import UIKit

class ProviderDetailVC: BaseController {
    
    @IBOutlet weak var lblsupliretitle: UILabel!
    @IBOutlet weak var lbldeliverytitle: UILabel!
    @IBOutlet weak var lblcompany: UILabel!
    @IBOutlet weak var lblemployee: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var lblstatus: UILabel!
    @IBOutlet weak var lblvihicl: UILabel!
    @IBOutlet weak var eatTitle: UILabel!
    @IBOutlet weak var lblproducttitle: UILabel!
    @IBOutlet weak var lbluserdeliverytitle: UILabel!
    @IBOutlet weak var lblinformationtitle: UILabel!
    @IBOutlet weak var lbldeliverydate: UILabel!
    @IBOutlet weak var lbldeliveryproduct: UILabel!
    @IBOutlet weak var lbldeliveryDiscription: UILabel!
    @IBOutlet weak var lbldeliverydatetitle: UILabel!
    @IBOutlet weak var lblcompanytitle: UILabel!
    @IBOutlet weak var recieverView: UIView!
    @IBOutlet weak var lbldescriptiontitle: UILabel!
    @IBOutlet weak var lblemployeetitle: UILabel!
    @IBOutlet weak var lblvehiclTitle: UILabel!
    @IBOutlet weak var lblrecieverDate: UILabel!
    @IBOutlet weak var lblrecieverusername: UILabel!
    @IBOutlet weak var folioNumber: UILabel!
    @IBOutlet weak var folioLbl: UILabel!
    
    var isfromcurrentorder = false
    var ordersdata :ProviderModelsData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblinformationtitle.text = "INFORMACIÓN DEL PROVEEDOR".localized.uppercased()
        self.lblcompanytitle.text = "Compañia".localized.uppercased()
        self.lblemployeetitle.text = "Empleado".localized.uppercased()
        self.lbldeliverytitle.text = "INFORMACIÓN DE ENTREGA".localized.uppercased()
        self.lblproducttitle.text = "Producto".localized.uppercased()
        self.lbldescriptiontitle.text = "Descripción".localized.uppercased()
        self.lblsupliretitle.text = "INFORMACIÓN DEL PROVEEDOR".localized.uppercased()
        self.lbldeliverydatetitle.text = "Fecha de entrega".localized.uppercased()
        self.lbluserdeliverytitle.text = "Recibido por".localized.uppercased()
        self.lblvehiclTitle.text = "Vehículo".localized.uppercased()
        self.folioLbl.text = "Folio #".localized
        self.navigationBarHidShow(isTrue: true)
        self.configData()
    }
    
    func configData(){
        self.folioNumber.text = "\(self.ordersdata?.folio.putDashes() ?? "-")"
        self.lblcompany.text = self.ordersdata?.supplierCompanyName.putDashes()
        self.lblemployee.text = "\(self.ordersdata?.supplierName ?? "") \(self.ordersdata?.supplierLastName ?? "") \(self.ordersdata?.supplierSecondLastName ?? "")"
        self.lblvihicl.text = self.ordersdata?.supplierVehicleBrand.putDashes()
        self.lbldeliverydate.text = self.getFormattedMilisecondstoDate(seconds: "\(self.ordersdata?.deliveryDate ?? 0)", formatter: "");
        self.lbldeliveryDiscription.text = self.ordersdata?.description.putDashes()
        self.lbldeliveryproduct.text = self.ordersdata?.item.putDashes()
        
        if self.ordersdata?.statusId == 29 {
            self.lblstatus.textColor = UIColor(hexString: "006594")
            self.statusView.backgroundColor = UIColor(hexString: "006594")
            self.lblstatus.text = "ORDER ON COURSE"
        }else if self.ordersdata?.statusId == 30 {
            self.lblstatus.textColor = #colorLiteral(red: 0.9481226802, green: 0.630784452, blue: 0, alpha: 1)
           self.statusView.backgroundColor = #colorLiteral(red: 0.9402042627, green: 0.6268541217, blue: 0, alpha: 1)
            self.lblstatus.text = "ORDER DELIVERED"
        }else if self.ordersdata?.statusId == 36 {
            self.lblstatus.textColor = #colorLiteral(red: 0.7379251719, green: 0.001223876374, blue: 0, alpha: 1)
            self.statusView.backgroundColor = #colorLiteral(red: 0.7379251719, green: 0.001223876374, blue: 0, alpha: 1)
            self.lblstatus.text = "ORDER CANCELED"
        }
        else if self.ordersdata?.statusId == 28 {
            self.lblstatus.textColor = UIColor(hexString: "707070")
            self.statusView.backgroundColor = UIColor(hexString: "707070")
            self.lblstatus.text = "ORDER INCOMPLETE"
        }
        self.lblrecieverDate.text = self.getFormattedMilisecondstoDate(seconds: "\(self.ordersdata?.createdAt ?? 0)", formatter: "");
        let name = "\(self.ordersdata?.userReceivedName ?? "") \(self.ordersdata?.userReceivedLastName ?? "") \(self.ordersdata?.userReceivedLastName ?? "")"
        self.lblrecieverusername.text = name == "" ? "-" : name
    }

    
    @IBAction func backaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
