//
//  ONUEventInvitationVC.swift
//  iEntry
//
//  Created by ZAFAR on 29/04/2022.
//

import UIKit
import DropDown
import EPContactsPicker
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class ONUEventInvitationVC: BaseController,UITextFieldDelegate, UITextViewDelegate,EPPickerDelegate {
    func epContactPicker(_: EPContactsPicker, didSelectMultipleContacts contacts: [EPContact]) {
        for item in contacts {
            self.checkUserExistApi(name: item.firstName + item.lastName,phone: item.phoneNumbers.first?.phoneNumber ?? "", isphone: true)
        }
    }
    
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var txtvistorcomments: UITextView!
    
    @IBOutlet weak var lblfindemployee: UILabel!
    @IBOutlet weak var lblfindUser: UILabel!
    var  userListdata = [GetAllUsersListModelData]()
    var MainDrowpDown = DropDown()
    @IBOutlet weak var txtemployee: MDCOutlinedTextField!
    @IBOutlet weak var employeedorpdownView: UIView!
    
    @IBOutlet weak var lblscreentitle: UILabel!
    @IBOutlet weak var lblenduptitle: UILabel!
    @IBOutlet weak var btngetnumber: UIButton!
    
    @IBOutlet weak var lblcanceltitle: UILabel!
    
    
    //MARK: - Variables
    
    var invitationsData : [getAllInvitationsAgainstEventModelData]? = nil
    var eventDetaildata : EventDetailModelData? = nil
    var  commenAreasdata : [CommenAreasModelsData]? = nil
    var usersIDsarr = [String]()
    var checkRegisterUser = [checkUserExistModel]()
    var invitationlist = [InvitationsHistoryModel]()
    var param = eventDic()
    var eventid = ""
    var guestNumber = 0
    
    //MARK:- here are the ibOUtlet
    @IBOutlet weak var lblnumberofInvitation: UILabel!
    
    @IBOutlet weak var lblvistortitle: UILabel!
    @IBOutlet weak var txtsearch: UITextField!
    @IBOutlet weak var searchButtonView: UIView!
    @IBOutlet weak var stripView: UIView!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtvistorcomments.alpha = 0.5
        setMDCTxtFieldDesign(txtfiled: txtemployee, Placeholder: "EMPLOYEE", imageIcon: UIImage(named: "sort-down-solid")!)
        txtvistorcomments.delegate = self
        txtvistorcomments.text = "COMENTARIOS PARA VISITANTES.".localized
        lblscreentitle.text = "CREAR EVENTO".localized
        self.lblvistortitle.text = "VISITORS".localized
        self.lblcanceltitle.text = "ANTERIOR".localized
        searchView.shadowAndRoundcorner(cornerRadius: Float(searchView.layer.frame.height) / 2, shadowColor: #colorLiteral(red: 0.8430451751, green: 0.843190372, blue: 0.843035996, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1)
        
        searchButtonView.roundCorners([.topRight,.bottomRight], radius: 25)
        self.tblView.register(UINib.init(nibName: "RecordDetailCell", bundle: nil), forCellReuseIdentifier: "RecordDetailCell")
        stripView.roundViiew()
        txtsearch.delegate = self
        tblView.isScrollEnabled = false
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.txtsearch.placeholder = "Escribe no celular / email para invitar".localized
        let attributed = NSAttributedString(string: "O ELIGE EN BASE A TU LISTA DE CONTACTOS".localized, attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.thick.rawValue,NSAttributedString.Key.foregroundColor : UIColor(hexString: "909090")])
        self.lblfindUser.text = "ENCUENTRA A ALGUIEN".localized
        self.lblfindemployee.text = "DE LA LISTA DE EMPLEADOS".localized
        self.btngetnumber.setAttributedTitle(attributed, for: .normal)
        self.lblenduptitle.text = "TERMINAR".localized
        self.lblenduptitle.text = "SIGUIENTE".localized
        self.lblnumberofInvitation.text = "\(checkRegisterUser.count) " + "Invitaciones".localized
        getallUsersListApi()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "COMENTARIOS PARA VISITANTES.".localized {
            textView.text = ""
            textView.alpha = 1
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            textView.alpha = 0.5
            textView.text = "COMENTARIOS PARA VISITANTES.".localized
        }
    }
    
    @IBAction func acctiontoBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                DispatchQueue.main.async {
                    let newsize  = newvalue as! CGSize
                    self.tblHeight.constant = newsize.height
                    
                    self.view.layoutIfNeeded()
                }
                
            }
        }
    }
    
    func getallUsersListApi(){
        self.showLoader()
        userhandler.getAllusers(companyid: ShareData.shareInfo.contractData?.company?.id ?? "", Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.userListdata = response?.data ?? []
            } else {
                
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    func checkData() ->Bool {
        if self.checkRegisterUser.count < 1 {
            AppUtility.showErrorMessage(message: "lb_dialog_message_event_user_to_invite".localized)
            return false
        }
        return true
    }
    
    @IBAction func endupAction(_ sender: UIButton) {
        
        if checkData() {
            
            self.param.dic.updateValue(txtvistorcomments.text ?? "", forKey: "visitorComment")
            
            let storyBoard = UIStoryboard.init(name: "ONUEvent", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"ONUVehicleVC") as? ONUVehicleVC
            vc?.param = self.param
            vc?.param.checkRegisterUser =  self.checkRegisterUser
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tblHeight.constant =  self.tblView.contentSize.height
    }
    
    @IBAction func searchaction(_ sender: UIButton) {
        if txtsearch.text == "" {
            AppUtility.showErrorMessage(message: "lb_error_email_not_exists".localized)
            return
        } else if txtsearch.text?.isValidEmail == true {
            searchApi(phone:txtsearch.text!, isphone: false)
            
        } else if isValidPhone(phone: txtsearch.text ?? "") == true {
            searchApi(phone:txtsearch.text!, isphone: true)
        } else {
            AppUtility.showErrorMessage(message: "lb_error_email_not_exists".localized)
        }
        
        
    }
    func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string != ""{
            //searchApi(phone:textField.text!+string)
        }
        
        
        if string == ""{
            self.checkRegisterUser.removeAll()
            for item in invitationsData ?? [] {
                self.checkRegisterUser.append(checkUserExistModel(name: item.guest?.name ?? "", phone: item.guest?.phoneNumber ?? "", isregister: true, guestid: item.guest?.id ?? "", registertype: 2, email: item.guest?.email ?? ""))
            }
            self.tblView.reloadData()
        }
        
        return true
    }
    
    
    @IBAction func contactListAction(_ sender: UIButton) {
        //        self.checkRegisterUser.removeAll()
        //        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        //        let vc = storyBoard.instantiateViewController(withIdentifier:"ContactListVC") as? ContactListVC
        //        vc?.callBack = { selectedNumbers in
        //
        //            for item in selectedNumbers {
        //
        //                self.checkUserExistApi(name: item.name!,phone: item.number!, isphone: true)
        //            }
        //        }
        //        self.navigationController?.pushViewController(vc!, animated: true)
        let contactPickerScene = EPContactsPicker(delegate: self, multiSelection:true, subtitleCellType: SubtitleCellValue.phoneNumber)
        let navigationController = UINavigationController(rootViewController: contactPickerScene)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    
    func searchApi(phone:String,isphone:Bool){
        //self.showLoader()
        var freedSpaceString = phone.filter {!$0.isWhitespace}
        if freedSpaceString.first != "+" {
            freedSpaceString = "+" + freedSpaceString
        }
        freedSpaceString = freedSpaceString.replacingOccurrences(of: "-", with: "")
        freedSpaceString = freedSpaceString.replacingOccurrences(of: "(", with: "")
        freedSpaceString = freedSpaceString.replacingOccurrences(of: ")", with: "")
        userhandler.checkUserExist(phone: freedSpaceString,isphone:isphone, Success: {[self]response in
            self.hidLoader()
            if response?.message?.contains("not exists") ?? false {
                if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone || $0.email == phone}) {
                    self.checkRegisterUser.append(checkUserExistModel(name: "", phone: phone, isregister: false, guestid:"", registertype: 0, email: ""))
                }
                
            } else {
                
                if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone || $0.email == phone }) {
                    self.checkRegisterUser.append(checkUserExistModel(name: response?.data?.name ?? "", phone: response?.data?.phoneNumber ?? "", isregister: true, guestid: response?.data?.id ?? "", registertype: 1, email:response?.data?.email ?? "" ))
                }
                else
                {
                    AppUtility.showInfoMessage(message: "lb_warning_user_already_in_list".localized,showTitle: false)
                }
            }
            self.tblView.reloadData()
            
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    @IBAction func employeSwitchAction(_ sender: UISwitch) {
        if sender.isOn == true {
            self.employeedorpdownView.isHidden = false
            self.searchView.isHidden = true
            self.lblfindemployee.textColor = #colorLiteral(red: 0.1884683073, green: 0.50359869, blue: 0.4553821087, alpha: 1)
            self.lblfindUser.textColor = #colorLiteral(red: 0.8077545762, green: 0.8078941703, blue: 0.8077457547, alpha: 1)
        } else {
            self.employeedorpdownView.isHidden = true
            self.searchView.isHidden = false
            self.lblfindemployee.textColor = #colorLiteral(red: 0.8077545762, green: 0.8078941703, blue: 0.8077457547, alpha: 1)
            self.lblfindUser.textColor = #colorLiteral(red: 0.1884683073, green: 0.50359869, blue: 0.4553821087, alpha: 1)
        }
    }
    
    @IBAction func employeeDropwAction(_ sender: UIButton) {
        
        var employeeList = [String]()
        
        for item in self.userListdata {
            employeeList.append(item.name ?? "")
        }
        
        dropDownConfig(txtField: txtemployee, data: employeeList)
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
            self.txtemployee.text = item
            
            if !self.checkRegisterUser.contains(where: { $0.phoneemail == self.userListdata[index].phoneNumber ?? "" }) {
                self.checkRegisterUser.append(checkUserExistModel(name: self.userListdata[index].name ?? "", phone:self.userListdata[index].phoneNumber ?? "", isregister: false, guestid:self.userListdata[index].id ?? "", registertype: 1, email: self.userListdata[index].email ?? ""))
            }
            self.lblnumberofInvitation.text = "\(checkRegisterUser.count) " + "Invitaciones".localized
            self.tblView.reloadData()
        }
        MainDrowpDown.show()
    }
    
    
    
    func checkUserExistApi(name:String,phone:String,isphone:Bool){
        self.showLoader()
        var freedSpaceString = phone.filter {!$0.isWhitespace}
        if freedSpaceString.first != "+" {
            freedSpaceString = "+" + freedSpaceString
        }
        freedSpaceString = freedSpaceString.replacingOccurrences(of: "-", with: "")
        freedSpaceString = freedSpaceString.replacingOccurrences(of: "(", with: "")
        freedSpaceString = freedSpaceString.replacingOccurrences(of: ")", with: "")
        userhandler.checkUserExist(phone: freedSpaceString, isphone: isphone, Success: {[self]response in
            self.hidLoader()
            if response?.success == true {
                
                DispatchQueue.main.async {
                    
                    ShareData.shareInfo.saveExistUser(existuser: (response?.data)!)
                    UserDefaults.standard.save(customObject: response?.data, inKey: "checkuserExist")
                    ShareData.shareInfo.invitatiosdataSaved(name: response?.data?.name ?? "", phone: response?.data?.phoneNumber ?? "", date: getCurrentDate(), guestid: response?.data?.id ?? "", id: response?.data?.id ?? "")
                    
                    do {
                        // setting a value for a key
                        let newPerson = InvitationsHistoryModel(name:response?.data?.name ?? "", phone:response?.data?.phoneNumber ?? "", date:getCurrentDate(), guestid: response?.data?.id ?? "", id: response?.data?.id ?? "")
                        
                        invitationlist.append(newPerson)
                        let encodedData = try NSKeyedArchiver.archivedData(withRootObject: invitationlist, requiringSecureCoding: false)
                        UserDefaults.standard.set(encodedData, forKey: "invitation")
                        
                    } catch {
                        print("There is Error:",error)
                    }
                    
                    
                    
                    ShareData.shareInfo.contactListSaved(isregister: true, name: response?.data?.name ?? "", phoneemail: response?.data?.phoneNumber ?? "", guestid: response?.data?.id ?? "", registertype: 1, email:  response?.data?.email ?? "")
                    
                    
                    
                    do {
                        // setting a value for a key
                        let newPerson = checkUserExistModel(name: response?.data?.name ?? "", phone: response?.data?.phoneNumber ?? "", isregister: true, guestid: response?.data?.id ?? "", registertype: 1, email:  response?.data?.email ?? "")
                        
                        if !self.checkRegisterUser.contains(where: { $0.phoneemail == response?.data?.phoneNumber ?? "" }){
                            
                            checkRegisterUser.append(newPerson)
                        }
                        
                        let encodedData = try NSKeyedArchiver.archivedData(withRootObject: checkRegisterUser, requiringSecureCoding: false)
                        UserDefaults.standard.set(encodedData, forKey: "contactList")
                        
                    } catch {
                        print("There is Error:",error)
                    }
                }
                
                if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone }) {
                    self.checkRegisterUser.append(checkUserExistModel(name: response?.data?.name ?? "", phone: response?.data?.phoneNumber ?? "", isregister: true, guestid: response?.data?.id ?? "",registertype:1, email:  response?.data?.email ?? ""))
                }
                
                
            } else {
                if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone }) {
                    ShareData.shareInfo.contactListSaved(isregister: false, name: name, phoneemail: phone, guestid: response?.data?.id ?? "", registertype: 1, email:  response?.data?.email ?? "")
                    self.checkRegisterUser.append(checkUserExistModel(name: name, phone: phone, isregister: false, guestid:"", registertype: 1, email: phone))
                }
            }
            self.lblnumberofInvitation.text = "\(checkRegisterUser.count) " + "Invitaciones".localized
            //self.filterData =  self.checkRegisterUser
            self.tblView.reloadData()
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }

    
    func updateInvidationUsers() {
        self.showLoader()
        
        self.usersIDsarr.removeAll()
        var mainArr = [[String:Any]]()
        for item in self.checkRegisterUser {
            if item.isregister == true {
                mainArr.append(["guest":["id":item.guestid],"guestNumber":guestNumber])
                //usersIDsarr.append("\(item.guestid)")
            }
        }
        
        let dic : [String:Any] = ["eventId":eventid,"userInvitations":mainArr]
        //
        //usersIds
        userhandler.sendInvitation(params: dic, Success: {response in
            self.hidLoader()
            
            if response?.success == true {
                self.dismiss(animated: true, completion: nil)
                
                
                self.dismiss(animated: false, completion: {
                    
                })
                self.navigationController?.popToViewController(ofClass: HomeVC.self)
                AppUtility.showSuccessMessage(message: response?.message ?? "")
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
}
//MARK:- tableview datesource and delegate
extension ONUEventInvitationVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.lblnumberofInvitation.text = "\(checkRegisterUser.count) " + "Invitaciones".localized
        return self.checkRegisterUser.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "RecordDetailCell") as? RecordDetailCell
        if self.checkRegisterUser[indexPath.row].registertype == 0 {
            cell?.tick.image = UIImage(named:"exclamation-solid")
            
        } else if self.checkRegisterUser[indexPath.row].registertype == 1 {
            cell?.tick.image = UIImage(named:"chevron-right-solid")
        } else {
            cell?.tick.image = UIImage(named:"ic-check-2")
        }
        cell?.userimg.image = UIImage(named: "ic-user-list")
        
        cell?.lblname.text = self.checkRegisterUser[indexPath.row].name
        cell?.lblphone.text = self.checkRegisterUser[indexPath.row].phoneemail
        //            cell?.callBack = { istrue in
        //
        //                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        //                let vc = storyBoard.instantiateViewController(withIdentifier:"CancelEventInvitationVC") as? CancelEventInvitationVC
        //                vc?.modalPresentationStyle = .overFullScreen
        //
        //                self.present(vc!, animated: false, completion: nil)
        //            }
        return cell!
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.checkRegisterUser[indexPath.row].registertype == 1 {
            
            
            let storyBoard = UIStoryboard.init(name: "ONUEvent", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"ONURegisterUserVC") as? ONURegisterUserVC
            vc?.number = self.checkRegisterUser[indexPath.row].phoneemail
            vc?.name = self.checkRegisterUser[indexPath.row].name
            vc?.email = self.checkRegisterUser[indexPath.row].email//ShareData.shareInfo.checkUserExist?.email ?? ""
            vc?.isAlreadyRegister = true
            vc?.callBack = {name,email,phone,organization,pickupSite, numberofCompanoin,bzbadge,ispdfShare in
                for item in self.checkRegisterUser {
                    if item.phoneemail == phone {
                        self.checkRegisterUser[indexPath.row].registertype = 2
                        self.checkRegisterUser[indexPath.row].name = name
                        
                    }
                }
                
                self.param.invitationDic.updateValue(numberofCompanoin, forKey: "guestNumber")
                self.param.invitationDic.updateValue(ispdfShare, forKey: "sharePdf")
                self.param.invitationDic.updateValue(organization, forKey: "organization")
                self.param.invitationDic.updateValue(pickupSite, forKey: "placeToPickUp")
                self.param.invitationDic.updateValue(bzbadge, forKey: "gzBadge")
                
                self.tblView.reloadData()
            }
            vc?.modalPresentationStyle = .overFullScreen
            
            self.present(vc!, animated: false, completion: nil)
            
            
        } else if self.checkRegisterUser[indexPath.row].registertype == 0{
            
            
            let storyBoard = UIStoryboard.init(name: "ONUEvent", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"ONUUserNotRegisterPopUpVC") as? ONUUserNotRegisterPopUpVC
            
            vc?.callBack = {
                vc?.dismiss(animated: true, completion: nil)
                
                
                
                
                let storyBoard = UIStoryboard.init(name: "ONUEvent", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"ONURegisterUserVC") as? ONURegisterUserVC
                vc?.number = self.checkRegisterUser[indexPath.row].phoneemail
                vc?.name = self.checkRegisterUser[indexPath.row].name
                vc?.email = ShareData.shareInfo.checkUserExist?.email ?? ""
                vc?.isAlreadyRegister = false
                vc?.callBack = {name,email,phone,organization,pickupSite, numberofCompanoin,bzbadge,ispdfShare in
                    
                    for item in self.checkRegisterUser {
                        
                        if item.phoneemail == phone {
                            self.checkRegisterUser[indexPath.row].isregister = true
                            self.checkRegisterUser[indexPath.row].name = name
                            
                        }
                    }
                    
                    self.param.invitationDic.updateValue(numberofCompanoin, forKey: "guestNumber")
                    self.param.invitationDic.updateValue(ispdfShare, forKey: "sharePdf")
                    self.param.invitationDic.updateValue(organization, forKey: "organization")
                    self.param.invitationDic.updateValue(pickupSite, forKey: "placeToPickUp")
                    self.param.invitationDic.updateValue(bzbadge, forKey: "gzBadge")
                    
                    self.tblView.reloadData()
                }
                vc?.modalPresentationStyle = .overFullScreen
                
                self.present(vc!, animated: false, completion: nil)
                
            }
            vc?.modalPresentationStyle = .overFullScreen
            
            self.present(vc!, animated: false, completion: nil)
            
            
            
        } else {
            
            let storyBoard = UIStoryboard.init(name: "ONUEvent", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"ONUInvitationSentVC") as? ONUInvitationSentVC
            vc?.modalPresentationStyle = .overFullScreen
            
            self.present(vc!, animated: false, completion: nil)
        }
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tblView == tableView {
            let deleteAction = UIContextualAction(style: .normal, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                
                debugPrint("Delete tapped")
                self.checkRegisterUser.remove(at: indexPath.row)
                self.lblnumberofInvitation.text = "\(self.checkRegisterUser.count)" + "Invitaciones".localized
                self.tblView.reloadData()
                success(true)
            })
            
            deleteAction.image = UIImage(named: "ic-trash-outline")
            deleteAction.backgroundColor = UIColor.red
            
            return UISwipeActionsConfiguration(actions: [deleteAction])
        } else {
            
            let deleteAction = UIContextualAction(style: .normal, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                
                debugPrint("Delete tapped")
                
                success(true)
            })
            
            deleteAction.image = UIImage(named: "ic-trash-outline")
            deleteAction.backgroundColor = UIColor.red
            
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
    }
}

