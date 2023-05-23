//
//  RecordVC.swift
//  iEntry
//
//  Created by ZAFAR on 11/08/2021.
//

import UIKit
import XLPagerTabStrip
import DZNEmptyDataSet
class RecordVC: BaseController,IndicatorInfoProvider {
    //MARK:- this delegate of tab
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "HISTORIAL".localized)
    }
    
    @IBOutlet weak var emptyView: UIView!
    fileprivate func  emptyDataSetUp() {
        self.tblView.emptyDataSetSource = self
        self.tblView.emptyDataSetDelegate = self
        self.tblView.tableFooterView = UIView()
        self.tblView.reloadData()
    }
    
    @IBOutlet weak var noContract: UILabel!
    //MARK:- here are iboutlete
    @IBOutlet weak var tblView: UITableView!{
        didSet {
            if ShareData.shareInfo.isOnuEvent == true {
                self.tblView.register(UINib.init(nibName: "ONUEventCell", bundle: nil), forCellReuseIdentifier: "ONUEventCell")
                
            } else {
                self.tblView.register(UINib.init(nibName: "SchedualCell", bundle: nil), forCellReuseIdentifier: "SchedualCell")
            }
        }
    }
    
    var eventdata : [EventModuleData]? = nil
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblView.addSubview(refreshControl)
        fetchData()
        noContract.text = "lb_no_data_record_contracts".localized
        //        AppUtility.showSuccessMessage(message: "lb_success_get_record_purchases".localized)
        
    }
    @objc func refresh(_ sender: AnyObject) {
        refreshControl.endRefreshing()
        self.fetchData()
    }
    
    func fetchData() {
        if Network.isAvailable {
            print("Internet connection OK")
            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 32 })) != nil {
                self.getEventsAfterDate()
            } else {
                self.emptyView.isHidden = false
//                self.tblView.isHidden = true
            }
        } else {
            
            self.tblView.isHidden = false
//            self.emptyView.isHidden = true
            self.eventdata = ShareData.shareInfo.recordsEventData
            if self.eventdata?.count == 0 {
                self.emptyView.isHidden = false
//                self.tblView.isHidden = true
            }
            self.tblView.reloadData()
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tblView.frame = tblView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0))
    }
    
    func getEventsAfterDate(){
        self.showLoader()
        let _ = Date()
        let timeInMiliSec =  StartDayMiliSeconds(newdate: Date().startOfDay()!) ?? 0//Int (timeInMiliSecDate.timeIntervalSince1970 * 1000)
        //userId
        //* 1 * 24 * 60 * 60 * 1000
        //let dic : [String:Any] = ["date":timeInMiliSec, "hostId":ShareData.shareInfo.obj?.id ?? ""]
        userhandler.getEventsBeforeDate(beforedate:timeInMiliSec, Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.eventdata = response?.data ?? []
                ShareData.shareInfo.recordsEventData = response?.data ?? []
                self.tblView.isHidden = false
                self.emptyView.isHidden = true
                if self.eventdata?.count == 0 {
                    self.emptyView.isHidden = false
//                    self.tblView.isHidden = true
                    
                    //self.emptyDataSetUp()
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
//MARK:- here are Table  delegates
extension RecordVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventdata?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ShareData.shareInfo.isOnuEvent == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ONUEventCell") as? ONUEventCell
            cell?.qrView.isHidden = true
            cell?.mapView.isHidden = true
            cell?.lblstatus.text = self.eventdata?[indexPath.row].status?.name
            cell?.lblhostName.text =  "\(self.eventdata?[indexPath.row].user?.name ?? "") \(self.eventdata?[indexPath.row].user?.lastName ?? "") \(self.eventdata?[indexPath.row].user?.secondLastName ?? "")"
            cell?.lbleventName.text = self.eventdata?[indexPath.row].name
            cell?.lblplace.text = self.eventdata?[indexPath.row].reservation?.zone?.name
            //cell?.lblinvitations.text = "\(self.eventdata?[indexPath.row].userInvitationNo ?? 0)"
            cell?.lblstartDate.text = self.getFormattedMilisecondstoDate(seconds: "\((self.eventdata?[indexPath.row].startDate) ?? 0)", formatter: "")
            //cell?.lblendDate.text = self.getFormattedMilisecondstoDate(seconds: "\((self.eventdata?[indexPath.row].endDate) ?? 0)", formatter: "")
            //cell?.lblendDate.isHidden = true
            //cell?.lbltitleEnddate.isHidden = true
            cell?.lblreservation.text = self.eventdata?[indexPath.row].reservation?.zone?.name
            cell?.lbldurationmin.text = "\(self.eventdata?[indexPath.row].duration ?? 0) MIN"
            
            if self.eventdata?[indexPath.row].status?.name ==  "EVENT_IN_VALIDATION" {
                cell?.lblstatus.text = "EVENT IN VALIDATION"
                cell?.statusView.backgroundColor = #colorLiteral(red: 0.9481226802, green: 0.630784452, blue: 0, alpha: 1)
                cell?.lblstatus.textColor = #colorLiteral(red: 0.9481226802, green: 0.630784452, blue: 0, alpha: 1)
            } else  if self.eventdata?[indexPath.row].status?.name ==  "EVENT_APPROVED" {
                cell?.lblstatus.text = "EVENT APPROVED"
                cell?.statusView.backgroundColor = #colorLiteral(red: 0.04716654867, green: 0.249147892, blue: 0.1248098537, alpha: 1)
                cell?.lblstatus.textColor = #colorLiteral(red: 0.04335165769, green: 0.2412434816, blue: 0.1210812852, alpha: 1)
            } else  if self.eventdata?[indexPath.row].status?.name ==  "EVENT_CANCEL" {
                cell?.lblstatus.text = "EVENT CANCEL"
                cell?.statusView.backgroundColor = #colorLiteral(red: 0.618992269, green: 0.005741298664, blue: 0.00775064528, alpha: 1)
                cell?.lblstatus.textColor = #colorLiteral(red: 0.6229569912, green: 0.005496537313, blue: 0.00703322608, alpha: 1)
                cell?.qrView.isHidden = true
            } else if self.eventdata?[indexPath.row].status?.name == "EVENT_DECLINED" {
                cell?.lblstatus.text = "EVENT DECLINED"
                cell?.statusView.backgroundColor = #colorLiteral(red: 0.001493786694, green: 0.3966483176, blue: 0.579593122, alpha: 1)
                cell?.lblstatus.textColor = #colorLiteral(red: 0.001493786694, green: 0.3966483176, blue: 0.579593122, alpha: 1)
            }
            
            
            
            
            return cell!
            
            
            
            
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SchedualCell") as? SchedualCell
            
            
            cell?.qrView.isHidden = true
            cell?.mapView.isHidden = true
            
            cell?.lblstatus.text = self.eventdata?[indexPath.row].status?.name
            cell?.lblhostName.text = "\(self.eventdata?[indexPath.row].user?.name ?? "") \(self.eventdata?[indexPath.row].user?.lastName ?? "") \(self.eventdata?[indexPath.row].user?.secondLastName ?? "")"
            //            self.eventdata?[indexPath.row].user?.name
            cell?.lbleventName.text = self.eventdata?[indexPath.row].name
            cell?.lblplace.text = self.eventdata?[indexPath.row].reservation?.zone?.name
            cell?.lblinvitations.text = "\(self.eventdata?[indexPath.row].userInvitationNo ?? 0)"
            cell?.lblstartDate.text = self.getFormattedMilisecondstoDate(seconds: "\((self.eventdata?[indexPath.row].startDate) ?? 0)", formatter: "")
            //cell?.lblendDate.text = self.getFormattedMilisecondstoDate(seconds: "\((self.eventdata?[indexPath.row].endDate) ?? 0)", formatter: "")
            cell?.lblendDate.isHidden = true
            cell?.lbltitleEnddate.isHidden = true
            cell?.lblreservation.text = self.eventdata?[indexPath.row].reservation?.zone?.name
            cell?.lbldurationmin.text = "\(self.eventdata?[indexPath.row].duration ?? 0) MIN"
            
            if self.eventdata?[indexPath.row].status?.name ==  "EVENT_IN_VALIDATION" {
                cell?.lblstatus.text = "EVENT IN VALIDATION"
                cell?.statusView.backgroundColor = #colorLiteral(red: 0.9481226802, green: 0.630784452, blue: 0, alpha: 1)
                cell?.lblstatus.textColor = #colorLiteral(red: 0.9481226802, green: 0.630784452, blue: 0, alpha: 1)
            } else  if self.eventdata?[indexPath.row].status?.name ==  "EVENT_APPROVED" {
                cell?.lblstatus.text = "EVENT APPROVED"
                cell?.statusView.backgroundColor = #colorLiteral(red: 0.04716654867, green: 0.249147892, blue: 0.1248098537, alpha: 1)
                cell?.lblstatus.textColor = #colorLiteral(red: 0.04335165769, green: 0.2412434816, blue: 0.1210812852, alpha: 1)
            } else  if self.eventdata?[indexPath.row].status?.name ==  "EVENT_CANCEL" {
                cell?.lblstatus.text = "EVENT CANCEL"
                cell?.statusView.backgroundColor = #colorLiteral(red: 0.618992269, green: 0.005741298664, blue: 0.00775064528, alpha: 1)
                cell?.lblstatus.textColor = #colorLiteral(red: 0.6229569912, green: 0.005496537313, blue: 0.00703322608, alpha: 1)
            }
            
            //        cell?.callBack = { Istrue in
            //            if Istrue {
            ////                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            ////                let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
            ////                self.navigationController?.pushViewController(vc!, animated: true)
            //            }
            //
            //            if !Istrue {
            //
            //                    let storyBoard = UIStoryboard.init(name: "ONUEvent", bundle: nil)
            //                    let vc = storyBoard.instantiateViewController(withIdentifier:"CancelEventVC") as? CancelEventVC
            //                vc?.callBack = {
            //                    self.cancelEventApi(eventid:self.eventdata?[indexPath.row].id ?? "" )
            //                }
            //                vc?.modalPresentationStyle = .overFullScreen
            //
            //                self.present(vc!, animated: false, completion: nil)
            //            }
            //        }
            
            cell?.moreDetailcallBack = { Istrue in
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"RecordDetailVC") as? RecordDetailVC
                vc?.isfromHistory = false
                vc?.eventdata = self.eventdata?[indexPath.row]
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            return cell!
        }
    }
    
    
}

extension RecordVC : DZNEmptyDataSetDelegate,DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "lb_no_data_record_contracts".localized
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
        
        
        self.getEventsAfterDate()
        
    }
    
    
    
}
extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
