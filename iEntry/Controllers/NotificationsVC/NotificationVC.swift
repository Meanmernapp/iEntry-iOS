//
//  NotificationVC.swift
//  iEntry
//
//  Created by ZAFAR on 14/08/2021.
//

import UIKit
import DZNEmptyDataSet
import Alamofire
import SideMenu


class NotificationVC: BaseController {
    fileprivate func  emptyDataSetUp() {
        self.tblView.emptyDataSetSource = self
        self.tblView.emptyDataSetDelegate = self
        self.tblView.tableFooterView = UIView()
        self.tblView.reloadData()
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var lblnotificationsTitle: UILabel!
    @IBOutlet weak var inerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var emptyTitle: UILabel!
    @IBOutlet weak var emptyDescription: UILabel!
    
    
    
    
    //MARK: - Variables
    
    
    var notificationdata : [NotificationModelData]? = nil
    var notificationList = [CreatedNotification]()
    var notificationimg = UIImage()
    let refreshControl = UIRefreshControl()
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblView.addSubview(refreshControl)
        self.buttonView.roundViiew()
        self.inerView.roundViiew()
        navigationBarHidShow(isTrue: true)
        tblView.register(UINib.init(nibName: "NotificationsCell", bundle: nil), forCellReuseIdentifier: "NotificationsCell")
        if ShareData.shareInfo.userRole == .contractor ||  ShareData.shareInfo.userRole == .contractoremplyee
        {
            buttonView.isHidden = true
        } else if ShareData.shareInfo.userRole == .provider ||  ShareData.shareInfo.userRole == .provideremployee{
            buttonView.isHidden = true
        } else {
            buttonView.isHidden = false
        }
        self.lblnotificationsTitle.font = UIFont(name: "Montserrat-Bold", size: 20)
        self.lblnotificationsTitle.text = "N O T I F I C A C I O N E S".localized
//        self.emptyTitle.text = "!SIN NOTIFICACION¡".localized
        self.emptyDescription.text = "lb_no_data_announcement".localized
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchData()
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        refreshControl.endRefreshing()
        self.fetchData()
    }
    
