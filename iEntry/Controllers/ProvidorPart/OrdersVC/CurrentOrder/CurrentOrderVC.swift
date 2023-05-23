//
//  CurrentOrderVC.swift
//  iEntry
//
//  Created by ZAFAR on 15/11/2021.
//

import UIKit
import XLPagerTabStrip
class CurrentOrderVC: BaseController,IndicatorInfoProvider {
    //MARK:- tab delegate
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "ORDENES EN CURSO".localized)
    }
    @IBOutlet weak var emptyView: UIView!
    
    var providerdata : ProviderUserByIdModelData?
    var contractdata : GetContractorByUserIdModelData?
    var ordersdata = [ProviderModelsData]()
    
    let refreshControl = UIRefreshControl()
    
    //MARK: - here are the iboutlet
    
    
    @IBOutlet weak var tblView: UITableView!
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblView.register(UINib.init(nibName: "CurrentOrderCells", bundle: nil), forCellReuseIdentifier: "CurrentOrderCells")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblView.addSubview(refreshControl)
        fetchData()
        
    }
    @objc func refresh(_ sender: AnyObject) {
        refreshControl.endRefreshing()
        fetchData()
    }
    func fetchData() {
        if Network.isAvailable {
        if ShareData.shareInfo.userRole == .provideremployee {
                self.getProvideremployeeApi()
        } else {
                self.getProviderApi()
        }
    } else{
        AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
        self.ordersdata = ShareData.shareInfo.currentOrderData ?? []
        self.tblView.isHidden = false
        self.emptyView.isHidden = true
        if self.ordersdata.count == 0 {
            self.tblView.isHidden = true
            self.emptyView.isHidden = false
        }
        self.tblView.reloadData()
    }
    }
    
    func getProviderApi(){
        userhandler.getProviderByUserIDs(userid: ShareData.shareInfo.obj?.id ?? "", Success: { response in
            if response?.success == true {
                self.contractdata = response?.data
                ShareData.shareInfo.saveContractorListGetByUserid(contractor: (response?.data)!)
                print(ShareData.shareInfo.contractorListdataValueGetByUserid as Any)
                self.getproviderorderRecordsapi()
            } else {
                
            }
        }, Failure: {error in
            
        })
    }
    
    
    
    func getProvideremployeeApi(){
        userhandler.getProviderEmployeeByUserIDs(userid: ShareData.shareInfo.obj?.id ?? "", Success: { response in
            if response?.success == true {
                self.providerdata = response?.data
                ShareData.shareInfo.saveproviderEmployeeGetByUserid(provideremployee: (response?.data)!)
                
                self.getproviderorderRecordsapi()
            } else {
                
            }
        }, Failure: {error in
            
        })
    }
    
    func getproviderorderRecordsapi(){
        self.showLoader()
        userhandler.getBeforeDateProviderOrdersByUserIDs(userid: ShareData.shareInfo.userRole == .provider ? ShareData.shareInfo.contractorListdataValueGetByUserid?.id ?? "" : ShareData.shareInfo.providerEmployeedataValueGetByUserid?.id ?? "" , datevalue:"\(StartDayMiliSeconds(newdate: Date().startOfDay()!) ?? 0)" , isproviderEmployee: ShareData.shareInfo.userRole == .provider ? false : true , Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.ordersdata = response?.data ?? []
                ShareData.shareInfo.currentOrderData = response?.data ?? []
                self.tblView.reloadData()
            
                self.tblView.isHidden = false
                self.emptyView.isHidden = true
                if self.ordersdata.count == 0 {
                    self.tblView.isHidden = true
                    self.emptyView.isHidden = false 
                }
            
            
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
}
//MARK:- table view delegate
extension CurrentOrderVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ordersdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentOrderCells") as? CurrentOrderCells
        
        cell?.lblcompany.text = self.ordersdata[indexPath.row].supplierCompanyName.putDashes()
        cell?.lblvehicle.text = self.ordersdata[indexPath.row].supplierVehicleBrand.putDashes()
        cell?.lblemployee.text = "\(self.ordersdata[indexPath.row].supplierName ?? "") \(self.ordersdata[indexPath.row].supplierLastName ?? "") \(self.ordersdata[indexPath.row].supplierSecondLastName ?? "")"
        cell?.lbldeliverydate.text = self.getFormattedMilisecondstoDate(seconds: "\(self.ordersdata[indexPath.row].deliveryDate ?? 0)", formatter: "");
        cell?.lbldeliverydetail.text = self.ordersdata[indexPath.row].description ?? ""
        cell?.lbldeliveryproduct.text = self.ordersdata[indexPath.row].item ?? ""
        cell?.lbldeliverycompany.text = self.ordersdata[indexPath.row].supplierCompanyName
        cell?.folioTxt.text = "\("Folio #".localized)\(self.ordersdata[indexPath.row].folio.putDashes() ?? "-")"
        if self.ordersdata[indexPath.row].statusId == 29 {
            cell?.lblstatus.textColor = UIColor(hexString: "006594")
            cell?.statusView.backgroundColor = UIColor(hexString: "006594")
            cell?.lblstatus.text = "ORDER ON COURSE" // self.ordersdata[indexPath.row].status?.name ?? ""
        }else if self.ordersdata[indexPath.row].statusId == 30 {
            cell?.lblstatus.textColor = #colorLiteral(red: 0.9481226802, green: 0.630784452, blue: 0, alpha: 1)
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.9402042627, green: 0.6268541217, blue: 0, alpha: 1)
            cell?.lblstatus.text = "ORDER DELIVERED"
        }else if self.ordersdata[indexPath.row].statusId == 36 {
            cell?.lblstatus.textColor = #colorLiteral(red: 0.7379251719, green: 0.001223876374, blue: 0, alpha: 1)
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.7379251719, green: 0.001223876374, blue: 0, alpha: 1)
            cell?.lblstatus.text = "ORDER CANCELED"
        }
        else if self.ordersdata[indexPath.row].statusId == 28 {
            cell?.lblstatus.textColor = UIColor(hexString: "707070")
            cell?.statusView.backgroundColor = UIColor(hexString: "707070")
            cell?.lblstatus.text = "ORDER INCOMPLETE"
        }
        
        
        cell?.callBack = { Istrue in
            if Istrue {
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
            self.navigationController?.pushViewController(vc!, animated: true)
            }
            
            if !Istrue {
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"GeneralQRCodeVC") as? GeneralQRCodeVC
            self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        
        
        cell?.moreDetailcallBack = { Ismore in
//            let storyBoard = UIStoryboard.init(name: StoryBoards.Contract.rawValue, bundle: nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier:"ContractDetailVC") as? ContractDetailVC
//            self.navigationController?.pushViewController(vc!, animated: true)
            
            
            let storyBoard = UIStoryboard.init(name: StoryBoards.Contract.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ProviderDetailVC") as? ProviderDetailVC
            vc?.isfromcurrentorder = true
            vc?.ordersdata = self.ordersdata[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
        }
        return cell!
    }
    
    
}
