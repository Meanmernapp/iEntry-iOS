//
//  InvitationRecordVC.swift
//  iEntry
//
//  Created by ZAFAR on 23/08/2021.
//

import UIKit
import DZNEmptyDataSet
class InvitationRecordVC: UIViewController {
    //MARK:- here are the iboutlet
    
    fileprivate func  emptyDataSetUp() {
        self.tblView.emptyDataSetSource = self
        self.tblView.emptyDataSetDelegate = self
        self.tblView.tableFooterView = UIView()
        self.tblView.reloadData()
    }
    
    @IBOutlet weak var noInvitation: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.register(UINib.init(nibName: "InvitationRecordCell", bundle: nil), forCellReuseIdentifier: "InvitationRecordCell")
        self.navigationBarHidShow(isTrue: true)
        self.titleLbl.text = "No hay invitaciones que mostrar".localized
        if ShareData.shareInfo.getBackinvitatiosdataSaved().count == 0 {
            self.noInvitation.isHidden = false
        }
        else {
            self.noInvitation.isHidden = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        if ShareData.shareInfo.getBackinvitatiosdataSaved().count == 0 {
        //            //        if ShareData.shareInfo.invitationlist.count == 0 {
        //            self.emptyDataSetUp()
        //        }
        if ShareData.shareInfo.getBackinvitatiosdataSaved().count == 0 {
            self.noInvitation.isHidden = false
        }
        else {
            self.noInvitation.isHidden = true
        }
        
        self.tblView.reloadData()
    }
    
    
    
}

//MARK:- tableview delegate
extension InvitationRecordVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return ShareData.shareInfo.invitationlist.count
        return ShareData.shareInfo.getBackinvitatiosdataSaved().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "InvitationRecordCell") as? InvitationRecordCell
        cell?.lbldate.text = ShareData.shareInfo.getBackinvitatiosdataSaved()[indexPath.row].date
        cell?.lblname.text = ShareData.shareInfo.getBackinvitatiosdataSaved()[indexPath.row].name
        cell?.lblphone.text = ShareData.shareInfo.getBackinvitatiosdataSaved()[indexPath.row].phone
        
        return cell!
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.deleteInvitationApi(invid: ShareData.shareInfo.invitationlist[indexPath.row].id, index: indexPath.row, name: ShareData.shareInfo.invitationlist[indexPath.row].name)
            debugPrint("Delete tapped")
            
            success(true)
        })
        
        deleteAction.image = UIImage(named: "ic-trash-outline")
        deleteAction.backgroundColor = UIColor.red
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Network.isAvailable {
            let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"InvitationPOPUpVC") as? InvitationPOPUpVC
            vc?.isfromHistory = true
            vc?.name = ShareData.shareInfo.getBackinvitatiosdataSaved()[indexPath.row].name
            vc?.phone =  ShareData.shareInfo.getBackinvitatiosdataSaved()[indexPath.row].phone
            vc?.guestid = ShareData.shareInfo.getBackinvitatiosdataSaved()[indexPath.row].guestid
            vc?.modalPresentationStyle = .overFullScreen
            
            self.present(vc!, animated: false, completion: nil)
            
        }
        else
        {
            AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
        }
    }
    
}
extension InvitationRecordVC : DZNEmptyDataSetDelegate,DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "lb_no_data_invitations".localized
        let attribs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]
        
        return NSAttributedString(string: text.localized, attributes: attribs)
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        var text = ""
        text = "Try Again!".localized
        let attribs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4712097049, green: 0.7777811885, blue: 0.758687973, alpha: 1)
        ] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
        
        return NSAttributedString(string: text.localized, attributes: attribs)
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!){
        
        
        self.tblView.reloadData()
        
    }
    
    func deleteInvitationApi(invid:String,index:Int,name:String){
        let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"CancelEventInvitationVC") as? CancelEventInvitationVC
        vc?.name = name
        vc?.modalPresentationStyle = .overFullScreen
        vc?.callBack = { isok in
            userhandler.deleteInvitation2(invitationid: invid) { model in
                if model?.success ?? false {
                    _ = ShareData.shareInfo.removeinvitatiosdataSaved(index: index)
                    if ShareData.shareInfo.getBackinvitatiosdataSaved().count == 0 {
                        self.noInvitation.isHidden = false
                    }
                    else {
                        self.noInvitation.isHidden = true
                    }
                    self.tblView.reloadData()
                    AppUtility.showSuccessMessage(message: "lb_message_invitation_removed".localized)
                }else {
                    AppUtility.showErrorMessage(message: "Notification delete fail!" )
                }
                
            } Failure: { error in
                AppUtility.showErrorMessage(message: "Please check your network" )
            }
        }
        self.present(vc!, animated: false, completion: nil)
    }
}
