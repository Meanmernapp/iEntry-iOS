//
//  VehicalViewController.swift
//  iEntry
//
//  Created by HaiDer's Macbook Pro on 16/01/2023.
//

import UIKit

class VehicalViewController: BaseController,UITextFieldDelegate {
    
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sidemenuButton: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchButtonView: UIView!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var noVehicleView: UIView!
    @IBOutlet weak var noVehicleLbl: UILabel!
    
    
    //MARK: - Variables
    
    var vehicalData : [VehicalModelData]?
    var filterData : [VehicalModelData]?
    var contractorId = ShareData.shareInfo.contractorListdataValueGetByUserid?.id ?? ""
    var providerId = ShareData.shareInfo.contractorListdataValueGetByUserid?.id ?? ""
    var searching = false
    let refreshControl = UIRefreshControl()
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        searchView.shadowAndRoundcorner(cornerRadius: Float(searchView.layer.frame.height) / 2, shadowColor: #colorLiteral(red: 0.8430451751, green: 0.843190372, blue: 0.843035996, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1)
        searchButtonView.roundCorners([.topRight,.bottomRight], radius: 25)
        if Network.isAvailable {
            if ShareData.shareInfo.userRole == .provider {
                getProviderApi()
            }
            else if ShareData.shareInfo.userRole == .contractor {
                getcontractorApi()
            }
            
        }
        else {
            self.vehicalData = ShareData.shareInfo.vehicleeDataVC
            self.totalLbl.text = "Total".localized + " : " + "\(self.vehicalData?.count ?? 0)"
            if self.vehicalData?.count == 0 {
                self.noVehicleView.isHidden = false
            }
            else {
                self.noVehicleView.isHidden = true
            }
            self.tableView.reloadData()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func searchAction(_ sender: Any) {
        if searchText.text == "" {
            searching = false
        }
        else {
            searching = true
        }
        self.tableView.reloadData()
    }
    
    internal func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField == searchText {
            
            if textField.text == "" {
                self.searching = false
            }
            else {
                if let data = vehicalData {
                    self.searching = true
                    self.filterData = data.filter { item in
                        if let brand = item.brand?.lowercased(), let subBrand = item.subBrand?.lowercased() {
                            if brand.contains(textField.text!.lowercased()) {
                                return true
                            }
                            if subBrand.contains(textField.text!.lowercased()) {
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
                if filterData?.count == 0 {
                    self.noVehicleView.isHidden = false
                }
                else {
                    self.noVehicleView.isHidden = true
                }
                self.totalLbl.text = "Total".localized + " : " + "\(filterData?.count ?? 0)"
            }
            else {
                if vehicalData?.count == 0 {
                    self.noVehicleView.isHidden = false
                }
                else {
                    self.noVehicleView.isHidden = true
                }
                self.totalLbl.text = "Total".localized + " : " + "\(vehicalData?.count ?? 0)"
            }
            
            self.tableView.reloadData()
        }
        
    }
    
    
    //MARK: - Functions
    
    
    func setup() {
        self.searchText.delegate = self
        self.searchText.placeholder = "Busca por Marca/Sub-Marca".localized
        self.titleLbl.text = "VEHÍCULOS".localized
        self.noVehicleLbl.text = "lb_no_data_vehicles".localized
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        refreshControl.endRefreshing()
        if Network.isAvailable {
            self.fetchData()
            
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
    
    func fetchData() {
        if ShareData.shareInfo.userRole == .provider {
            self.showLoader()
            print(providerId)
            userhandler.getProviderVehiclesByUserIDs(userid: providerId) { result in
                self.hidLoader()
                AppUtility.showSuccessMessage(message: "lb_success_get_vehicles".localized)
                print(result?.data?.count ?? 0)
                self.vehicalData = result?.data
                ShareData.shareInfo.vehicleeDataVC = result?.data
                self.totalLbl.text = "Total : \(result?.data?.count ?? 0)"
                if result?.data?.count == 0 {
                    self.noVehicleView.isHidden = false
                }
                else {
                    self.noVehicleView.isHidden = true
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
            userhandler.getContractorVehiclesByUserIDs(userid: contractorId) { result in
                self.hidLoader()
                AppUtility.showSuccessMessage(message: "lb_success_get_vehicles".localized)
                print(result?.data?.count ?? 0)
                self.vehicalData = result?.data
                ShareData.shareInfo.vehicleeDataVC = result?.data
                self.totalLbl.text = "Total".localized + " : " + "\(result?.data?.count ?? 0)"
                if result?.data?.count == 0 {
                    self.noVehicleView.isHidden = false
                }
                else {
                    self.noVehicleView.isHidden = true
                }
                self.tableView.reloadData()
            } Failure: { error in
                self.hidLoader()
                print(error)
            }
        }
        
        
    }
    @IBAction func sideMenuAction(_ sender: Any) {
        let manager = ZSideMenuManager(isRTL: false)
        manager.openSideMenu(vc: self)
    }
    
    @objc func btnPressed(_ sender:UIButton) {
        let vc = VehicalDataViewController(nibName: "VehicalDataViewController", bundle: nil)
        if searching {
            vc.data = self.filterData?[sender.tag]
        }
        else {
            vc.data = self.vehicalData?[sender.tag]
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension VehicalViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filterData?.count ?? 0
            
        }
        else {
            return vehicalData?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.register(VehicalTableViewCell.self, indexPath: indexPath)
        if searching {
            cell.config(data: self.filterData?[indexPath.row])
        }
        else {
            cell.config(data: self.vehicalData?[indexPath.row])
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


