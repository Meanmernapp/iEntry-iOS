//
//  RecordDetailVC.swift
//  iEntry
//
//  Created by ZAFAR on 17/08/2021.
//

import UIKit
import EPContactsPicker

class RecordDetailVC: BaseController,EPPickerDelegate {
    func epContactPicker(_: EPContactsPicker, didSelectMultipleContacts contacts: [EPContact]) {
        
    }
    
    
    //MARK: - IBOutlets

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var noinvitationView: UIView!
    @IBOutlet weak var lblreservationtitle: UILabel!
    @IBOutlet weak var lblatTitle: UILabel!
    @IBOutlet weak var lblthetitle: UILabel!
    @IBOutlet weak var lblstartdatetitle: UILabel!
    @IBOutlet weak var contactBtn: UIButton!
    @IBOutlet weak var lblnametitle: UILabel!
    @IBOutlet weak var lblupdateeventtitle: UILabel!
    @IBOutlet weak var lblcanceleventtitle: UILabel!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lbldurstion: UILabel!
    @IBOutlet weak var lbldurationtitle: UILabel!
    @IBOutlet weak var btnmore: UIButton!
    @IBOutlet weak var lblnumberofInvitations: UILabel!
    @IBOutlet weak var lblreservationDate: UILabel!
    @IBOutlet weak var lblreservation: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lblhostname: UILabel!
    
    
    
    //MARK: - Variables
    
