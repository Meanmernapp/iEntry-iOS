//
//  EventInvitationVC.swift
//  iEntry
//
//  Created by ZAFAR on 04/01/2022.
//

import UIKit
import XLPagerTabStrip
import DZNEmptyDataSet
class EventInvitationVC: BaseController,IndicatorInfoProvider {
    
    @IBOutlet weak var noContract: UILabel!
    @IBOutlet weak var lbladdeventTitle: UILabel!
    @IBOutlet weak var lnlnoeventtitle: UILabel!
    @IBOutlet weak var noEventView: UIView!
    fileprivate func  emptyDataSetUp() {
        self.tblView.emptyDataSetSource = self
        self.tblView.emptyDataSetDelegate = self
        self.tblView.tableFooterView = UIView()
        self.tblView.reloadData()
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "POR VALIDAR".localized)
    }
    //POR VALIDAR
    //INVITACIONES
    //MARK:- here are the iboutlet
    @IBOutlet weak var tblView: UITableView! {
        didSet {
            
            if ShareData.shareInfo.isOnuEvent == true {
                self.tblView.register(UINib.init(nibName: "ONUEventCell", bundle: nil), forCellReuseIdentifier: "ONUEventCell") 
            } else {
                self.tblView.register(UINib.init(nibName: "SchedualCell", bundle: nil), forCellReuseIdentifier: "SchedualCell")
            }
        }
    }
    
    //var invitationdata : [EventInvitationsModelsData]? = nil
    let refreshControl = UIRefreshControl()
    var eventdata : [EventModuleData]? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblView.addSubview(refreshControl)
        fetchData()
        self.navigationBarHidShow(isTrue: true)
        self.lbladdeventTitle.text = "CLICK AQUÍ PARA AGREGAR UNO NUEVO Ó EN EL + BOTÓN".localized
        self.lnlnoeventtitle.text = "!SIN EVENTOS¡".localized
        noContract.text = "lb_no_data_invitations".localized
    }
    @objc func refresh(_ sender: AnyObject) {
        refreshControl.endRefreshing()
        self.fetchData()
    }
    func fetchData() {
        if Network.isAvailable {
            print("Internet connection OK")
            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 32 })) != nil {
                self.getallInviationsAfterDate()
            } else {
                self.noEventView.isHidden = false
//                self.tblView.isHidden = true
            }
        } else {
            self.eventdata = ShareData.shareInfo.inValidationEventData
            if self.eventdata?.count == 0 {
                // self.emptyDataSetUp()
//                self.tblView.isHidden = true
                self.noEventView.isHidden = false
            } else {
                self.tblView.isHidden = false
                self.noEventView.isHidden = true
            }
            self.tblView.reloadData()
        }
    }
    
    func getallInviationsAfterDate() {
        self.showLoader()
        
        userhandler.getEventsinvitatinsAftereDate(miliseconds:startDay(), Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.eventdata = response?.data
                ShareData.shareInfo.inValidationEventData = response?.data
                if self.eventdata?.count == 0 {
                    // self.emptyDataSetUp()
//                    self.tblView.isHidden = true
                    self.noEventView.isHidden = false
                } else {
                    self.tblView.isHidden = false
                    self.noEventView.isHidden = true
                }
                self.tblView.reloadData()
            } else {
                AppUtility.showErrorMessage(message: "lb_error_getting_pending_to_validate".localized)
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    func cancelEventApi(eventid:String){
        userhandler.CancelInvitation(id: eventid, Success: {response in
            if response?.success == true {
                self.getallInviationsAfterDate()
                AppUtility.showSuccessMessage(message: response?.message ?? "")
                // self.navigationController?.popViewController(animated: true)
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    
    
    
    func downloadFile(eventid:String){
        self.showLoader()
        userhandler.downloadEventFile(eventid:eventid, Success: {response in
            self.hidLoader()
            if response?.success == true  {
                
                print("File Data:",response?.data)
                self.saveBase64StringToPDF(response?.data ?? "", optionName: "Event\(randomNumber)", extention: "pdf")
            } else {
                self.hidLoader()
            }
        }, Failure: {error in
            self.hidLoader()
            print("image download error")
        })
    }
    
    
}
//MARK:-  tableview delegate
extension EventInvitationVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventdata?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ShareData.shareInfo.isOnuEvent == true {
            
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ONUEventCell") as? ONUEventCell
            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 35 })) != nil {
                cell?.qrView.isHidden = false
            } else {
                cell?.qrView.isHidden = true
            }
            cell?.lblstatus.text = self.eventdata?[indexPath.row].status?.name
            cell?.lblhostName.text = "\(self.eventdata?[indexPath.row].user?.name ?? "") \(self.eventdata?[indexPath.row].user?.lastName ?? "") \(self.eventdata?[indexPath.row].user?.secondLastName ?? "")"
            
            cell?.lbleventName.text = self.eventdata?[indexPath.row].name
            cell?.lblplace.text = self.eventdata?[indexPath.row].reservation?.zone?.name
            cell?.lblstartDate.text = self.getFormattedMilisecondstoDate(seconds: "\((self.eventdata?[indexPath.row].startDate) ?? 0)", formatter: "")
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
            }
            
            cell?.callBack = { Istrue in
                if Istrue {
                    
                    
                    self.downloadFile(eventid:self.eventdata?[indexPath.row].id ?? "")
                }
                
                if !Istrue {
                    
                    let storyBoard = UIStoryboard.init(name: "ONUEvent", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier:"CancelEventVC") as? CancelEventVC
                    vc?.callBack = {
                        self.cancelEventApi(eventid:self.eventdata?[indexPath.row].id ?? "" )
                    }
                    vc?.modalPresentationStyle = .overFullScreen
                    
                    self.present(vc!, animated: false, completion: nil)
                }
            }
            
            
            return cell!
            
            
            
            
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SchedualCell") as? SchedualCell
            
            
            cell?.qrView.isHidden = true
            cell?.mapView.isHidden = true
            
            cell?.lblstatus.text = self.eventdata?[indexPath.row].status?.name
            cell?.lblhostName.text = "\(self.eventdata?[indexPath.row].user?.name ?? "") \(self.eventdata?[indexPath.row].user?.lastName ?? "") \(self.eventdata?[indexPath.row].user?.secondLastName ?? "")"
            cell?.lbleventName.text = self.eventdata?[indexPath.row].name
            cell?.lblplace.text = self.eventdata?[indexPath.row].reservation?.zone?.name
            cell?.lblinvitations.text = "\(self.eventdata?[indexPath.row].userInvitationNo ?? 0)"
            cell?.lblstartDate.text = self.getFormattedMilisecondstoDate(seconds: "\((self.eventdata?[indexPath.row].startDate) ?? 0)", formatter: "")
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
    
    
    //    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //
    //            let deleteAction = UIContextualAction(style: .normal, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
    //
    //                    debugPrint("Delete tapped")
    //
    //                    success(true)
    //                })
    //
    //            deleteAction.image = UIImage(named: "ic-trash-outline")
    //            deleteAction.backgroundColor = UIColor.red
    //
    //            return UISwipeActionsConfiguration(actions: [deleteAction])
    //        }
    
}
extension EventInvitationVC : DZNEmptyDataSetDelegate,DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        var text = "lb_no_data_invitations".localized
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
        
        
        self.getallInviationsAfterDate()
        
    }
    
    
    
}
