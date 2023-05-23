//
//  EventInvitation.swift
//  iEntry
//
//  Created by ZAFAR on 13/08/2021.
//

import UIKit
import DropDown
import EPContactsPicker
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class EventInvitation: BaseController,UITextFieldDelegate,EPPickerDelegate {
    func epContactPicker(_: EPContactsPicker, didSelectMultipleContacts contacts: [EPContact]) {
        for item in contacts {
            self.checkUserExistApi(name: item.firstName + item.lastName,phone: item.phoneNumbers.first?.phoneNumber ?? "", isphone: true)
        }
    }
    
    
    @IBOutlet weak var lblfindemployee: UILabel!
    @IBOutlet weak var lblfindUser: UILabel!
    
    
    @IBOutlet weak var txtemployee: MDCOutlinedTextField!
    @IBOutlet weak var lblenduptitle: UILabel!
    @IBOutlet weak var btngetnumber: UIButton!
    
    @IBOutlet weak var employeedorpdownView: UIView!
    @IBOutlet weak var lblinvitationtitle: UILabel!
    var invitationsData : [getAllInvitationsAgainstEventModelData]? = nil
    var eventDetaildata : EventDetailModelData? = nil
    var  commenAreasdata : [CommenAreasModelsData]? = nil
    var usersIDsarr = [String]()
    var checkRegisterUser = [checkUserExistModel]()
    var invitationlist = [InvitationsHistoryModel]()
    var  userListdata = [GetAllUsersListModelData]()
    var MainDrowpDown = DropDown()
    var eventid = ""
    var guestNumber = 0
    //MARK:- here are the ibOUtlet
    @IBOutlet weak var lblnumberofInvitation: UILabel!
    @IBOutlet weak var txtsearch: UITextField!
    @IBOutlet weak var searchButtonView: UIView!
    @IBOutlet weak var stripView: UIView!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchView: UIView!
    var isEmployee = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setMDCTxtFieldDesign(txtfiled: txtemployee, Placeholder: "EMPLOYEE", imageIcon: UIImage(named: "sort-down-solid")!)
        searchView.shadowAndRoundcorner(cornerRadius: Float(searchView.layer.frame.height) / 2, shadowColor: #colorLiteral(red: 0.8430451751, green: 0.843190372, blue: 0.843035996, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1)
        searchButtonView.roundCorners([.topRight,.bottomRight], radius: 25)
        self.tblView.register(UINib.init(nibName: "RecordDetailCell", bundle: nil), forCellReuseIdentifier: "RecordDetailCell")
        stripView.roundViiew()
        txtsearch.delegate = self
        tblView.isScrollEnabled = false
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.lblinvitationtitle.text = "I N V I T A C I O N E S  D E L E V E N T O".localized
        self.txtsearch.placeholder = "Escribe no celular / email para invitar".localized
        let attributed = NSAttributedString(string: "O ELIGE EN BASE A TU LISTA DE CONTACTOS".localized, attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.thick.rawValue,NSAttributedString.Key.foregroundColor : UIColor(hexString: "909090")])
        self.lblfindUser.text = "ENCUENTRA A ALGUIEN".localized
        self.lblfindemployee.text = "DE LA LISTA DE EMPLEADOS".localized
        self.lblnumberofInvitation.text = "\(checkRegisterUser.count) " + "Invitaciones".localized
        self.btngetnumber.setAttributedTitle(attributed, for: .normal)
        self.lblenduptitle.text = "TERMINAR".localized
        getallUsersListApi()
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
    @IBAction func endupAction(_ sender: UIButton) {
        if self.checkRegisterUser.count >= 1 {
            let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"PopUpNumberOFInvitationVC") as? PopUpNumberOFInvitationVC
            
            vc?.callBack = {number in
                self.guestNumber = Int(number) ?? 0
                self.updateInvidationUsers()
            }
            vc?.modalPresentationStyle = .overFullScreen
            
            self.present(vc!, animated: false, completion: nil)
        }
        else {
            AppUtility.showInfoMessage(message: "lb_empty_no_employees_selected".localized)
        }

    }
    @IBAction func backAction(_ sender: UIButton) {
        if invitationsData?.count ?? 0 == 0 {
            self.navigationController?.popViewController(animated: true)
        }
        else {
            let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationDownloadImageAlertVC") as? NotificationDownloadImageAlertVC
            vc?.titlofDialog = "USUARIOS POR INVITAR".localized
            vc?.detailofDialog = "Saldrás sin invitar usuarios tu proceso no será guardado. ¿Estás seguro quieres salir?".localized
            vc?.acceptbuttontitle = "ACEPTAR".localized
            vc?.modalPresentationStyle = .overFullScreen
            vc?.callBack = { isok in
                if Network.isAvailable {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            self.present(vc!, animated: false, completion: nil)
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tblHeight.constant =  self.tblView.contentSize.height
    }
    
    @IBAction func searchaction(_ sender: UIButton) {
        if txtsearch.text == "" {
            AppUtility.showErrorMessage(message: "Escribe no celular / email para invitar".localized)
            return
        } else if txtsearch.text?.isValidEmail == true {
            searchApi(phone:txtsearch.text!, isphone: false)
            
        } else if isValidPhone(phone: txtsearch.text ?? "") == true {
            searchApi(phone:txtsearch.text!, isphone: true)
        } else {
            AppUtility.showErrorMessage(message: "Escribe no celular / email para invitar".localized)
        }
        
        
    }
    
    
    @IBAction func employeSwitchAction(_ sender: UISwitch) {
        if sender.isOn == true {
            self.lblfindemployee.textColor = #colorLiteral(red: 0.1884683073, green: 0.50359869, blue: 0.4553821087, alpha: 1)
            self.lblfindUser.textColor = #colorLiteral(red: 0.8077545762, green: 0.8078941703, blue: 0.8077457547, alpha: 1)
            self.employeedorpdownView.isHidden = false
            self.searchView.isHidden = true
        } else {
            self.lblfindemployee.textColor = #colorLiteral(red: 0.8077545762, green: 0.8078941703, blue: 0.8077457547, alpha: 1)
            self.lblfindUser.textColor = #colorLiteral(red: 0.1884683073, green: 0.50359869, blue: 0.4553821087, alpha: 1)
            self.employeedorpdownView.isHidden = true
            self.searchView.isHidden = false
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
                self.checkRegisterUser.append(checkUserExistModel(name: self.userListdata[index].name ?? "", phone:self.userListdata[index].phoneNumber ?? "", isregister: true, guestid:self.userListdata[index].id ?? "", registertype: 1, email: self.userListdata[index].email ?? ""))
            }
            self.tblView.reloadData()
        }
        MainDrowpDown.show()
    }
    
    
    
    func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //        if string != ""{
        //            //searchApi(phone:textField.text!+string)
        //        }
        //
        //
        //        if string == ""{
        //            self.checkRegisterUser.removeAll()
        //            for item in invitationsData ?? [] {
        //                self.checkRegisterUser.append(checkUserExistModel(name: item.guest?.name ?? "", phone: item.guest?.phoneNumber ?? "", isregister: true, guestid: item.guest?.id ?? "", registertype: 0, email: item.guest?.email ?? ""))
        //            }
        //            self.tblView.reloadData()
        //        }
        
        return true
    }
    
    
    @IBAction func contactListAction(_ sender: UIButton) {
        let contactPickerScene = EPContactsPicker(delegate: self, multiSelection:true, subtitleCellType: SubtitleCellValue.phoneNumber)
        let navigationController = UINavigationController(rootViewController: contactPickerScene)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    
    func searchApi(phone:String,isphone:Bool){
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
    
    
    
    
    
    func checkUserExistApi(name:String,phone:String,isphone:Bool){
        self.showLoader()
        var freedSpaceString = phone.filter {!$0.isWhitespace}
        if freedSpaceString.first != "+" {
            freedSpaceString = "+" + freedSpaceString
        }
        freedSpaceString = freedSpaceString.replacingOccurrences(of: "-", with: "")
        freedSpaceString = freedSpaceString.replacingOccurrences(of: "(", with: "")
        freedSpaceString = freedSpaceString.replacingOccurrences(of: ")", with: "")
        userhandler.checkUserExist(phone: phone, isphone: isphone, Success: {[self]response in
            self.hidLoader()
            if response?.success == true {
                DispatchQueue.main.async {
                    
                    ShareData.shareInfo.saveExistUser(existuser: (response?.data)!)
                    UserDefaults.standard.save(customObject: response?.data, inKey: "checkuserExist")
                    ShareData.shareInfo.invitatiosdataSaved(name: response?.data?.name ?? "", phone: response?.data?.phoneNumber ?? "", date: getCurrentDate(), guestid: response?.data?.id ?? "", id: response?.data?.id ?? "")
                    
                    do {
                        // setting a value for a key
                        let newPerson = InvitationsHistoryModel(name:response?.data?.name ?? "", phone:response?.data?.phoneNumber ?? "", date:getCurrentDate(), guestid: response?.data?.id ?? "", id: response?.data?.id ?? "")
                        
                        self.invitationlist.append(newPerson)
                        let encodedData = try NSKeyedArchiver.archivedData(withRootObject: invitationlist, requiringSecureCoding: false)
                        UserDefaults.standard.set(encodedData, forKey: "invitation")
                        
                    } catch {
                        print("There is Error:",error)
                    }
                    
                    
                    
                    ShareData.shareInfo.contactListSaved(isregister: true, name: response?.data?.name ?? "", phoneemail: response?.data?.phoneNumber ?? "", guestid: response?.data?.id ?? "", registertype: 0, email: response?.data?.email ?? "")
                    
                    
                    
                    do {
                        // setting a value for a key
                        let newPerson = checkUserExistModel(name: response?.data?.name ?? "", phone: response?.data?.phoneNumber ?? "", isregister: true, guestid: response?.data?.id ?? "", registertype: 0, email: response?.data?.email ?? "" )
                        
                        checkRegisterUser.append(newPerson)
                        let encodedData = try NSKeyedArchiver.archivedData(withRootObject: checkRegisterUser, requiringSecureCoding: false)
                        UserDefaults.standard.set(encodedData, forKey: "contactList")
                        
                    } catch {
                        print("There is Error:",error)
                    }
                }
                
                if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone }) {
                    self.checkRegisterUser.append(checkUserExistModel(name: response?.data?.name ?? "", phone: response?.data?.phoneNumber ?? "", isregister: true, guestid: response?.data?.id ?? "", registertype: 0, email: response?.data?.email ?? ""))
                }
                
                
            } else {
                if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone }) {
                    ShareData.shareInfo.contactListSaved(isregister: false, name: name, phoneemail: phone, guestid: response?.data?.id ?? "", registertype: 0, email: phone)
                    self.checkRegisterUser.append(checkUserExistModel(name: name, phone: phone, isregister: false, guestid:"", registertype: 0, email: response?.data?.email ?? ""))
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
        for (i,item) in self.checkRegisterUser.enumerated() {
            if item.isregister == true {
                mainArr.append(["guest":["id":item.guestid],"guestNumber":i])
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
                self.navigationController?.popToViewController(ofClass: HomeVC.self)
                AppUtility.showSuccessMessage(message: "lb_success_event_created".localized)
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
extension EventInvitation : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.checkRegisterUser.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "RecordDetailCell") as? RecordDetailCell
        if self.checkRegisterUser[indexPath.row].isregister == true {
            
            cell?.tick.image = UIImage(named:"ic-check-2")
        } else {
            cell?.tick.image = UIImage(named:"ic-cancel")
        }
        
        
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
        
        if self.checkRegisterUser[indexPath.row].isregister == true {
            
            
            
        } else {
            let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"UserNotRegisterPopUpVC") as? UserNotRegisterPopUpVC
            vc?.number = self.checkRegisterUser[indexPath.row].phoneemail
            vc?.name = self.checkRegisterUser[indexPath.row].name
            vc?.index = indexPath.row
            vc?.callback = {number, name,index,guestID in
                self.checkRegisterUser[index].isregister = true
                self.checkRegisterUser[index].name = name
                self.checkRegisterUser[index].guestid = guestID
                self.tblView.reloadData()
            }
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
extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
}
