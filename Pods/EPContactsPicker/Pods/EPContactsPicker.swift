//
//  EPContactsPicker.swift
//  EPContacts
//
//  Created by Prabaharan Elangovan on 12/10/15.
//  Copyright © 2015 Prabaharan Elangovan. All rights reserved.
//

import UIKit
import Contacts


public protocol EPPickerDelegate: AnyObject {
	func epContactPicker(_: EPContactsPicker, didContactFetchFailed error: NSError)
    func epContactPicker(_: EPContactsPicker, didCancel error: NSError)
    func epContactPicker(_: EPContactsPicker, didSelectContact contact: EPContact)
	func epContactPicker(_: EPContactsPicker, didSelectMultipleContacts contacts: [EPContact])
}

public extension EPPickerDelegate {
	func epContactPicker(_: EPContactsPicker, didContactFetchFailed error: NSError) { }
	func epContactPicker(_: EPContactsPicker, didCancel error: NSError) { }
	func epContactPicker(_: EPContactsPicker, didSelectContact contact: EPContact) { }
	func epContactPicker(_: EPContactsPicker, didSelectMultipleContacts contacts: [EPContact]) { }
}

typealias ContactsHandler = (_ contacts : [CNContact] , _ error : NSError?) -> Void

public enum SubtitleCellValue{
    case phoneNumber
    case email
    case birthday
    case organization
}

