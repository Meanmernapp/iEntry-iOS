//
//  NewInvitationVC.swift
//  iEntry
//
//  Created by ZAFAR on 23/08/2021.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import DZNEmptyDataSet
class NewInvitationVC: BaseController,IndicatorInfoProvider {
    
    //MARK: - here are the IBoutlet
    
    fileprivate func  emptyDataSetUp() {
        self.tblView.emptyDataSetSource = self
        self.tblView.emptyDataSetDelegate = self
        self.tblView.tableFooterView = UIView()
        self.tblView.reloadData()
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "INVITACIONES".localized)
    }
    @IBOutlet weak var tblView: UITableView!
    let refreshControl = UIRefreshControl()
    var invitationdata : [GetallInvitationModelData]? = nil
    
    @IBOutlet weak var descriptionlbl: UILabel!
    @IBOutlet weak var noInvitation: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptionlbl.text = "No hay invitaciones que mostrar".localized
        self.tblView.register(UINib.init(nibName: "NewInvitationCell", bundle: nil), forCellReuseIdentifier: "NewInvitationCell")
        self.navigationBarHidShow(isTrue: true)
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblView.addSubview(refreshControl)
        if Network.isAvailable {
            getInvitationAfterDate()
        }
        else
        {
            self.invitationdata = ShareData.shareInfo.invitationdataOffline
            self.tblView.reloadData()
        }
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        refreshControl.endRefreshing()
        if Network.isAvailable {
            getInvitationAfterDate()
        }
        else
        {
            self.invitationdata = ShareData.shareInfo.invitationdataOffline
            self.tblView.reloadData()
        }
    }
    
    
    func getInvitationAfterDate() {
        
        let timeInMiliSecDate = Date()
        let timeInMiliSec = StartDayMiliSeconds(newdate: timeInMiliSecDate.startOfDay()!) ?? 0//Int (timeInMiliSecDate.timeIntervalSince1970 * 1000)
        let stringurl = Constant.MainUrl + "invitation-service/get-all/by-guest-id/date-after/\(timeInMiliSec)"
        let url = URL(string: stringurl)
        var request = URLRequest(url: url!)
        request.httpMethod = HTTPMethod.get.rawValue
        //request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(ShareData.shareInfo.token ?? "")",forHTTPHeaderField: "Authorization")
        //request.httpBody = "\(timeInMiliSec)".data(using: .utf8)
        self.showLoader()
        AF.request(request).responseJSON { response in
            print("all data ",response)
            self.hidLoader()
            do {
                if response.data == nil {
                    self.tblView.reloadData()
                    return
                }
                
                let responseModel = try JSONDecoder().decode(GetallInvitationModel.self, from: response.data!)
                self.invitationdata = responseModel.data
                ShareData.shareInfo.invitationdataOffline = responseModel.data
                AppUtility.showSuccessMessage(message: "lb_success_get_invitations".localized)
                self.tblView.reloadData()
            }
            catch {
                AppUtility.showSuccessMessage(message: "lb_success_get_invitations".localized)
                print("Response Error")
            }
            
        }
    }
    func hideAndShow() {
        if self.invitationdata?.count == 0 {
            self.noInvitation.isHidden = false
        }
        else {
            self.noInvitation.isHidden = true
        }
    }
    
    
    func updateInvitationApi(_ indx:Int, option:Int){
        showLoader()
        userhandler.updateInvitation(id:self.invitationdata?[indx].id ?? "" , option: option, Success: {response in
            self.hidLoader()
            if response?.success == true {
                if Network.isAvailable {
                    self.getInvitationAfterDate()
                }
                else
                {
                    self.invitationdata = ShareData.shareInfo.invitationdataOffline
                    self.tblView.reloadData()
                }
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
            
        }, Failure: {erorr in
            self.hidLoader()
            AppUtility.showErrorMessage(message: erorr.message)
        })
        
        
    }
    
    
    
    
}
//MARK:-  tableview delegate 
extension NewInvitationVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.hideAndShow()
        return self.invitationdata?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "NewInvitationCell") as? NewInvitationCell
        //cell?.tick.image = UIImage(named:"chevron-right-solid")
        cell?.lblhostName.text =  "\(self.invitationdata?[indexPath.row].guest?.name ?? "") \(self.invitationdata?[indexPath.row].guest?.lastName ?? "")"
        
        
        //cell?.lblhostName.text = self.invitationdata?[indexPath.row].zone?.company?.name
        cell?.lbldate.text = self.getFormattedMilisecondstoDate(seconds: "\(self.invitationdata?[indexPath.row].startDate ?? 0)", formatter: "")
        if self.invitationdata?[indexPath.row].event == nil {
            cell?.eventView.isHidden = true
        }
        else {
            cell?.eventView.isHidden = false
        }
        //        if self.invitationdata?[indexPath.row].event == nil {
        //            cell?.eventView.isHidden = true
        //        } else{
        //            cell?.eventView.isHidden = false
        //        }
        
        if self.invitationdata?[indexPath.row].status?.name ==  "INVITATION_UNATTENDED" {
            cell?.lblstatus.text = "INVITATION UNATTENDED".localized
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.9481226802, green: 0.630784452, blue: 0, alpha: 1)
            cell?.lblstatus.textColor = #colorLiteral(red: 0.9481226802, green: 0.630784452, blue: 0, alpha: 1)
        } else  if self.invitationdata?[indexPath.row].status?.name ==  "INVITATION_ACCEPTED" {
            cell?.lblstatus.text = "INVITATION ACCEPTED".localized
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.04716654867, green: 0.249147892, blue: 0.1248098537, alpha: 1)
            cell?.lblstatus.textColor = #colorLiteral(red: 0.04335165769, green: 0.2412434816, blue: 0.1210812852, alpha: 1)
        } else  if self.invitationdata?[indexPath.row].status?.name ==  "INVITATION_REJECTED" {
            cell?.lblstatus.text = "INVITATION REJECTED".localized
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.618992269, green: 0.005741298664, blue: 0.00775064528, alpha: 1)
            cell?.lblstatus.textColor = #colorLiteral(red: 0.6229569912, green: 0.005496537313, blue: 0.00703322608, alpha: 1)
        }
        
        
        
        cell?.callBack = { istrue in
            if istrue {
                
            }  else {
                
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"GeneralQRCodeVC") as? GeneralQRCodeVC
                vc?.name = self.invitationdata?[indexPath.row].guest?.name ?? ""
                vc?.date = self.getMilisecondstoDate(seconds: "\(self.invitationdata?[indexPath.row].startDate ?? 0)", formatter: "")
                vc?.time = self.getMilisecondstoTime(seconds: "\(self.invitationdata?[indexPath.row].startDate ?? 0)", formatter: "")
                vc?.eventid = self.invitationdata?[indexPath.row].id ?? ""
                //                vc?.eventname = self.invitationdata?[indexPath.row].event?.name ?? ""
                
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.invitationdata?[indexPath.row].status?.name ==  "INVITATION_UNATTENDED" {
            let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"InvitationAcceptAndRejectVC") as? InvitationAcceptAndRejectVC
            vc?.modalPresentationStyle = .overFullScreen
            vc?.acceptInvition = { option in
                
                //vc?.dismiss(animated: true, completion: nil)
                if option == 38 {
                    self.updateInvitationApi(indexPath.row, option: option)
                } else {
                    self.updateInvitationApi(indexPath.row, option: option)
                }
                
            }
            
            self.present(vc!, animated: false, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            userhandler.deleteInvitation2(invitationid: self.invitationdata?[indexPath.row].id ?? "") { model in
                if model?.success ?? false {
                    self.invitationdata?.remove(at: indexPath.row)
                    self.tblView.reloadData()
                    AppUtility.showSuccessMessage(message: "lb_success_deleting_announcement".localized)
                }else {
                    AppUtility.showErrorMessage(message: "Notification delete fail!" )
                }
                
            } Failure: { error in
                AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
            }
            
            
        })
        deleteAction.image = UIImage(named: "ic-trash-outline")
        deleteAction.backgroundColor = UIColor.red
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
extension NewInvitationVC : DZNEmptyDataSetDelegate,DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        let text = "lb_no_data_invitations".localized
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
        
        
        self.getInvitationAfterDate()
        
    }
    
    
    
}
