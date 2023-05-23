//
//  AddNotificationVC.swift
//  iEntry
//
//  Created by ZAFAR on 27/08/2021.
//

import UIKit
import Photos
import MaterialComponents.MaterialTextControls_FilledTextFields
import SMDatePicker
import DropDown
import IQKeyboardManagerSwift
import CoreServices

class NewNotificationVC: BaseController, UITextViewDelegate,SMDatePickerDelegate, UITextFieldDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var multimediaTitle: UILabel!
    @IBOutlet weak var fileType: UIImageView!
    @IBOutlet weak var fileView: UIView!
    @IBOutlet weak var lblfilename: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblaceptitle: UILabel!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var lblnewinvitationtitle: UILabel!
    @IBOutlet weak var txtscop: MDCOutlinedTextField!
    @IBOutlet weak var txtdate: MDCOutlinedTextField!
    @IBOutlet weak var txttime: MDCOutlinedTextField!
    @IBOutlet weak var txtsearch: UITextField!
    @IBOutlet weak var searchButtonView: UIView!
    @IBOutlet weak var searchView: UIView!
    //    @IBOutlet weak var viewheight: NSLayoutConstraint!
    //    @IBOutlet weak var msgView: UIView!
    @IBOutlet weak var txtkind: MDCOutlinedTextField!
    @IBOutlet weak var txttypeNotification: MDCOutlinedTextField!
    @IBOutlet weak var txtqualificatioon: MDCOutlinedTextField!
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var tblView: UITableView! {
        didSet{
            
            tblView.dataSource = self
            tblView.delegate = self
            //tblView.isScrollEnabled = false
            tblView.register(UINib.init(nibName: "NewNotificationCell", bundle: nil), forCellReuseIdentifier: "NewNotificationCell")
        }
    }
    
    //MARK: - Latest
    @IBOutlet weak var gallerybtn: UIButton!
    @IBOutlet weak var fileBtn: UIButton!
    @IBOutlet weak var galleryLbl: UILabel!
    @IBOutlet weak var fileLbl: UILabel!
    @IBOutlet weak var warningTitleLbl: UILabel!
    @IBOutlet weak var warningDescription: UILabel!
    
    
    
    //MARK: - Variables
    
    var typenotiId = 0
    var notititle = ""
    var msg = ""
    var myDatePicker: SMDatePicker = SMDatePicker()
    var MainDrowpDown = DropDown()
    let timeInMiliSec = Date()
    var sectimeInMili = 0
    var  userListdata = [GetAllUsersListModelData]()
    var  userSearchListData = [GetAllUsersListModelData]()
    var selectedUsersList = [String]()
    var isEmployee =  false
    var fileName = ""
    var txtType = ""
    var imageName = ""
    var imageUrl : URL?
    var fileUrl : URL?
    var notificationsdata : [GetAllNotificationTypesModelData]? = nil
    var search = false
    var createNotifidata : CreateNotificationModelData?
    var scopeSelected = false
    @IBOutlet weak var msgViewArea: MDCOutlinedTextArea!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(imageLongPressed))
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(longPressGesture)
        let fileViewGesture = UILongPressGestureRecognizer(target: self, action: #selector(viewLongPressed))
        fileView.isUserInteractionEnabled = true
        fileView.addGestureRecognizer(fileViewGesture)
        msgViewArea.minimumNumberOfVisibleRows = 3
        txtsearch.delegate  = self
        self.multimediaTitle.font = UIFont(name: "Montserrat-Bold", size: 16)
        self.multimediaTitle.text = "M U L T I M E D I A"
        self.fileView.isHidden = true
        self.img.image = nil
        self.warningTitleLbl.text = "!SIN ARCHIVO¡".localized
        self.warningDescription.text = "PARA AGREGAR UNO NUEVO EN LA CAMARA O ARCHIVO".localized
        IQKeyboardManager.shared.enable = false
        self.lblnewinvitationtitle.text = "N U E V A  N O T I F I C A CI O N".localized
        self.lblaceptitle.text = "ENVIAR".localized
        self.getallUsersListApi()
        searchView.shadowAndRoundcorner(cornerRadius: Float(searchView.layer.frame.height) / 2, shadowColor: #colorLiteral(red: 0.8430451751, green: 0.843190372, blue: 0.843035996, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1)
        searchButtonView.roundCorners([.topRight,.bottomRight], radius: 25)
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        sectimeInMili = StartDayMiliSeconds(newdate: Date().startOfDay()!) ?? 0
        self.navigationBarHidShow(isTrue: true)
        self.galleryLbl.text = "lb_title_add_image".localized.uppercased()
        self.fileLbl.text = "lb_title_add_file".localized.uppercased()
        setMDCTxtFieldDesign(txtfiled: txtqualificatioon, Placeholder: "TÍTULO".localized + "*", imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txttypeNotification, Placeholder: "TIPO DE NOTIFICACIÓN".localized + "*", imageIcon: UIImage(named: "sort-down-solid")!)
        setMDCTxtFieldDesign(txtfiled: txtkind, Placeholder: "TIPO".localized + "*", imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txttime, Placeholder: "DE".localized  + "*", imageIcon: UIImage(named: "ic-clock")!)
        setMDCTxtFieldDesign(txtfiled: txtdate, Placeholder: "FECHA".localized + "*", imageIcon: UIImage(named: "ic-calendar-1")!)
        setMDCTxtFieldDesign(txtfiled: txtscop, Placeholder: "ALCANCE".localized + "*", imageIcon: UIImage(named: "sort-down-solid")!)
        setMDCTxtFieldDesign(txtfiled: txtscop, Placeholder: "ALCANCE".localized + "*", imageIcon: UIImage(named: "sort-down-solid")!)
        setMDCTxtAreaDesign(txtfiled: msgViewArea, Placeholder: "MENSAJE".localized + "*", imageIcon: UIImage())
        self.msgViewArea.textView.delegate = self
        txttime.delegate = self
        txtdate.delegate = self
    }
    
    @objc func imageLongPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            self.img.image = nil
            self.img.isHidden = true
            self.emptyView.isHidden = false
            self.imageUrl = nil
        }
    }
    @objc func viewLongPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            self.fileView.isHidden = true
            self.emptyView.isHidden = false
            crossFileAction(self.fileBtn)
        }
    }
    

    
    @IBAction func searchaction(_ sender: UIButton) {
        if txtsearch.text == "" {
            
            return
        }
        
    }
    
    @IBAction func backAcrion(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func crossFileAction(_ sender: UIButton) {
        if self.fileUrl?.absoluteString.isEmpty == false {
            self.fileUrl = URL(string: "")
            self.fileName = ""
            self.fileView.isHidden = true
            emptyView.isHidden = false
        }
        
    }
    
    @IBAction func galleryAction(_ sender: UIButton) {
        // create the alert
//        let alert = UIAlertController(title: "Alert", message: "Select Image", preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
//        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: { action in
//            self.openCamera()
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
//        alert.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default, handler: { galerryAction in
//            self.openGallery()
//        }))
        self.openGallery()
        // show the alert
//        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .camera
        controller.allowsEditing = false
        present(controller, animated: true, completion: nil)
    }
    
    
    func openGallery() {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        controller.allowsEditing = false
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func fileAction(_ sender: UIButton) {
        
        //        let importMenu = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String, kUTTypePNG as String, kUTTypeJPEG as String], in: .import)
        let importMenu = UIDocumentPickerViewController(documentTypes: [String("public.data")], in: .import)
        
        //        UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .import)
        if #available(iOS 11.0, *) {
            importMenu.allowsMultipleSelection = false
        }
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
    }
    
    
    
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        
        self.fileUrl = myURL
        self.fileName = myURL.lastPathComponent
        self.lblfilename.text = self.fileName
        print("import result : \(myURL)")
        print("import result extenssion : \(myURL.pathExtension)")
        if myURL.pathExtension.lowercased() == "jpg" || myURL.pathExtension.lowercased() == "jpeg"{
            fileType.image = UIImage(named: "jpg")
        }
        else if myURL.pathExtension.lowercased() == "png"{
            fileType.image = UIImage(named: "jpg")
        }
        else if myURL.pathExtension.lowercased() == "pdf"{
            fileType.image = UIImage(named: "pdf")
        }
        else if myURL.pathExtension.lowercased() == "doc" || myURL.pathExtension.lowercased() == "docx"{
            fileType.image = UIImage(named: "doc")
        }
        else if myURL.pathExtension.lowercased() == "xls" || myURL.pathExtension.lowercased() == "xlsx"{
            fileType.image = UIImage(named: "xls")
        }
        else {
            fileType.image = UIImage(named: "file")
        }
        
        //        self.txtType = myURL.pathExtension
        self.fileView.isHidden = false
        self.emptyView.isHidden = true
        img.image = nil
        if img.image == nil {
            img.image = nil
            img.isHidden = true
        }
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    func getallUsersListApi(){
        userhandler.getAllusers(companyid: ShareData.shareInfo.contractData?.company?.id ?? "", Success: {response in
            if response?.success == true {
                self.userListdata = response?.data ?? []
                self.userSearchListData = response?.data ?? []
            } else {
                
            }
        }, Failure: {error in
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    
    
    func checkData()->Bool {
        if txtqualificatioon.text == "" {
            AppUtility.showErrorMessage(message: "lb_empty_announcement_title".localized)
            return false
        }
        
        if self.typenotiId == 2 {
            if txtdate.text == "" {
                AppUtility.showErrorMessage(message: "Please Enter The Date")
                return false
                
            } else if txttime.text == ""{
                AppUtility.showErrorMessage(message: "Please Enter The Time")
                return false
            }
        }
        
        else if txttypeNotification.text == "" {
            AppUtility.showWarningMessage(message: "lb_warning_data_empty".localized)
            return false
        }
        
        else if txtscop.text == "lb_title_scope_choose_some_employees".localized {
            if self.selectedUsersList.count > 0 {}
            else {
                
                AppUtility.showWarningMessage(message: "lb_empty_announcement_other_type".localized)
                return false
                
            }
        }
        else if txtkind.text == "" {
            AppUtility.showWarningMessage(message: "lb_empty_no_employees_selected".localized)
            return false
        }
        
        return true
    }
    
    func getallnotificationTypesApi(){
        userhandler.getAllNotificationTypes { response  in
            if response?.success == true {
                self.notificationsdata = response?.data
            } else {
                
            }
        } Failure: { error  in
            
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tblHeight.constant = self.tblView.contentSize.height
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tblHeight.constant = self.tblView.contentSize.height
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                DispatchQueue.main.async {
                    let newsize  = newvalue as! CGSize
                    self.tblHeight.constant = newsize.height
                }
                
            }
        }
    }
    
    
    
    
    
    @IBAction func stripAction(_ sender: UIButton) {
        if checkData(){
            createNotificationApi()
        }
    }
    
    
    func createNotificationApi(){
        self.showLoader()
        var topic = ""
        var path = ""
        
        if fileUrl?.absoluteString.isEmpty == true {
            path = "notification_image"
        } else {
            path = "notification_file"
        }
        
        if ShareData.shareInfo.userRole == .contractor ||  ShareData.shareInfo.userRole == .contractoremplyee
        {
            topic = "CONTRACTOR"
        } else if  ShareData.shareInfo.userRole == .provider ||  ShareData.shareInfo.userRole == .provideremployee {
            topic = "SUPPLIER"
            
        } else if ShareData.shareInfo.userRole == .employees {
            topic = "EMPLOYEE"
        }
        
        let userdic : [String:Any] = ["id":ShareData.shareInfo.obj?.id ?? ""]
        let companydic : [String:Any] = ["id":ShareData.shareInfo.conractWithCompany?.company?.id ?? ""]
        let notificationTypeDic: [String:Any] = ["id":typenotiId]
        let dic :[String:Any] = ["title":txtqualificatioon.text ?? "","message":self.msgViewArea.textView.text ?? "","dateMeeting":sectimeInMili,"user":userdic,"company":companydic,"notificationType":notificationTypeDic,"type":txttypeNotification.text ?? "", "topic": topic]
        //        let dic :[String:Any] = ["title":txtqualificatioon.text ?? "","message":self.msgViewArea.textView.text ?? "","dateMeeting":sectimeInMili,"user":userdic,"company":companydic,"notificationType":notificationTypeDic,"path":self.fileName,"type":txttypeNotification.text ?? "", "topic": topic]
        userhandler.createNotification(params: dic, Success: {response in
            self.hidLoader()
            
            if response?.success == true {
                ShareData.shareInfo.saveNotification(qualification: self.txtqualificatioon.text!, message:self.msgViewArea.textView.text ?? "", notificationkind: self.txtkind.text!, Notificationtime:"\(self.sectimeInMili)", Notificationdate: "\(self.sectimeInMili)", notificationType: self.txttypeNotification.text!, username: ShareData.shareInfo.obj?.name ?? "", createdAt: "\(response?.data?.createdAt ?? 0)", type: "\(self.typenotiId)",dateMeeting:"\(response?.data?.dateMeeting ?? 0)",path:"\(response?.data?.path ?? "\(path)")",driveId:"\(response?.data?.driveId ?? "")",file:"\(response?.data?.file ?? "")",image:"\(response?.data?.image ?? "")",id:"\(response?.data?.id ?? "")", notificationId: response?.data?.notificationType?.id ?? -1, email: response?.data?.user?.email ?? "")
                self.createNotifidata =  response?.data
                
                if self.img.image != nil {
                    self.uploadImage(notificationId: self.createNotifidata?.id ?? "")
                }
                
                if self.fileUrl?.absoluteString.isEmpty == false {
                    self.uploadFile(notificationId: self.createNotifidata?.id ?? "")
                }
                
                if self.img.image == nil && self.fileUrl?.absoluteString.isEmpty == true {
                    
                    if self.isEmployee == false {
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        self.createNotificationWithUsersApi(notificationid: response?.data?.id ?? "")
                    }
                }
                else {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    func createNotificationWithUsersApi(notificationid:String){
        self.selectedUsersList.removeAll()
        
        for item in self.userSearchListData {
            if item.isSelected == true {
                self.selectedUsersList.append(item.id ?? "")
            }
        }
        
        
        let dic : [String:Any] = ["notificationId":notificationid,"employeesIds":selectedUsersList]
        self.showLoader()
        userhandler.createNotificationWithUsers(params: dic, Success: { response in
            self.hidLoader()
            if response?.success == true {
                self.navigationController?.popViewController(animated: true)
                AppUtility.showSuccessMessage(message: "lb_success_creating_announcement".localized,showTitle: false)
            } else {
                
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    
    func uploadImage(notificationId:String){
        let dic:[String:Any] = ["id":notificationId,"option":"notification_image"]
        if imageUrl != nil {
            
            userhandler.uploadUserFile(fileName:imageName, param:dic,fileurl: imageUrl!, Success: {response in
                self.hidLoader()
                if response?.success == true {
                    self.img.image = nil
                    if self.isEmployee == false {
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        self.createNotificationWithUsersApi(notificationid: self.createNotifidata?.id ?? "")
                    }
                } else {
                    
                }
            }, Failure: {error in
                self.hidLoader()
                AppUtility.showErrorMessage(message:error.message)
            })
        }
        else {
            userhandler.uploadImage(param:dic,img:self.img.image,file:imageName,Success: {response in
                self.hidLoader()
                if response?.success == true {
                    self.img.image = nil
                    if self.isEmployee == false {
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        self.createNotificationWithUsersApi(notificationid: self.createNotifidata?.id ?? "")
                    }
                } else {
                    
                }
            }, Failure: {error in
                self.hidLoader()
                AppUtility.showErrorMessage(message:error.message)
            })
        }
        
    }
    
    func uploadFile(notificationId:String){
        let dic:[String:Any] = ["id":notificationId,"option":"notification_file"]
        if let url = fileUrl {
            userhandler.uploadUserFile(fileName:self.fileName,param:dic,fileurl: url, Success: {response in
                self.hidLoader()
                if response?.success == true {
                    self.fileUrl = URL(string: "")
                    if self.isEmployee == false {
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        self.createNotificationWithUsersApi(notificationid: self.createNotifidata?.id ?? "")
                    }
                } else {
                    AppUtility.showErrorMessage(message:response?.message ?? "")
                }
            }, Failure: {error in
                self.hidLoader()
                AppUtility.showErrorMessage(message:error.message)
            })
        }
    }
    
    
    
    
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        self.msg = textView.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtdate {
            self.datePickerConfig(DatePickerMood:.date)
            myDatePicker.showPickerInView(view, animated: true)
        } else if textField == txttime {
            self.datePickerConfig(DatePickerMood:.time)
            myDatePicker.showPickerInView(view, animated: true)
        }
        else {
            
        }
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField == txtsearch {
            
            if textField.text == "" {
                search = false
                self.userSearchListData = userListdata
            }
            else {
                self.search = true
                self.userSearchListData = userListdata.filter { item in
                    if let name = item.name?.lowercased() {
                        if name.contains(textField.text!.lowercased()) {
                            return true
                        }
                        
                        return false
                    }
                    
                    return false
                }
                
            }
            self.tblView.reloadData()
        }
        
    }
    
    
    //MARK:- datePicker general funtion
    func datePickerConfig(DatePickerMood:UIDatePicker.Mode) {
        myDatePicker.delegate = self
        myDatePicker.minimumDate = Date()
        myDatePicker.toolbarBackgroundColor = UIColor.white
        myDatePicker.pickerBackgroundColor = UIColor.white
        myDatePicker.pickerMode = DatePickerMood
        // Customize title
        myDatePicker.title = ""
        myDatePicker.titleFont = UIFont.systemFont(ofSize: 16)
        myDatePicker.titleColor = UIColor.white
        if #available(iOS 13.4, *) {
            myDatePicker.picker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        myDatePicker.picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        let cancel = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(canceleDatePicker))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action:#selector(onClickDoneButton))
        myDatePicker.leftButtons = [ cancel]
        myDatePicker.rightButtons = [doneButton]
    }
    
    //MARK:- datepicker tools funtion
    @objc func canceleDatePicker() {
        self.txttime.resignFirstResponder()
        self.txtdate.resignFirstResponder()
        myDatePicker.pressedCancel(self)
    }
    
    //Toolbar done button function
    @objc func onClickDoneButton() {
        self.txttime.resignFirstResponder()
        self.txtdate.resignFirstResponder()
        myDatePicker.hidePicker(true)
        
    }
    
    @objc func datePickerValueChanged(_ picker : UIDatePicker) {
        print(picker.date)
        if picker.datePickerMode == .date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
            let stringDate = dateFormatter.string(from: picker.date)
            self.txtdate.text = stringDate
            
            sectimeInMili = StartDayMiliSeconds(newdate: picker.date) ?? 0//Int(picker.date.timeIntervalSince1970 * 1000)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let stringDate = dateFormatter.string(from: picker.date)
            self.txttime.text = stringDate
            sectimeInMili = StartDayMiliSeconds(newdate: picker.date) ?? 0//Int(picker.date.timeIntervalSince1970 * 1000)
            
        }
    }
    
    
    @IBAction func notificationAction(_ sender: UIButton) {
        dropDownConfig(txtField: txttypeNotification, data: ["JUNTA".localized,"ANUNCIO".localized,"OTRO".localized])
    }
    @IBAction func scopAction(_ sender: UIButton) {
        dropDownConfig(txtField: txtscop, data: ["lb_title_scope_all".localized,"lb_title_scope_employee".localized,"lb_title_scope_contractor".localized,"lb_title_scope_supplier".localized,"lb_title_scope_choose_some_employees".localized])
        
    }
    //MARK:- General dropdown function
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
            //            self.txtselcted.text = item
            //            self.question?.selectedAns = index
            //            self.question?.answerText = item
            //            self.delegate?.myclaimdropdown(cell:self, ind: index, Section: self.mysection  )
            
            if self.txtscop ==  txtField {
                txtscop.text = item
                
                if item == "lb_title_scope_choose_some_employees".localized {
                    self.tblView.isHidden = false
                    self.isEmployee = true
                    self.scopeSelected = true
                } else {
                    self.tblView.isHidden = true
                    self.tblHeight.constant = 0
                    self.isEmployee = false
                    self.scopeSelected = false
                }
            } else if txttypeNotification == txtField {
                txttypeNotification.text = item
                if item == "JUNTA".localized{
                    self.typenotiId = 2
                    txtkind.isHidden = true
                    txttime.isHidden = false
                    txtdate.isHidden = false
                    
                } else if item == "ANUNCIO".localized{
                    self.typenotiId = 3
                    txtkind.isHidden = true
                    txttime.isHidden = true
                    txtdate.isHidden = true
                } else if item == "OTRO".localized{
                    txtkind.isHidden = false
                    txttime.isHidden = true
                    txtdate.isHidden = true
                    self.typenotiId = 4
                }
            }
            
        }
        MainDrowpDown.show()
    }
    
    //MARK:- DatePicker Delegates
    func  datePickerWillAppear(_ picker: SMDatePicker){
        print(picker.pickerDate)
        self.hideKeyboard()
        if picker.pickerMode == .date {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
            let stringDate = dateFormatter.string(from: picker.pickerDate)
            self.txtdate.text = stringDate
            
        } else {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let stringDate = dateFormatter.string(from: picker.pickerDate)
            self.txttime.text = stringDate
            
        }
    }
    
    func datePickerDidAppear(_ picker: SMDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        
    }
    
    private func  datePicker(picker: SMDatePicker, didPickDate date: NSDate) {
        print(date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        
    }
    
    func  datePickerDidCancel(_ picker: SMDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        
    }
    
    
    func  datePickerWillDisappear(_ picker: SMDatePicker) {
        print(picker.pickerDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        
    }
    
    func  datePickerDidDisappear(_ picker: SMDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        
    }
    
}


extension NewNotificationVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userSearchListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "NewNotificationCell") as? NewNotificationCell
        cell?.lblname.text =  self.userSearchListData[indexPath.row].name
        cell?.lblrole.text =  self.userSearchListData[indexPath.row].userType?.name
        cell?.lblphone.text =  self.userSearchListData[indexPath.row].phoneNumber
        self.view.setNeedsLayout()
        //checkbox-outline
        
        if self.userListdata[indexPath.row].isSelected == true {
            cell?.btncheckbox.setBackgroundImage(UIImage(named: "ic-check-2"), for: .normal)
        } else {
            cell?.btncheckbox.setBackgroundImage(UIImage(named: "checkbox-outline"), for: .normal)
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.userSearchListData[indexPath.row].isSelected = !self.userSearchListData[indexPath.row].isSelected
        self.userListdata[indexPath.row].isSelected = !self.userListdata[indexPath.row].isSelected
        self.tblView.reloadData()
    }
}
extension NewNotificationVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        let url = info[UIImagePickerController.InfoKey.imageURL] as? URL
        //        self.txtType = url?.pathExtension ?? "jpeg"
        self.imageName = url?.lastPathComponent ?? "Image.jpeg"
        self.imageUrl = url
        self.emptyView.isHidden = true
        if self.fileUrl?.absoluteString.isEmpty == false {
            self.fileUrl = URL(string: "")
            self.fileName = ""
            self.fileView.isHidden = true
            
        }
        self.img.isHidden = false
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
           let _ = image.jpegData(compressionQuality: 0.5) {
            self.img.image = UIImage(data: image.compress(to: 500))
        }
    }
}