open class EPContactsPicker: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    // MARK: - Properties
    
    open weak var contactDelegate: EPPickerDelegate?
    var contactsStore: CNContactStore?
    var resultSearchController = UISearchController()
    var orderedContacts = [String: [CNContact]]() //Contacts ordered in dicitonary alphabetically
    var sortedContactKeys = [String]()
    let crossBtn = UIButton()
    let acceptButton = UIButton()
    var selectedContacts = [EPContact]()
    var filteredContacts = [CNContact]()
    let width = UIScreen.main.bounds.size.width - 200
    let height = UIScreen.main.bounds.size.height - 150
    var subtitleCellValue = SubtitleCellValue.phoneNumber
    var multiSelectEnabled: Bool = false //Default is single selection contact
    
    // MARK: - Lifecycle Methods
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.acceptButton.frame = CGRect(x: width, y: height, width: 180, height: 50)
        self.acceptButton.clipsToBounds = true
        self.acceptButton.setImage(UIImage(named: "Accept")!, for: .normal)
        if #available(iOS 11.0, *) {
            self.acceptButton.backgroundColor = UIColor(named: "primary")
        } else {
            // Fallback on earlier versions
        }
        self.acceptButton.layer.cornerRadius = 24
        registerContactCell()
        inititlizeBarButtons()
        initializeSearchBar()
        reloadContacts()
        self.tableView.separatorStyle = .none
        self.view.addSubview(acceptButton)
        self.view.bringSubviewToFront(acceptButton)
    }
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    func initializeSearchBar() {
        self.resultSearchController = ( {
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.hidesNavigationBarDuringPresentation = false
            controller.searchBar.frame = CGRect(x: 10, y: 50, width: UIScreen.main.bounds.size.width, height: 60)
            controller.searchBar.delegate = self
            
            self.tableView.tableHeaderView = controller.searchBar
            controller.searchBar.placeholder = "Escribe un nombre a buscar ..."
            return controller
        })()
    }
    @objc func pressed() {
        dismiss(animated: true, completion: {
            self.contactDelegate?.epContactPicker(self, didSelectMultipleContacts: self.selectedContacts)
        })
    }
    func inititlizeBarButtons() {
        let image =  UIImage(named: "ic-cancel")
        if #available(iOS 13.0, *) {
            image?.withTintColor(.red)
        } else {
        }
        let doneButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(onTouchDoneButton))
        self.acceptButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barStyle = .default
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "primary")!]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "primary")!]
            UINavigationBar.appearance().tintColor = .red
            navigationItem.standardAppearance = appearance
            navigationItem.scrollEdgeAppearance = appearance
            navigationItem.rightBarButtonItem?.tintColor = .red
        }
        self.title = "L I S T A  D E  C O N T A C T O S"
    }
    
    fileprivate func registerContactCell() {
        
        let podBundle = Bundle(for: self.classForCoder)
        if let bundleURL = podBundle.url(forResource: EPGlobalConstants.Strings.bundleIdentifier, withExtension: "bundle") {
            
            if let bundle = Bundle(url: bundleURL) {
                
                let cellNib = UINib(nibName: EPGlobalConstants.Strings.cellNibIdentifier, bundle: bundle)
                tableView.register(cellNib, forCellReuseIdentifier: "Cell")
            }
            else {
                assertionFailure("Could not load bundle")
            }
        }
        else {
            
            let cellNib = UINib(nibName: EPGlobalConstants.Strings.cellNibIdentifier, bundle: nil)
            tableView.register(cellNib, forCellReuseIdentifier: "Cell")
        }
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Initializers
  
    convenience public init(delegate: EPPickerDelegate?) {
        self.init(delegate: delegate, multiSelection: false)
    }
    
    convenience public init(delegate: EPPickerDelegate?, multiSelection : Bool) {
        self.init(style: .plain)
        self.multiSelectEnabled = multiSelection
        contactDelegate = delegate
    }

    convenience public init(delegate: EPPickerDelegate?, multiSelection : Bool, subtitleCellType: SubtitleCellValue) {
        self.init(style: .plain)
        self.multiSelectEnabled = multiSelection
        contactDelegate = delegate
        subtitleCellValue = subtitleCellType
    }
    
    
    // MARK: - Contact Operations
  
      open func reloadContacts() {
        getContacts( {(contacts, error) in
            if (error == nil) {
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        })
      }
  
    func getContacts(_ completion:  @escaping ContactsHandler) {
        if contactsStore == nil {
            //ContactStore is control for accessing the Contacts
            contactsStore = CNContactStore()
        }
        let error = NSError(domain: "EPContactPickerErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "No Contacts Access"])
        
        switch CNContactStore.authorizationStatus(for: CNEntityType.contacts) {
            case CNAuthorizationStatus.denied, CNAuthorizationStatus.restricted:
                //User has denied the current app to access the contacts.
                
                let productName = Bundle.main.infoDictionary!["CFBundleName"]!
                
            let alert = UIAlertController(title: "Unable to access contacts", message: "\(productName) does not have access to contacts. Kindly enable it in privacy settings ", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {  action in
                    completion([], error)
                    self.dismiss(animated: true, completion: {
                        self.contactDelegate?.epContactPicker(self, didContactFetchFailed: error)
                    })
                })
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            
            case CNAuthorizationStatus.notDetermined:
                //This case means the user is prompted for the first time for allowing contacts
                contactsStore?.requestAccess(for: CNEntityType.contacts, completionHandler: { (granted, error) -> Void in
                    //At this point an alert is provided to the user to provide access to contacts. This will get invoked if a user responds to the alert
                    if  (!granted ){
                        DispatchQueue.main.async(execute: { () -> Void in
                            completion([], error! as NSError?)
                        })
                    }
                    else{
                        self.getContacts(completion)
                    }
                })
            
            case  CNAuthorizationStatus.authorized:
                //Authorization granted by user for this app.
                var contactsArray = [CNContact]()
                
                let contactFetchRequest = CNContactFetchRequest(keysToFetch: allowedContactKeys())
                
                do {
                    try contactsStore?.enumerateContacts(with: contactFetchRequest, usingBlock: { (contact, stop) -> Void in
                        //Ordering contacts based on alphabets in firstname
                        contactsArray.append(contact)
                        var key: String = "#"
                        //If ordering has to be happening via family name change it here.
                        if let firstLetter = contact.givenName[0..<1] , firstLetter.containsAlphabets() {
                            key = firstLetter.uppercased()
                        }
                        var contacts = [CNContact]()
                        
                        if let segregatedContact = self.orderedContacts[key] {
                            contacts = segregatedContact
                        }
                        contacts.append(contact)
                        self.orderedContacts[key] = contacts

                    })
                    self.sortedContactKeys = Array(self.orderedContacts.keys).sorted(by: <)
                    if self.sortedContactKeys.first == "#" {
                        self.sortedContactKeys.removeFirst()
                        self.sortedContactKeys.append("#")
                    }
                    completion(contactsArray, nil)
                }
                //Catching exception as enumerateContactsWithFetchRequest can throw errors
                catch let error as NSError {
                    print(error.localizedDescription)
                }
            
        @unknown default:
            fatalError()
        }
    }
    
    func allowedContactKeys() -> [CNKeyDescriptor]{
        //We have to provide only the keys which we have to access. We should avoid unnecessary keys when fetching the contact. Reducing the keys means faster the access.
        return [CNContactNamePrefixKey as CNKeyDescriptor,
            CNContactGivenNameKey as CNKeyDescriptor,
            CNContactFamilyNameKey as CNKeyDescriptor,
            CNContactOrganizationNameKey as CNKeyDescriptor,
            CNContactBirthdayKey as CNKeyDescriptor,
            CNContactImageDataKey as CNKeyDescriptor,
            CNContactThumbnailImageDataKey as CNKeyDescriptor,
            CNContactImageDataAvailableKey as CNKeyDescriptor,
            CNContactPhoneNumbersKey as CNKeyDescriptor,
            CNContactEmailAddressesKey as CNKeyDescriptor,
        ]
    }
    @objc func checkMarkButton(_ sender:UIButton) {
        
    }
    
    // MARK: - Table View DataSource
    
    override open func numberOfSections(in tableView: UITableView) -> Int {
        if resultSearchController.isActive { return 1 }
        return sortedContactKeys.count
    }
    
    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultSearchController.isActive { return filteredContacts.count }
        if let contactsForSection = orderedContacts[sortedContactKeys[section]] {
            return contactsForSection.count
        }
        return 0
    }

    // MARK: - Table View Delegates

    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EPContactCell
//        cell.accessoryType = UITableViewCell.AccessoryType.none
        //Convert CNContact to EPContact
		let contact: EPContact
        
        if resultSearchController.isActive {
            contact = EPContact(contact: filteredContacts[(indexPath as NSIndexPath).row])
        } else {
			guard let contactsForSection = orderedContacts[sortedContactKeys[(indexPath as NSIndexPath).section]] else {
				assertionFailure()
				return UITableViewCell()
			}

			contact = EPContact(contact: contactsForSection[(indexPath as NSIndexPath).row])
        }
		
        if multiSelectEnabled  && selectedContacts.contains(where: { $0.contactId == contact.contactId }) {
            cell.checkButton.isSelected = true
        }
		
        cell.updateContactsinUI(contact, indexPath: indexPath, subtitleType: subtitleCellValue)
        return cell
    }
    
    override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! EPContactCell
        let selectedContact =  cell.contact!
        cell.checkButton.addTarget(self, action: #selector(checkMarkButton(_:)), for: .touchUpInside)
        if multiSelectEnabled {
            //Keeps track of enableing and disabling contacts
            
            if cell.checkButton.isSelected {
                cell.checkButton.isSelected = false
                selectedContacts = selectedContacts.filter(){
                    return selectedContact.contactId != $0.contactId
                }
            }
            else {
                cell.checkButton.isSelected = true
                selectedContacts.append(selectedContact)
            }
        }
        else {
            //Single selection code
			resultSearchController.isActive = false
			self.dismiss(animated: true, completion: {
				DispatchQueue.main.async {
					self.contactDelegate?.epContactPicker(self, didSelectContact: selectedContact)
				}
			})
        }
    }
    
    override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    override open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let  off = scrollView.contentOffset.y
        acceptButton.frame = CGRect(x: width, y:   off + height, width: acceptButton.frame.size.width, height: acceptButton.frame.size.height)
        
    }
    override open func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        if resultSearchController.isActive { return 0 }
        tableView.scrollToRow(at: IndexPath(row: 0, section: index), at: UITableView.ScrollPosition.top , animated: false)
        return sortedContactKeys.firstIndex(of: title)!
    }
    
    override  open func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if resultSearchController.isActive { return nil }
        return sortedContactKeys
    }
    
    open override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if resultSearchController.isActive { return nil }
        let view = UIView()
        let label = UILabel()
        let line = UIView()
        line.frame = CGRect(x: 25, y: 10, width: tableView.frame.width-50, height: 2)
        if #available(iOS 11.0, *) {
            line.backgroundColor = UIColor(named: "primary")
        } else {
            line.backgroundColor = .systemGreen
        }
        line.layer.cornerRadius = 1
        label.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        label.textColor = .black
        label.text = sortedContactKeys[section]
        if #available(iOS 11.0, *) {
            label.textColor = UIColor(named: "primary")
        } else {
            label.textColor = .systemGreen
        }
        view.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 15)
        view.addSubview(label)
        view.addSubview(line)
        return view
        
    }
    open override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }
    
    // MARK: - Button Actions
    
    @objc func onTouchCancelButton() {
        dismiss(animated: true, completion: {
            self.contactDelegate?.epContactPicker(self, didCancel: NSError(domain: "EPContactPickerErrorDomain", code: 2, userInfo: [ NSLocalizedDescriptionKey: "User Canceled Selection"]))
        })
    }
    
    @objc func onTouchDoneButton() {
//        self.navigationController
        dismiss(animated: true, completion: {
//            self.contactDelegate?.epContactPicker(self, didSelectMultipleContacts: self.selectedContacts)
        })
    }
    
    // MARK: - Search Actions
    
    open func updateSearchResults(for searchController: UISearchController)
    {
        if let searchText = resultSearchController.searchBar.text , searchController.isActive {
            
            let predicate: NSPredicate
            if searchText.count > 0 {
                predicate = CNContact.predicateForContacts(matchingName: searchText)
            } else {
                predicate = CNContact.predicateForContactsInContainer(withIdentifier: contactsStore!.defaultContainerIdentifier())
            }
            
            let store = CNContactStore()
            do {
                filteredContacts = try store.unifiedContacts(matching: predicate,
                    keysToFetch: allowedContactKeys())
                //print("\(filteredContacts.count) count")
                
                self.tableView.reloadData()
                
            }
            catch {
                print("Error!")
            }
        }
    }
    
    open func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
    }
    
}
