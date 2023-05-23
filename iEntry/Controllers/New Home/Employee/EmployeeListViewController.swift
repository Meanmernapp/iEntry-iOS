//
//  EmployeeListViewController.swift
//  iEntry
//
//  Created by HaiDer's Macbook Pro on 16/01/2023.
//

import UIKit

class EmployeeListViewController: BaseController,UITextFieldDelegate {
    
    
    //MARK: - IBOutlets

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchButtonView: UIView!
    @IBOutlet weak var noEmployeeView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var hiddenTitle: UILabel!
    
    
    //MARK: - Variables
    
    let count = 15
    var employeeData : [EmployeeUserDetailsData]?
    var employeeFilterData : [EmployeeUserDetailsData]?
    var contractorId = ShareData.shareInfo.contractorListdataValueGetByUserid?.id ?? ""
    var providerId = ShareData.shareInfo.contractorListdataValueGetByUserid?.id ?? ""
    var searching = false
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var titleLbl: UILabel!
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        searchView.shadowAndRoundcorner(cornerRadius: Float(searchView.layer.frame.height) / 2, shadowColor: #colorLiteral(red: 0.8430451751, green: 0.843190372, blue: 0.843035996, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1)
        searchButtonView.roundCorners([.topRight,.bottomRight], radius: 25)
        searchText.delegate = self
        hiddenTitle.text = "lb_no_data_employees".localized
        self.searchText.placeholder = "Escribe un nombre a buscar ...".localized
        self.titleLbl.text = "EMPLEADOS".localized
        if Network.isAvailable {
            if ShareData.shareInfo.userRole == .provider {
                getProviderApi()
            }
            else if ShareData.shareInfo.userRole == .contractor {
                getcontractorApi()
            }
        }
        else {
            self.employeeData = ShareData.shareInfo.employeeeDataVC
            self.totalLbl.text = "Total".localized + " : " + "\(self.employeeData?.count ?? 0)"
            if self.employeeData?.count == 0 {
                self.noEmployeeView.isHidden = false
            }
            else {
                self.noEmployeeView.isHidden = true
            }
            
            self.tableView.reloadData()
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    //MARK: - IBAction
    
    
    @IBAction func menuAction(_ sender: Any) {
        let manager = ZSideMenuManager(isRTL: false)
        manager.openSideMenu(vc: self)
    }
    
    
    //MARK: - Functions
    
    func hideShow() {
        if count == 0 {
            self.noEmployeeView.isHidden = false
        }
        else {
            self.noEmployeeView.isHidden = true
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        refreshControl.endRefreshing()
        if Network.isAvailable {
            self.fetchData()
        }
       
    }
    
    func fetchData() {
        if ShareData.shareInfo.userRole == .provider {
            self.showLoader()
            print(providerId)
            userhandler.getProviderEmployeeData(userid: providerId) { result in
                self.hidLoader()
                AppUtility.showSuccessMessage(message: "lb_success_get_employees".localized)
                print(result?.data?.count ?? 0)
                self.employeeData = result?.data
                ShareData.shareInfo.employeeeDataVC = result?.data
                self.totalLbl.text = "Total".localized + " : " + "\(result?.data?.count ?? 0)"
                if result?.data?.count == 0 {
                    self.noEmployeeView.isHidden = false
                }
                else {
                    self.noEmployeeView.isHidden = true
                }
                
                self.tableView.reloadData()
            } Failure: { error in
                self.hidLoader()
                print(error)
            }
        }
        else if ShareData.shareInfo.userRole == .contractor {
            self.showLoader()
            print(contractorId)
            userhandler.getContractorEmployeeData(userid: contractorId) { result in
                self.hidLoader()
                AppUtility.showSuccessMessage(message: "lb_success_get_employees".localized)
                print(result?.data?.count ?? 0)
                self.employeeData = result?.data
                ShareData.shareInfo.employeeeDataVC = result?.data
                self.totalLbl.text = "Total".localized + " : " + "\(result?.data?.count ?? 0)"
                if result?.data?.count == 0 {
                    self.noEmployeeView.isHidden = false
                }
                else {
                    self.noEmployeeView.isHidden = true
                }
                self.tableView.reloadData()
            } Failure: { error in
                self.hidLoader()
                print(error)
            }
        }
        
        
    }
    
    func getProviderApi() {
        
        self.showLoader()
        userhandler.getProviderByUserIDs(userid: ShareData.shareInfo.obj?.id ?? "", Success: { response in
            self.hidLoader()
            if response?.success == true {
                ShareData.shareInfo.saveContractorListGetByUserid(contractor: (response?.data)!)
                self.providerId = response?.data?.id ?? ""
                self.fetchData()
            } else {
                
            }
        }, Failure: {error in
            self.hidLoader()
        })
    }
    
    func getcontractorApi(){
        self.showLoader()
        userhandler.getContractorByUserIDs(userid: ShareData.shareInfo.obj?.id ?? "", Success: { response in
            self.hidLoader()
            if response?.success == true {
                ShareData.shareInfo.saveContractorListGetByUserid(contractor: (response?.data)!)
                self.contractorId = response?.data?.id ?? ""
                self.fetchData()
            } else {
                
            }
        }, Failure: {error in
            self.hidLoader()
        })
    }
    
    //MARK: - Searching
    
    internal func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField == searchText {
            
            if textField.text == "" {
                self.searching = false
            }
            else {
                if let data = employeeData {
                    self.searching = true
                    self.employeeFilterData = data.filter { item in
                        if let name = item.name?.lowercased(), let number = item.phoneNumber?.lowercased() {
                            if name.contains(textField.text!.lowercased()) {
                                return true
                            }
                            if number.contains(textField.text!.lowercased()) {
                                return true
                            }
                            return false
                        }
                        
                        return false
                    }
                }
                else {
                    self.searching = false
                }
                
            }
            if searching {
                if employeeFilterData?.count == 0 {
                    self.noEmployeeView.isHidden = false
                }
                else {
                    self.noEmployeeView.isHidden = true
                }
                self.totalLbl.text = "Total".localized + " : " + "\(employeeFilterData?.count ?? 0)"
            }
            else {
                if employeeData?.count == 0 {
                    self.noEmployeeView.isHidden = false
                }
                else {
                    self.noEmployeeView.isHidden = true
                }
                self.totalLbl.text = "Total".localized + " : " + "\(employeeData?.count ?? 0)"
            }
            
            self.tableView.reloadData()
        }
        
    }
    
    @objc func btnPressed(_ sender:UIButton) {
        let vc = EmployeeDetailViewController(nibName: "EmployeeDetailViewController", bundle: nil)
        if searching {
            vc.data = self.employeeFilterData?[sender.tag]
        }
        else {
            vc.data = self.employeeData?[sender.tag]
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension EmployeeListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return employeeFilterData?.count ?? 0
            
        }
        else {
            return employeeData?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.register(EmployeeTableViewCell.self, indexPath: indexPath)
        if searching {
            cell.config(data: self.employeeFilterData?[indexPath.row])
        }
        else {
            cell.config(data: self.employeeData?[indexPath.row])
        }
        cell.nextBtn.tag = indexPath.row
        cell.nextBtn.addTarget(self, action: #selector(btnPressed(_:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


