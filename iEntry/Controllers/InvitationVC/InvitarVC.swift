//
//  InvitarVC.swift
//  iEntry
//
//  Created by ZAFAR on 04/10/2021.
//

import UIKit
import DropDown
import EPContactsPicker
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class InvitarVC: BaseController, UITextFieldDelegate, EPPickerDelegate {
    
    func epContactPicker(_: EPContactsPicker, didSelectMultipleContacts contacts: [EPContact]) {
        for item in contacts {
            self.checkUserExistApi(name: item.firstName + item.lastName,phone: item.phoneNumbers.first?.phoneNumber ?? "", isphone: true)
        }
    }
    
    
    var checkRegisterUser = [checkUserExistModel]()
    var invitationlist = [InvitationsHistoryModel]()
    
    @IBOutlet weak var lblfindemployee: UILabel!
    @IBOutlet weak var lblfindUser: UILabel!
    var  userListdata = [GetAllUsersListModelData]()
    var MainDrowpDown = DropDown()
    @IBOutlet weak var txtemployee: MDCOutlinedTextField!
    @IBOutlet weak var employeedorpdownView: UIView!
    
    @IBOutlet weak var btnselectnumbertitle: UIButton!
    @IBOutlet weak var lblinvitortitle: UILabel!
    //MARK:- here are the iboutlet
    @IBOutlet weak var tblView: UITableView! {
        didSet{
            tblView.reloadData()
        }
    }
    @IBOutlet weak var txtsearch: UITextField!
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var lbltotalInvitation: UILabel!
    @IBOutlet weak var innerSearch: UIView!
    var totalinvitation = 0
    let acceptButton = UIButton()
    let width = UIScreen.main.bounds.size.width - 200
    let height = UIScreen.main.bounds.size.height - 100
    var isSearch = false
    var eventid = ""
    var usersIDsarr = [String]()
    var isFromEvent = false
    var colesure : ((_ invitedUsers:[checkUserExistModel])->(Void))?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isFromEvent {
            self.acceptButton.frame = CGRect(x: width, y: height, width: 180, height: 50)
            self.acceptButton.clipsToBounds = true
            self.acceptButton.setImage(UIImage(named: "terminar")!, for: .normal)
            self.acceptButton.backgroundColor = UIColor(named: "primary")
            self.acceptButton.layer.cornerRadius = 24
            self.acceptButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
            self.view.addSubview(acceptButton)
            self.lblinvitortitle.text = "INVITACIONES DEL EVENTO"
        }
        else {
            self.lblinvitortitle.text = "I N V I T A R".localized
        }
        setMDCTxtFieldDesign(txtfiled: txtemployee, Placeholder: "EMPLOYEE", imageIcon: UIImage(named: "sort-down-solid")!)
        
        self.txtsearch.placeholder = "Escribe no celular / email para invitar".localized
        let attributed = NSAttributedString(string: "O ELIGE EN BASE A TU LISTA DE CONTACTOS".localized, attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.thick.rawValue,NSAttributedString.Key.foregroundColor : UIColor(hexString: "909090")])
        self.lbltotalInvitation.text = "\(checkRegisterUser.count) \("Invitaciones".localized)"
        self.lblfindUser.text = "ENCUENTRA A ALGUIEN".localized
        self.lblfindemployee.text = "DE LA LISTA DE EMPLEADOS".localized
        self.btnselectnumbertitle.setAttributedTitle(attributed, for: .normal)
        txtsearch.delegate = self
        searchView.shadowAndRoundcorner(cornerRadius: 15, shadowColor: #colorLiteral(red: 0.866572082, green: 0.8667211533, blue: 0.8665626645, alpha: 1), shadowRadius: 3, shadowOpacity: 1)
        innerSearch.roundCorners([.topRight,.bottomRight], radius: 15)
        self.tblView.register(UINib.init(nibName: "InvitarCell", bundle: nil), forCellReuseIdentifier: "InvitarCell")
        getallUsersListApi()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getallUsersListApi()
    }
    @objc func pressed() {
        updateInvidationUsers()
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
            self.txtemployee.text = item
            
            if !self.checkRegisterUser.contains(where: { $0.phoneemail == self.userListdata[index].phoneNumber ?? "" }) {
                self.checkRegisterUser.append(checkUserExistModel(name: self.userListdata[index].name ?? "", phone:self.userListdata[index].phoneNumber ?? "", isregister: true, guestid:self.userListdata[index].id ?? "", registertype: 1, email: self.userListdata[index].email ?? ""))
            }
            self.lbltotalInvitation.text = "\(checkRegisterUser.count) \("Invitaciones".localized)"
            self.tblView.reloadData()
        }
        MainDrowpDown.show()
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        if checkRegisterUser.count == 0 {
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
        
        //        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func contactAction(_ sender: UIButton) {
        let contactPickerScene = EPContactsPicker(delegate: self, multiSelection:true, subtitleCellType: SubtitleCellValue.phoneNumber)
        let navigationController = UINavigationController(rootViewController: contactPickerScene)
        self.present(navigationController, animated: true, completion: nil)
        
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        
        if txtsearch.text == "" {
            AppUtility.showErrorMessage(message: "Please Enter Email / Phone number")
            return
        } else if txtsearch.text?.isValidEmail == true {
            searchApi(name:"", phone:txtsearch.text!, isphone: false)
            
        } else if isValidPhone(phone: txtsearch.text ?? "") == true {
            searchApi(name:"",phone:txtsearch.text!,isphone:true)
        } else {
            AppUtility.showErrorMessage(message: "Please Enter Valid Email / Phone number")
        }
    }
    
    func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
    
    func searchApi(name:String,phone:String,isphone:Bool){
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
                    self.checkRegisterUser.append(checkUserExistModel(name: name, phone: phone, isregister: false, guestid:"", registertype: 0, email: ""))
                }
                AppUtility.showInfoMessage(message: "lb_error_user_not_registered".localized)
            } else if response?.success == false {
                AppUtility.showErrorMessage(message: response?.message ?? "Not valid entry")
            }
            else if response?.success == true
            {
                if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone || $0.email == phone }) {
                    self.checkRegisterUser.append(checkUserExistModel(name: response?.data?.name ?? "", phone: response?.data?.phoneNumber ?? "", isregister: true, guestid: response?.data?.id ?? "", registertype: 1, email:response?.data?.email ?? "" ))
                }
                else {
                    AppUtility.showInfoMessage(message: "lb_warning_user_already_in_list".localized,showTitle: false)
                }
                //                AppUtility.showInfoMessage(message: response?.message ?? "Warning")
            }
            self.lbltotalInvitation.text = "\(checkRegisterUser.count) " + "Invitaciones".localized
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
        userhandler.checkUserExist(phone: freedSpaceString, isphone: isphone, Success: {[self]response in
            self.hidLoader()
            //            if response?.success == true {
            if !(response?.message?.contains("not valid") ?? false){
                if response?.message?.contains("not exists") ?? false {
                    if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone || $0.email == phone}) {
                        self.checkRegisterUser.append(checkUserExistModel(name: name, phone: phone, isregister: false, guestid:"", registertype: 0, email: ""))
                    }
                    
                } else {
                    if self.isFromEvent {
                        
                    }
                    else {
                        if let data = response?.data {
                            ShareData.shareInfo.saveExistUser(existuser: data)
                        }
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
                        
                        
                        
                        ShareData.shareInfo.contactListSaved(isregister: true, name: response?.data?.name ?? "", phoneemail: response?.data?.phoneNumber ?? "", guestid: response?.data?.id ?? "", registertype: 1, email: response?.data?.email ?? "")
                    }
                    
                    
                    if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone || $0.email == phone }) {
                        self.checkRegisterUser.append(checkUserExistModel(name: response?.data?.name ?? "", phone: response?.data?.phoneNumber ?? "", isregister: true, guestid: response?.data?.id ?? "", registertype: 1, email:response?.data?.email ?? "" ))
                    }
                }
                
            }
            else {
                AppUtility.showErrorMessage(message: response?.message ?? "Number not valid")
            }
            self.lbltotalInvitation.text = "\(checkRegisterUser.count) " + "Invitaciones".localized
            self.tblView.reloadData()
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    func updateInvidationUsers() {
        // self.showLoader()
        
        for item in self.checkRegisterUser {
            if item.isregister == true {
                if !self.usersIDsarr.contains(where: {$0 == item.guestid}) {
                    self.usersIDsarr.append(item.guestid)
                }
                
            }
        }
        
        var mainArr = [[String:Any]]()
        for item in 0..<usersIDsarr.count {
            
            mainArr.append(["guest":["id":usersIDsarr[item]],"guestNumber":item])
            //usersIDsarr.append("\(item.guestid)")
            
        }
        
        
        
        let dic : [String:Any] = ["eventId":eventid,"userInvitations":mainArr]
        
        
        
        userhandler.sendInvitation(params: dic, Success: {response in
            self.hidLoader()
            
            if response?.success == true {
                self.colesure!(self.checkRegisterUser)
                AppUtility.showSuccessMessage(message: response?.message ?? "")
                self.navigationController?.popViewController(animated: true)
            } else {
                self.hidLoader()
                AppUtility.showErrorMessage(message: response?.message ?? "Internal Server Error")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    
}

//MARK:- tableview delegate
extension InvitarVC : UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.checkRegisterUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "InvitarCell") as? InvitarCell
        cell?.lblname.text = self.checkRegisterUser[indexPath.row].name
        cell?.lblnumber.text = self.checkRegisterUser[indexPath.row].phoneemail
        if self.checkRegisterUser[indexPath.row].registertype == 0 {
            cell?.indicatorimg.image = UIImage(named:"exclamation-solid")
            
        } else if self.checkRegisterUser[indexPath.row].registertype == 1 {
            cell?.indicatorimg.image = UIImage(named:"chevron-right-solid")
        } else {
            cell?.indicatorimg.image = UIImage(named:"ic-check-2")
        }
        return cell!
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let  off = scrollView.contentOffset.y
        acceptButton.frame = CGRect(x: width, y:   off + height, width: acceptButton.frame.size.width, height: acceptButton.frame.size.height)
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
            let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationDownloadImageAlertVC") as? NotificationDownloadImageAlertVC
            vc?.titlofDialog = "CANCELAR INVITACIÓN".localized
            vc?.detailofDialog = "Deseas cancelar la invitación?".localized
            vc?.acceptbuttontitle = "ACEPTAR".localized
            vc?.modalPresentationStyle = .overFullScreen
            vc?.callBack = { isok in
                
                self.checkRegisterUser.remove(at: indexPath.row)
                self.lbltotalInvitation.text = "\(self.checkRegisterUser.count) " + "Invitaciones".localized
                self.tblView.reloadData()
            }
            
            debugPrint("Delete tapped")
            
            self.present(vc!, animated: false, completion: nil)
        })
        
        deleteAction.image = UIImage(named: "ic-trash-outline")
        deleteAction.backgroundColor = UIColor.red
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let objec = self.checkRegisterUser[indexPath.row]
        
        if objec.registertype == 1 {
            let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"InvitationPOPUpVC") as? InvitationPOPUpVC
            
            vc?.guestid = self.checkRegisterUser[indexPath.row].guestid
            vc?.name = self.checkRegisterUser[indexPath.row].name
            vc?.phone = self.checkRegisterUser[indexPath.row].phoneemail
            
            vc?.callBack = {number in
                for item in 0..<self.checkRegisterUser.count {
                    if self.checkRegisterUser[item].phoneemail == number {
                        self.checkRegisterUser[indexPath.row].registertype = 2
                        self.checkRegisterUser.remove(at: item)
                        break
                    }
                    
                }
                self.lbltotalInvitation.text = "\(self.checkRegisterUser.count) Invitaciones)"
                self.tblView.reloadData()
            }
            
            vc?.modalPresentationStyle = .overFullScreen
            
            self.present(vc!, animated: false, completion: nil)
        } else if objec.registertype == 0 {
            
            let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"UserNotRegisterPopUpVC") as? UserNotRegisterPopUpVC
            vc?.number = self.checkRegisterUser[indexPath.row].phoneemail
            vc?.name = self.checkRegisterUser[indexPath.row].name
            vc?.index = indexPath.row
            vc?.callback = {number, name,index,guestID in
                self.checkRegisterUser[index].isregister = true
                self.checkRegisterUser[index].registertype = 1
                self.checkRegisterUser[index].name = name
                self.checkRegisterUser[index].guestid = guestID
                self.lbltotalInvitation.text = "\(self.checkRegisterUser.count) Invitaciones)"
                self.tblView.reloadData()
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
    
}
extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
