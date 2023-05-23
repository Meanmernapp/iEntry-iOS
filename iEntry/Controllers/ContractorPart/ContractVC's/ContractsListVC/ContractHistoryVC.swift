//
//  ContractHistoryVC.swift
//  iEntry
//
//  Created by ZAFAR on 11/11/2021.
//

import UIKit
import XLPagerTabStrip
import DZNEmptyDataSet
class ContractHistoryVC: BaseController,IndicatorInfoProvider {
    
    
    
    //MARK: - IBOutlets

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var tblView: UITableView!
    
    //MARK: - Variables
    
    var contractListdata = [IncomingContractListModelData]()
    let refreshControl = UIRefreshControl()
    
    
    //MARK: - Private Functions
    
    fileprivate func  emptyDataSetUp() {
        self.tblView.emptyDataSetSource = self
        self.tblView.emptyDataSetDelegate = self
        self.tblView.tableFooterView = UIView()
        self.tblView.reloadData()
    }
    //MARK:- tab delegate
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "HISTORIAL CONTRATOS".localized)
    }
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblView.register(UINib.init(nibName: "ContractsListCell", bundle: nil), forCellReuseIdentifier: "ContractsListCell")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblView.addSubview(refreshControl)
        fetchData()
    }

    
    //MARK: - Functions
     
    func fetchData() {
        if Network.isAvailable {
            self.getContractList()
        } else{
            AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
            self.contractListdata =  ShareData.shareInfo.contractHistoryDataVC ?? []
            self.tblView.isHidden = false
            self.emptyView.isHidden = true
            if self.contractListdata.count == 0 {
                self.emptyView.isHidden = false
                self.tblView.isHidden = true
            }
            self.tblView.reloadData()
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        refreshControl.endRefreshing()
        self.fetchData()
    }
    
    @IBAction func mapAction(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard.init(name:StoryBoards.Home.rawValue, bundle: nil)
             let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
             self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    //Int (Date().timeIntervalSince1970 * 1000)
    func getContractList(){
        var dic : [String:Any] = [:]
        self.showLoader()
        
        var url = ""
       if ShareData.shareInfo.userRole == .contractor {
        dic  = ["userId":ShareData.shareInfo.obj?.id ?? "","date":StartDayMiliSeconds(newdate: Date().startOfDay()!) ?? 0]
               url = Constant.MainUrl + Constant.URLs.contractHirotyList
          
            
       } else if ShareData.shareInfo.userRole == .contractoremplyee{
        //contractorEmployeeId
        //ShareData.shareInfo.contractorEmployeedataValueGetByUserid?.id ?? ""
        dic  = ["userId":ShareData.shareInfo.obj?.id ?? "","date":StartDayMiliSeconds(newdate: Date().startOfDay()!) ?? 0]
           url = Constant.MainUrl + Constant.URLs.getallRecordContractorEmployee
       }
        
        userhandler.getAllIncomingContractList(milisecond:StartDayMiliSeconds(newdate: Date().startOfDay()!) ?? 0, newurl: url, Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.contractListdata = response?.data ?? []
                ShareData.shareInfo.saveContractList(contract:response?.data ?? [])
                ShareData.shareInfo.contractHistoryDataVC = response?.data ?? []
                self.tblView.isHidden = false
                self.emptyView.isHidden = true
                if self.contractListdata.count == 0 {
//                    self.emptyDataSetUp()
                    self.emptyView.isHidden = false
                    self.tblView.isHidden = true
                }
                self.tblView.reloadData()
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
}
//MARK:- tableview delegate
extension ContractHistoryVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contractListdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContractsListCell") as? ContractsListCell
        
        
        let name:String?  = "\(self.contractListdata[indexPath.row].contractorName ?? "") \(self.contractListdata[indexPath.row].contractorLastName ?? "") \(self.contractListdata[indexPath.row].contractorSecondLastName ?? "")"
        
        cell?.lblusername.text = name.putDashes()
        cell?.lblstartDate.text = getMilisecondstoDate(seconds: "\(self.contractListdata[indexPath.row].starDate ?? 0)", formatter: "")
        cell?.lblendDate.text = getMilisecondstoDate(seconds: "\(self.contractListdata[indexPath.row].endDate ?? 0)", formatter: "")
        cell?.lblcompanyName.text = self.contractListdata[indexPath.row].contractorCompanyName
        cell?.lblcontractNumber.text = "Contrato".localized + "#\(indexPath.row)"
        cell?.folioTxt.text = "\("Folio #".localized)\(self.contractListdata[indexPath.row].folio.putDashes() ?? "-")"
        
        
        if self.contractListdata[indexPath.row].statusId == 22 {
        cell?.statusView.backgroundColor = UIColor(hexString: "0C4523")
            
        cell?.lblstatsu.textColor = UIColor(hexString: "0C4523")
            if myDefaultLanguage == .en {
                cell?.lblstatsu.text = "CONTRACT ACTIVE" //self.contractListdata[indexPath.row].status?.name
            } else {
                
                cell?.lblstatsu.text = "CONTRATO ACTIVO"
                
            }
                
            
        
        } else if self.contractListdata[indexPath.row].statusId == 21 {
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            cell?.lblstatsu.textColor = #colorLiteral(red: 0.9481226802, green: 0.630784452, blue: 0, alpha: 1)
            if myDefaultLanguage == .en {
                cell?.lblstatsu.text = "CONTRACT FINISH" //self.contractListdata[indexPath.row].status?.name
            } else {
                cell?.lblstatsu.text =  "CONTRATO FINALIZADO"
            }
            
            
            } else if self.contractListdata[indexPath.row].statusId == 23 {
                cell?.statusView.backgroundColor = #colorLiteral(red: 0.9991626143, green: 0.1742511094, blue: 0.3347000182, alpha: 1)
                cell?.lblstatsu.textColor = #colorLiteral(red: 0.9991626143, green: 0.1742511094, blue: 0.3347000182, alpha: 1)
                if myDefaultLanguage == .en {
                cell?.lblstatsu.text = "CONTRACT CANCEL" //self.contractListdata[indexPath.row].status?.name
                } else {
                    cell?.lblstatsu.text = "CONTRATO CANCELADO"
                }
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
        let vc = storyBoard.instantiateViewController(withIdentifier:"ContractInformationVC") as? ContractInformationVC
            vc?.contractListdata = self.contractListdata[indexPath.row]
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        return cell!
    }
    
    
}

extension ContractHistoryVC : DZNEmptyDataSetDelegate,DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "lb_no_data_contacts".localized
        let attribs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]
        
        return NSAttributedString(string: text, attributes: attribs)
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        var text = ""
        if myDefaultLanguage == .en {
         text = "Try Again!".localized
        } else {
            text = "¡Intentar otra vez!".localized
        }
        let attribs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4712097049, green: 0.7777811885, blue: 0.758687973, alpha: 1)
            ] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
        
        return NSAttributedString(string: text, attributes: attribs)
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!){
        
       
        self.getContractList()
        
    }
    
    
    
}
