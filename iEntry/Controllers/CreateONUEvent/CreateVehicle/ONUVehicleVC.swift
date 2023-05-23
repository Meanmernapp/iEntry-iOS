//
//  ONUVehicleVC.swift
//  iEntry
//
//  Created by ZAFAR on 30/04/2022.
//

import UIKit
import DropDown
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class ONUVehicleVC: BaseController {
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var lblcanceltitle: UILabel!
    var param = eventDic()
    @IBOutlet weak var btnaddvehicletitle: UIButton!
    @IBOutlet weak var lblvehicleCounts: UILabel!
    @IBOutlet weak var lblnexttitle: UILabel!
    var vehiclListdata : [GetVehicleListModelData]?
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btncanceltitle: UIButton!
    @IBOutlet weak var txtvehicle: MDCOutlinedTextField!
    @IBOutlet weak var lblcreateEventtitle: UILabel!
    var MainDrowpDown = DropDown()
    @IBOutlet weak var lblvehicletitle: UILabel!
    var selectVehicle = [SelectedVehicleListData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblcreateEventtitle.text = "CREAR EVENTO".localized
        self.btnaddvehicletitle.setTitle("DA DE ALTA UN NUEVO VEHÍCULO".localized, for: .normal)
        self.lblcanceltitle.text = "ANTERIOR".localized
        self.lblnexttitle.text = "SIGUIENTE".localized
        self.tblView.isHidden = true
        self.emptyView.isHidden = false
        self.getVehicleListApi()
        setMDCTxtFieldDesign(txtfiled: txtvehicle, Placeholder: "VEHÍCULOS".localized, imageIcon: UIImage(named: "sort-down-solid")!)
        self.lblvehicletitle.text = "VEHÍCULOS".localized
        self.tblView.register(UINib.init(nibName: "ONUVehicleCell", bundle: nil), forCellReuseIdentifier: "ONUVehicleCell")
    }
    
    @IBAction func selectionVehicleAction(_ sender: UIButton) {
        
        var  vehicleList = [String]()
     for item in self.vehiclListdata ?? [] {
         vehicleList.append(item.vehicle?.brand ?? "")
     }
        dropDownConfig(txtField: txtvehicle
                       , data: vehicleList)
        
    }
    
    @IBAction func registerVehicleAction(_ sender: UIButton) {
        
        
        let storyBoard = UIStoryboard.init(name: "ONUEvent", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"CreateVehicleVC") as? CreateVehicleVC
        vc?.callBack = {
            vc?.dismiss(animated: true, completion: nil)
            self.getVehicleListApi()
        }
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func continueAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "ONUEvent", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"TransportRequiredVC") as? TransportRequiredVC
        vc?.param =  self.param
        vc?.selectVehicle = self.selectVehicle
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    @IBAction func ActionToBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getVehicleListApi(){
        self.showLoader()
        userhandler.getVehicleListByCompanyID(Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.vehiclListdata = response?.data
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    //MARK:- this is general funtion that will use to appear the dropdown
    func dropDownConfig(txtField : UITextField, data:[String]) {
        MainDrowpDown.anchorView = txtField
        MainDrowpDown.backgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        MainDrowpDown.selectionBackgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        MainDrowpDown.dataSource =  data
        DropDown.appearance().textColor = #colorLiteral(red: 0.5527616143, green: 0.5568413734, blue: 0.5609211326, alpha: 1)
        DropDown.appearance().selectedTextColor = UIColor.red
        //DropDown.appearance().textFont = UIFont(name: "JosefinSans-Regular", size: 18)!
        self.MainDrowpDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            
            cell.optionLabel.textAlignment = .left
            
        }
        
        MainDrowpDown.bottomOffset = CGPoint(x: 0, y: txtField.bounds.height)
        MainDrowpDown.selectionAction = { [self](index: Int, item: String) in
            print(item)

//            self.txtvehicle.text = item
            if !self.selectVehicle.contains(where: { $0.id == self.vehiclListdata?[index].vehicle?.id ?? "" }) {
                
            self.selectVehicle.append(SelectedVehicleListData(id:self.vehiclListdata?[index].vehicle?.id ?? "" , place: vehiclListdata?[index].vehicle?.plate ?? "", brand: vehiclListdata?[index].vehicle?.brand ?? "", sub_brand: vehiclListdata?[index].vehicle?.brand ?? "", vin: vehiclListdata?[index].vehicle?.plate ?? ""))
                
                self.tblView.isHidden = false
                self.emptyView.isHidden = true
            }
            
            self.lblvehicleCounts.text = "\(self.selectVehicle.count) Vehículos"
            self.tblView.reloadData()
        }
        MainDrowpDown.show()
    }
    
}
extension ONUVehicleVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectVehicle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ONUVehicleCell") as? ONUVehicleCell
        
        cell?.lblvin.text = self.selectVehicle[indexPath.row].vin
        cell?.lblbrand.text = self.selectVehicle[indexPath.row].brand
        cell?.lblsubbrand.text = self.selectVehicle[indexPath.row].brand
        cell?.lblplate.text = self.selectVehicle[indexPath.row].place
        
        return cell!
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .normal, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                self.selectVehicle.remove(at: indexPath.row)
                self.lblvehicleCounts.text = "\(self.selectVehicle.count) Vehículos"
                self.tblView.reloadData()
                })
            deleteAction.image = UIImage(named: "ic-trash-outline")
            deleteAction.backgroundColor = UIColor.red
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
    
    
}


struct SelectedVehicleListData {
    var id:String?
    var place:String?
    var brand:String?
    var sub_brand :String?
    var vin:String?
}