    var eventdata : EventModuleData? = nil
    var invitationsData : [getAllInvitationsAgainstEventModelData]? = nil
    var eventDetaildata : EventDetailModelData? = nil
    var isfromHistory = false
    var usersIDsarr = [String]()
    var passed = false
    @IBOutlet var moreView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactBtn.addTarget(self, action: #selector(openContacts(_:)), for: .touchUpInside)
        self.lblcanceleventtitle.text = "CANCELAR EVENTO".localized
        self.lblupdateeventtitle.text = "ACTUALIZAR EVENTO".localized
        self.lblnametitle.text = "NOMBRE".localized
        self.lblstartdatetitle.text = "FECHA".localized
        self.lblthetitle.text = "EL".localized
        self.lblatTitle.text = "A LAS".localized
        self.lblreservationtitle.text = "RESERVACIONES".localized
        self.lbldurationtitle.text = "DURACIÓN".localized
        if isfromHistory == true {
            btnmore.isHidden = true
        } else {
            if eventdata?.status?.id == 31 || eventdata?.status?.id == 34 {
                self.contactBtn.isHidden = true
                self.btnmore.isHidden = true
            }
            else {
                self.contactBtn.isHidden = false
                self.btnmore.isHidden = false
            }
        }
        moreView.shadowAndRoundcorner(cornerRadius: 8, shadowColor: #colorLiteral(red: 0.7293313146, green: 0.7294581532, blue: 0.7293233275, alpha: 1), shadowRadius: 5, shadowOpacity: 1)
        self.navigationBarHidShow(isTrue: true)
        self.tblView.register(UINib.init(nibName: "RecordDetailCell", bundle: nil), forCellReuseIdentifier: "RecordDetailCell")
        //getEventDetailApi()
        //getAllinvitationsAgainstEventApi()
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.lbldurstion.text = "\(self.eventdata?.duration ?? 0) MIN"
        self.lblhostname.text =  self.eventdata?.name
        self.lblreservation.text =  self.eventdata?.reservation?.zone?.name
        
        self.lbltime.text = self.getMilisecondstoTime(seconds: "\(self.eventdata?.endDate ?? 0)", formatter: "")
        
        self.lbldate.text = self.getMilisecondstoDate(seconds: "\(self.eventdata?.startDate ?? 0)", formatter: "")
        self.lblreservationDate.text = "Fecha: ".localized + self.getFormattedMilisecondstoDate(seconds: "\(self.eventdata?.reservation?.toDate ?? 0)", formatter: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getEventDetailApi()
        getAllinvitationsAgainstEventApi()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                DispatchQueue.main.async {
                    let newsize  = newvalue as! CGSize
                    if self.invitationsData?.count == 0 {
                        self.tblHeight.constant = 200
                    }
                    else {
                        self.tblHeight.constant = newsize.height
                    }
                    
                }
                
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.invitationsData?.count == 0 {
            self.tblHeight.constant = 200
        }
        else {
            self.tblHeight.constant = self.tblView.contentSize.height
        }
        
    }
    
    @IBAction func moreAction(_ sender: UIButton) {
        self.moreView.isHidden = !self.moreView.isHidden
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func openContacts(_ sender:UIButton) {
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"InvitarVC") as? InvitarVC
        vc?.isFromEvent = true
        vc?.eventid = self.eventDetaildata?.id ?? ""
        if let data = invitationsData {
            for i in data {
                self.usersIDsarr.append(i.guest?.id ?? "")
            }
        }
        
        vc?.usersIDsarr = self.usersIDsarr
        vc?.colesure = { users in
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func updateEventAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"UpdateEventVC") as? UpdateEventVC
        vc?.invitationsData = self.invitationsData
        vc?.eventDetaildata = self.eventDetaildata
        vc?.eventdata = self.eventdata
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func DeleteAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"AcceptORRejectionPopUpVC") as? AcceptORRejectionPopUpVC
        vc?.modalPresentationStyle = .overFullScreen
        
        vc?.callBack = {
            print("iam")
            self.dismiss(animated: true, completion: nil)
            self.cancelEventApi()
        }
        self.present(vc!, animated: false, completion: nil)
    }
    
    func cancelEventApi(){
        userhandler.CancelInvitation(id: self.eventdata?.id ?? "", Success: {response in
            if response?.success == true {
                AppUtility.showSuccessMessage(message: response?.message ?? "")
                self.navigationController?.popViewController(animated: true)
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    
    
    
    func getEventDetailApi(){
        self.showLoader()
        userhandler.getEventDetail(id: eventdata?.id ?? "", Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.eventDetaildata =  response?.data
                
                self.lblreservation.text =  self.eventDetaildata?.reservation?.zone?.name
                
                self.lbltime.text = self.getMilisecondstoTime(seconds: "\(self.eventDetaildata?.reservation?.toDate ?? 0)", formatter: "")
                
                self.lbldate.text = self.getMilisecondstoDate(seconds: "\(self.eventDetaildata?.reservation?.toDate ?? 0)", formatter: "")
                self.lblreservationDate.text = "Fecha: " + self.getFormattedMilisecondstoDate(seconds: "\(self.eventDetaildata?.reservation?.toDate ?? 0)", formatter: "")
                if self.getMilisecondstoDate(seconds: "\(self.eventDetaildata?.reservation?.toDate ?? 0)") {
                    if self.eventdata?.status?.id == 31 || self.eventdata?.status?.id == 34 {
                        
                        self.contactBtn.isHidden = true
                        self.btnmore.isHidden = true
                        self.passed = true
                    }
                    else {
                        
                        self.contactBtn.isHidden = false
                        self.btnmore.isHidden = false
                        self.passed = false
                    }
                    
                }
                else {
                    self.passed = false
                    self.contactBtn.isHidden = false
                    self.btnmore.isHidden = false
                }
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    func getAllinvitationsAgainstEventApi(){
        self.showLoader()
        userhandler.getInvitationsAgainstEvent(id: eventdata?.id ?? "", Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.invitationsData = response?.data ?? []
                self.lblnumberofInvitations.text = "\(self.invitationsData?.count ?? 0)" + " " + "Invitations".localized
                self.tblView.reloadData()
                
                if self.invitationsData?.count == 0 {
                    self.tblHeight.constant = 200
                    self.noinvitationView.isHidden = false
                    //                    self.tblView.isHidden = true
                } else {
                    self.tblHeight.constant = self.tblView.contentSize.height
                    self.noinvitationView.isHidden = true
                    //                    self.tblView.isHidden = false
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
//MARK:- here are the tableview delegate and datasource
extension RecordDetailVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.invitationsData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "RecordDetailCell") as? RecordDetailCell
        cell?.lblname.text = self.invitationsData?[indexPath.row].guest?.name
        cell?.lblphone.text = self.invitationsData?[indexPath.row].guest?.phoneNumber
        if self.invitationsData?[indexPath.row].status?.id == 37 {
            cell?.tick.image = UIImage(named:"ic-dash")
        }
        else if self.invitationsData?[indexPath.row].status?.id == 39 {
            cell?.tick.image = UIImage(named:"ic-cancel")
        }
        else {
            cell?.tick.image = UIImage(named:"Path 213")
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if eventdata?.status?.id != 31 || eventdata?.status?.id != 34 || passed {
            let deleteAction = UIContextualAction(style: .normal, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                
                let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"AcceptORRejectionPopUpVC") as? AcceptORRejectionPopUpVC
                vc?.modalPresentationStyle = .overFullScreen
                vc?.name = self.invitationsData?[indexPath.row].guest?.name ?? ""
                vc?.isFromUpdateEvennt = true
                vc?.callBack = {
                    print("iam")
                    self.dismiss(animated: true, completion: nil)
                    self.deleteInvitation(id: self.invitationsData?[indexPath.row].id ?? "", index: indexPath.row)
                }
                self.present(vc!, animated: false, completion: nil)
                debugPrint("Delete tapped")
                success(true)
            })
            
            deleteAction.image = UIImage(named: "ic-trash-outline")
            deleteAction.backgroundColor = UIColor.red
            
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
        else {
            return nil
        }
        
    }
    
    func deleteInvitation(id:String,index:Int) {
        userhandler.deleteInvitation2(invitationid: id) { result in
            if result?.success ?? false {
                AppUtility.showSuccessMessage(message: result?.message ?? "Invitation Deleted")
                self.invitationsData?.remove(at: index)
                self.tblView.reloadData()
                self.lblnumberofInvitations.text = "\(self.invitationsData?.count ?? 0)" + " " + "Invitations".localized
                if self.invitationsData?.count == 0 {
                    self.tblHeight.constant = 200
                    self.noinvitationView.isHidden = false
                } else {
                    self.tblHeight.constant = self.tblView.contentSize.height
                    self.noinvitationView.isHidden = true
                }
            }
            else {
                AppUtility.showErrorMessage(message:"lb_error_removing_invitation".localized)
            }
        } Failure: { error in
            AppUtility.showErrorMessage(message:"lb_error_removing_invitation".localized)
        }
    }
    
    
}
