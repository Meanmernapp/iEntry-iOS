//
//  ContactListVC.swift
//  iEntry
//
//  Created by ZAFAR on 20/08/2021.
//

import UIKit
import ContactsUI
import PhoneNumberKit
import CoreTelephony
class ContactListVC: BaseController, UITextFieldDelegate {
    //MARK:- here are the iboutlet
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtsearch: UITextField!
    @IBOutlet weak var lbllistcontracttitle: UILabel!
    
    @IBOutlet weak var lbltotalcontact: UILabel!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var stripview: UIView!
    var contactData = [ContactListModel]()
    var selectedNumberList = [ContactListModel]()
    var filterData =  [ContactListModel]()
    var callBack : ((_ selectedNumberList:[ContactListModel]) -> Void)? = nil
    var finalMobile = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let countryCode = Locale.current.regionCode
        self.lbllistcontracttitle.text = "L I S T A  D E  C O N T A C T O S".localized
        print(countryCode)
        print("country code is \(countryCode)")
        print("country code is1:",getCountryCallingCode(countryRegionCode: countryCode!))
        
        self.tblView.register(UINib.init(nibName: "ContactListCell", bundle: nil), forCellReuseIdentifier: "ContactListCell")
        self.navigationBarHidShow(isTrue: true)
        stripview.roundViiew()
        searchView.shadowAndRoundcorner(cornerRadius: 15, shadowColor: #colorLiteral(red: 0.866572082, green: 0.8667211533, blue: 0.8665626645, alpha: 1), shadowRadius: 3, shadowOpacity: 1)
        innerView.roundCorners([.topRight,.bottomRight], radius: 15)
        txtsearch.delegate = self
        
         
       
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getContactFromCNContact()
    }
    
    //MARK:- this function use to get hte contacts from phone directory
    
    func getContactFromCNContact()  {
        contactData.removeAll()
        showLoader()
        let contactStore = CNContactStore()
            var contacts = [CNContact]()
            let keys = [
                CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                CNContactPhoneNumbersKey,
                CNContactEmailAddressesKey
               
            ] as [Any]
            let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
            do {
                try contactStore.enumerateContacts(with: request) {
                    contact, _ in
                    // Array containing all unified contacts from everywhere
                    contacts.append(contact)
                    for phoneNumber in contact.phoneNumbers {
                        if let number = phoneNumber.value as? CNPhoneNumber, let label = phoneNumber.label {
                            let localizedLabel = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
                            

                            // Get The Name
                            let name = contact.givenName + " " + contact.familyName
                            print(name)

                            // Get The Mobile Number
                            var mobile = number.stringValue
                            mobile = mobile.replacingOccurrences(of: " ", with: "")

                            // Parse The Mobile Number
                            let phoneNumberKit = PhoneNumberKit()

                            do {
                                let phoneNumberCustomDefaultRegion = try phoneNumberKit.parse(mobile, withRegion: "IN", ignoreType: true)
                                let countryCode = String(phoneNumberCustomDefaultRegion.countryCode)
                                let mobile = String(phoneNumberCustomDefaultRegion.nationalNumber)
                                
                                
                                let currentcountryCode = Locale.current.regionCode

                                print(countryCode)
//                                print("country code is \(countryCode)")
//                                print("country code is1:",self.getCountryCallingCode(countryRegionCode: currentcountryCode!))
                                
                                self.finalMobile = "+" + self.getCountryCallingCode(countryRegionCode: currentcountryCode!) + mobile
                                //self.finalMobile = mobile
                                print(self.finalMobile)
                            } catch {
                                print("Generic parser error")
                            }
                            self.contactData.append(ContactListModel(name: name, number: self.finalMobile, isSelected: false))
                            self.filterData =  self.contactData
                            // Get The Email
                            self.lbltotalcontact.text = "Total Contact  \(self.contactData.count)"
                            var email: String
                            for mail in contact.emailAddresses {
                                email = mail.value as String
                                print(email)
                            }
                        }
                    }
                    self.hidLoader()
                    self.tblView.reloadData()
                }

            } catch {
                print("unable to fetch contacts")
            }
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
            self.view.endEditing(true)
            return true
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
        {
            var search = ""
            //search = txt.text!+string
    //        if string.isEmpty
    //        {
    //            search = txtsearch.text!
    //        }
    //        else
    //        {
    //            search = txtsearch.text!+string
    //        }
    
            print(search)
            self.filterData = self.contactData.filter({(($0.number)?.localizedCaseInsensitiveContains(txtsearch.text!))!})
    
                        self.tblView.reloadData()
    
    
        if self.filterData.count > 0 {
    
            //self.filterData = self.checkRegisterUser
            }
            else
            {
                self.filterData = self.contactData
            }
        self.tblView.reloadData()
            return true
        }
        
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.filterData = self.contactData.filter({ ($0.number?.hasPrefix(txtsearch.text!))! })
    
                self.tblView.reloadData()
        }
    
        func textFieldDidBeginEditing(_ textField: UITextField) {
            self.filterData = self.contactData.filter({ ($0.number?.hasPrefix(txtsearch.text!))! })
    
                self.tblView.reloadData()
        }
    
        func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            self.filterData = self.contactData.filter({ ($0.number?.hasPrefix(txtsearch.text!))! })
    
                self.tblView.reloadData()
        }
        
    
    
    
    
    
    
    
    @IBAction func stripAction(_ sender: UIButton) {
        self.selectedNumberList.removeAll()
        for item in filterData {
            if item.isSelected ==  true {
                self.selectedNumberList.append(ContactListModel(name: item.name, number: item.number, isSelected: item.isSelected))
            }
        }
        callBack?(selectedNumberList)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
//MARK:- tableview delegates
extension ContactListVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "ContactListCell") as? ContactListCell
        cell?.lblname.text = filterData[indexPath.row].name
        cell?.lblnumber.text = filterData[indexPath.row].number
        
        if filterData[indexPath.row].isSelected == false {
            
            cell?.checkBoximg.image = UIImage(named: "checkbox-outline")
            } else {
                
                cell?.checkBoximg.image = UIImage(named: "ic-check-2")
            }
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        for item in 0...contactData.count - 1 {
//
//            contactData[item].isSelected = false
//
//        }
        if filterData[indexPath.row].isSelected! {
            filterData[indexPath.row].isSelected = false
        } else {
            filterData[indexPath.row].isSelected = true
        }
        
        self.tblView.reloadData()
        
    }
    
}