    func fetchData() {
        if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 23 })) != nil {
            buttonView.isHidden = false
        } else {
            buttonView.isHidden = true
        }
        
        
        if Network.isAvailable {
            if ShareData.shareInfo.userRole == .employees {
                if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 22 })) != nil {
                    getNotificationApi()
                } else {
                    self.emptyView.isHidden = false
                    self.tblView.isHidden = false
                }
            } else {
                getNotificationApi()
            }
        } else {
            //            for item in ShareData.shareInfo.getBacNotificationsSaved() {
            //                if !self.notificationList.contains(where: { $0.id == item.id }) {
            //                    self.notificationList.append(CreatedNotification(qualification: item.qualification, message: item.message, notificationkind: item.notificationkind, Notificationtime: "\(item.Notificationtime)", Notificationdate: "\(item.Notificationdate)", notificationType: item.notificationType, username: item.username, createdAt: item.createdAt, type: item.type, dateMeeting: item.dateMeeting, path: item.path, driveId: item.driveId, file: item.file, image: item.image, id: item.id, notificationID: item.notificationID, email: item.email))
            //                }
            //            }
            self.notificationList.removeAll()
            self.notificationdata = ShareData.shareInfo.notificationsListOffline
            for item in self.notificationdata ?? []{
                if !self.notificationList.contains(where: { $0.id == item.id }) {
                    self.notificationList.append(CreatedNotification(qualification: item.title ?? "", message: item.message ?? "", notificationkind: item.type ?? "", Notificationtime: "\(item.dateMeeting ?? 0)", Notificationdate: "\(item.dateMeeting ?? 0)", notificationType: item.notificationType?.name ?? "", username: item.user?.name ?? "", createdAt: "\(item.createdAt ?? 0)", type: item.type ?? "", dateMeeting: "\(item.dateMeeting ?? 0)", path: item.path ?? "", driveId: item.driveId ?? "", file: item.file ?? "", image: item.image ?? "", id: item.id ?? "", notificationID: item.notificationType?.id ?? -1, email: item.user?.email ?? ""))
                }
            }
            if self.notificationList.count == 0 {
                //self.emptyDataSetUp()
                self.emptyView.isHidden = false
                self.tblView.isHidden = false
            }
            self.tblView.reloadData()
        }
    }
    
    //MARK: - IBAction
    
    
    @IBAction func menuaction(_ sender: UIButton) {
        
        let manager = ZSideMenuManager(isRTL: false)
        manager.openSideMenu(vc: self)
    }
    
    @IBAction func addnotification(_ sender: UIButton) {
        if Network.isAvailable {
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"NewNotificationVC") as? NewNotificationVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else{
            AppUtility.showErrorMessage(message: "lb_info_can_not_create_announcement".localized)
        }

    }
    func removeNotification(id:String,index:Int) {
        if Network.isAvailable {
            self.showLoader()
            userhandler.deleteNotification(ID: id) { data in
                self.hidLoader()
                if data?.success ?? false {
                    AppUtility.showSuccessMessage(message: "lb_success_deleting_announcement".localized)
                    self.notificationList.remove(at: index)
                    self.tblView.reloadData()
                }
                else {
                    AppUtility.showErrorMessage(message: data?.message ?? "")
                }
            } Failure: { error in
                AppUtility.showErrorMessage(message: "lb_error_deleting_announcement".localized,showTitle: false)
            }
        }
        else {
            AppUtility.showErrorMessage(message: "lb_info_can_not_delete_announcement".localized,showTitle: false)
        }
    }
    
    func getNotificationApi(){
        showLoader()
        let sectimeInMili = startDay()//Int (timeInMiliSec.timeIntervalSince1970 * 1000)
        
        //30 * 24 * 60 * 60 * 1000
        var dic : [String:Any] = [:]
        
        if ShareData.shareInfo.userRole == .provideremployee{
            
            dic = ["userId":ShareData.shareInfo.obj?.id ?? "", "companyId":ShareData.shareInfo.providerEmployeedataValueGetByUserid?.provider?.company?.id ?? "","date":sectimeInMili]
            
        }else
        if ShareData.shareInfo.userRole == .provider{
            
            
            dic = ["userId":ShareData.shareInfo.obj?.id ?? "", "companyId":ShareData.shareInfo.contractorListdataValueGetByUserid?.company?.id ?? "","date":sectimeInMili]
            
        } else if ShareData.shareInfo.userRole == .contractor {
            
            
            dic = ["userId":ShareData.shareInfo.obj?.id ?? "", "companyId":ShareData.shareInfo.contractorListdataValueGetByUserid?.company?.id ?? "","date":sectimeInMili]
            
        }else if ShareData.shareInfo.userRole == .contractoremplyee {
            //contractorEmployeeId
            dic = ["userId":ShareData.shareInfo.contractorEmployeedataValueGetByUserid?.id ?? "", "companyId":ShareData.shareInfo.contractorEmployeedataValueGetByUserid?.contractor?.company?.id ?? "","date":sectimeInMili]
            
        } else if ShareData.shareInfo.userRole == .employees{
            
            dic = ["userId":ShareData.shareInfo.obj?.id ?? "", "companyId":ShareData.shareInfo.conractWithCompany?.company?.id ?? "","date":sectimeInMili]
        }
        
        
        
        userhandler.getNotificationAfterDate(afterdate: sectimeInMili, Success: {response in
            self.hidLoader()
            if response?.success == true {
                ShareData.shareInfo.notificationsListOffline = response?.data
                self.notificationdata = response?.data
                self.notificationList.removeAll()
                
                
                for item in self.notificationdata ?? []{
                    if !self.notificationList.contains(where: { $0.id == item.id }) {
                        self.notificationList.append(CreatedNotification(qualification: item.title ?? "", message: item.message ?? "", notificationkind: item.type ?? "", Notificationtime: "\(item.dateMeeting ?? 0)", Notificationdate: "\(item.dateMeeting ?? 0)", notificationType: item.notificationType?.name ?? "", username: item.user?.name ?? "", createdAt: "\(item.createdAt ?? 0)", type: item.type ?? "", dateMeeting: "\(item.dateMeeting ?? 0)", path: item.path ?? "", driveId: item.driveId ?? "", file: item.file ?? "", image: item.image ?? "", id: item.id ?? "", notificationID: item.notificationType?.id ?? -1, email: item.user?.email ?? ""))
                    }
                }
                self.notificationList.sort(by: {$0.createdAt > $1.createdAt})
                
                self.tblView.isHidden = false
                if self.notificationList.count == 0 {
//                    self.emptyDataSetUp()
                    self.emptyView.isHidden = false
                    self.tblView.isHidden = false
                }
                self.tblView.reloadData()
            } else {
                self.hidLoader()
                AppUtility.showErrorMessage(message: "lb_error_getting_incoming_announcement".localized)
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: "lb_error_getting_incoming_announcement".localized)
        })
    }
    
    
    func downloadFile(fileName:String,extention:String,notificationid:String){
        
        self.showLoader()
        userhandler.downloadNotificationFile(notificationid:notificationid, Success: {response in
            self.hidLoader()
            if response?.success == true  {
                let saved = self.saveBase64StringToPDF(response?.data ?? "", optionName: fileName,extention: extention)
                if saved {
                    AppUtility.showSuccessMessage(message: "Document saved in Local Storage")
                }
                else {
                    AppUtility.showErrorMessage(message: "Saving document failed")
                }
            } else {
                AppUtility.showErrorMessage(message: "Downloading document failed")
                self.hidLoader()
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: "Downloading document failed")
        })
        
        
    }
    
    
    
    
    
    
    
}
//MARK:- tableview delegates
extension NotificationVC :  UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "NotificationsCell") as? NotificationsCell
        let obj = notificationList[indexPath.row]
        cell?.configdate(obj:obj)
        
        
        if obj.path == "notification_image"{
            userhandler.downloadNotificationimage(notificationid: obj.id,option: "notification_image", Success: {response in
                if response?.success == true  {
                    self.notificationimg =  self.convierteImagen(base64String: response?.data ?? "") ?? UIImage()
                    cell?.attachedimg.image = self.notificationimg
                } else {
                    
                }
            }, Failure: {error in
                print("image download error")
            })
            
            
        } else  if obj.path ==  "notification_file"{
            print("File Downloaded")
            
            
            
            
        }
        
        
        cell?.imageshowCallBack = {
            let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"PreViewNotificationImageVC") as? PreViewNotificationImageVC
            vc?.notificationid  = obj.id
            vc?.modalPresentationStyle = .overFullScreen
            
            self.present(vc!, animated: false, completion: nil)
        }
        
        
        cell?.callBack = { extention,name in
            self.alertDownload(indx: indexPath.row, extention: extention, fileName: name)
        }
        return cell!
    }
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationDownloadImageAlertVC") as? NotificationDownloadImageAlertVC
            vc?.titlofDialog = "ELIMINAR NOTIFICACIÓN".localized
            vc?.detailofDialog = "¿Estas seguro de querer eliminar la notificación? Confirma para ejecutar su acción".localized
            vc?.acceptbuttontitle = "ACEPTAR".localized
            vc?.modalPresentationStyle = .overFullScreen
            vc?.callBack = { isok in
                
                if self.notificationList[indexPath.row].email == ShareData.shareInfo.obj?.email {
                    self.removeNotification(id: self.notificationList[indexPath.row].id, index: indexPath.row)
                }
                else {
//                    AppUtility.showErrorMessage(message: "Must be the owner to delete the notification")
                    AppUtility.showErrorMessage(message: "lb_error_deleting_announcement".localized,showTitle: false)
                }
            }
            
            debugPrint("Delete tapped")
            success(true)
            self.present(vc!, animated: false, completion: nil)
            
        })
        deleteAction.image = UIImage(named: "ic-trash-outline")
        deleteAction.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func alertDownload(indx:Int,extention:String,fileName:String){
        let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationDownloadImageAlertVC") as? NotificationDownloadImageAlertVC
        vc?.titlofDialog = "DESCARGAR ARCHIVO".localized
        vc?.detailofDialog = "¿Estas seguro de querer descargar el archivo? Confirma para empezar su descarga.".localized
        vc?.acceptbuttontitle = "CONFIRMAR".localized
        vc?.modalPresentationStyle = .overFullScreen
        vc?.callBack = { isok in
            print("downloading")
            let obj = self.notificationList[indx]
            self.downloadFile(fileName: fileName, extention: extention, notificationid:obj.id)
        }
        self.present(vc!, animated: false, completion: nil)
    }
    
}
extension NotificationVC : DZNEmptyDataSetDelegate,DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        var text = "".localized
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
        
        
        self.getNotificationApi()
        
    }
    
    
    
}
