//
//  HolidaysViewController.swift
//  iEntry
//
//  Created by HaiDeR AwAn on 07/04/2023.
//


import UIKit

class HolidaysViewController: BaseController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var buttonView: UIView!
    
    //MARK: - Custom Swipe
    
    @IBOutlet weak var validationMainView: UIView!
    @IBOutlet weak var historyMainView: UIView!
    
    //MARK: - validation
    
    @IBOutlet weak var validationView: UIView!
    @IBOutlet weak var validationTitle: UILabel!
    
    //MARK: - history
    
    @IBOutlet weak var historyTitle: UILabel!
    @IBOutlet weak var historyView: UIView!
    
    //MARK: - Bottom Views
    
    @IBOutlet weak var inerView: UIView!
    
    //MARK: - CharView
    
    @IBOutlet weak var progress1: CircularProgressView!
    @IBOutlet weak var progress4: CircularProgressView!
    @IBOutlet weak var progress3: CircularProgressView!
    @IBOutlet weak var progress2: CircularProgressView!
    @IBOutlet weak var progressPercentage: UILabel!
    
    //MARK: - Values
    @IBOutlet weak var availableValue: UILabel!
    @IBOutlet weak var requestedValue: UILabel!
    @IBOutlet weak var usedValue: UILabel!
    @IBOutlet weak var totalsValue: UILabel!
    //MARK: - Titles
    @IBOutlet weak var availableLbl: UILabel!
    @IBOutlet weak var requestedLbl: UILabel!
    @IBOutlet weak var usedLbl: UILabel!
    @IBOutlet weak var totalsLbl: UILabel!
    
    @IBOutlet weak var EMPTYLBL: UILabel!
    @IBOutlet weak var periodTitle: UILabel!
    
    @IBOutlet weak var emptyView: UIView!
    //MARK: - Variables
    
    var isHistory = false
    var holidayModel : HolidayModelData?
    let refreshControl = UIRefreshControl()
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        setupView()
        if Network.isAvailable {
            getHolidayApi(id:ShareData.shareInfo.obj?.id ?? "")
            
        }
        else {
            if let data = ShareData.shareInfo.holidayDataOffline {
                self.holidayModel = data
                self.setupUI()
                self.updateChartData()
                self.tableView.reloadData()
            }
            AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
        }
    }
    
    @IBAction func menuAc(_ sender: Any) {
        let manager = ZSideMenuManager(isRTL: false)
        manager.openSideMenu(vc: self)
    }
    
    
    
    @IBAction func addHolidayAction(_ sender: Any) {
        if Network.isAvailable {
            let vc  = AddHolidayViewController(nibName: "AddHolidayViewController", bundle: nil)
            vc.mainModel = self.holidayModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
        }
    }
    
    //MARK: -  Functions
    
    @objc func refresh(_ sender: AnyObject) {
        refreshControl.endRefreshing()
        if Network.isAvailable {
            self.getHolidayApi(id:ShareData.shareInfo.obj?.id ?? "")
            
        }
        else {
            self.holidayModel = ShareData.shareInfo.holidayDataOffline
            self.setupUI()
            self.updateChartData()
            self.tableView.reloadData()
            AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
        }
    }
    
    
    func setupView() {
        
        titleLbl.text = "V A C A C I O N E S".localized
        historyTitle.text = "HISTORIAL".localized
        validationTitle.text = "lb_tab_in_validation".localized
        titleLbl.textColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
        EMPTYLBL.text = "NO HAY HISTORIAL DE SOLICITUDES".localized
        EMPTYLBL.font = UIFont(name: "Montserrat-Bold", size: 16)
        titleLbl.font = UIFont(name: "Montserrat-Bold", size: 20)
        self.view.bringSubviewToFront(bottomView)
        self.buttonView.roundViiew()
        self.inerView.roundViiew()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        //MARK: - Tap Function
        
        let validationTap = UITapGestureRecognizer(target: self, action: #selector(self.validationTap(_:)))
        self.validationMainView.isUserInteractionEnabled = true
        self.validationMainView.addGestureRecognizer(validationTap)
        let historyTap = UITapGestureRecognizer(target: self, action: #selector(self.historyTap(_:)))
        self.historyMainView.isUserInteractionEnabled = true
        self.historyMainView.addGestureRecognizer(historyTap)
        
    }
    
    @objc func validationTap(_ sender: UITapGestureRecognizer) {
        isHistory = false
        tableView.reloadData()
        validationView.backgroundColor = UIColor(named: "primary")
        validationTitle.textColor = UIColor(named: "primary")
        historyTitle.textColor = UIColor(named: "lightColor")
        historyView.backgroundColor = .clear
    }
    
    @objc func historyTap(_ sender: UITapGestureRecognizer) {
        isHistory = true
        tableView.reloadData()
        validationView.backgroundColor = .clear
        validationTitle.textColor = UIColor(named: "lightColor")
        historyTitle.textColor = UIColor(named: "primary")
        historyView.backgroundColor = UIColor(named: "primary")
    }
    
    func updateChartData(){
        
        //MARK: - total
        
        progress4.setprogress(1.0, UIColor(hexString: "#707070"), "", "")
        
        //MARK: - Used
        let percentageUsed  = Double(self.holidayModel?.spent ?? 0) / Double(self.holidayModel?.total ?? 0)
        progress3.setprogress(Double(percentageUsed), UIColor(hexString: "#BC0000"), "", "")
        

        //MARK: - available
        let percentageAvailable  = Double(self.holidayModel?.available ?? 0) / Double(self.holidayModel?.total ?? 0)
        progress1.setprogress(Double(percentageAvailable+percentageUsed), UIColor(hexString: "#146F62"), "", "")
        
        //MARK: - requested
        let percentageRequested  = Double(self.holidayModel?.requested ?? 0) / Double(self.holidayModel?.total ?? 0)
        progress2.setprogress(Double(percentageRequested+percentageAvailable+percentageUsed), UIColor(hexString: "#F2A100"), "", "")
        
        
    }
    
    @objc func btnTap(_ sender:UIButton) {
        let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"HolidayPopUpViewController") as? HolidayPopUpViewController
        vc?.mainModel = self.holidayModel
        if self.isHistory {
            vc?.isRecord = self.isHistory
            vc?.recordModel = self.holidayModel?.records?[sender.tag]
        }
        else {
            vc?.isRecord = self.isHistory
            vc?.inValidModel = self.holidayModel?.inValidation?[sender.tag]
        }
        
        vc?.callBack = { cancelID in
            self.cancelAction(id: cancelID)
        }
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    
    func cancelAction(id:String) {
        let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"AcceptORRejectionPopUpVC") as? AcceptORRejectionPopUpVC
        vc?.isFromCancelHoliday = true
        vc?.callBack = {
            self.cancelHolidayApi(id: id)
        }
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
        
    }
    
    func cancelHolidayApi(id:String) {
        if Network.isAvailable {
            userhandler.cancelHoliday(holidayID: id) { response in
                self.hidLoader()
                if response?.success == true  {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                else {
                    self.hidLoader()
                    AppUtility.showErrorMessage(message: response?.message ?? "")
                }
            } Failure: {error in
                self.hidLoader()
                AppUtility.showErrorMessage(message: error.message)
            }
        }
        else {
            AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
        }
        
        
    }
    
    func getHolidayApi(id:String) {
        self.showLoader()
        userhandler.getHolidaysByID(userid: id) { response in
            self.hidLoader()
            if response?.success == true  {
                ShareData.shareInfo.holidayDataOffline = response?.data
                self.holidayModel = response?.data
                DispatchQueue.main.async {
                    self.setupUI()
                    self.updateChartData()
                    self.tableView.reloadData()
                }
            }
            else {
                self.hidLoader()
                AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
            }
        } Failure: {error in
            self.hidLoader()
            AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
        }
        
    }
    
    func setupUI() {
        
        //MARK: - Title
        
        self.periodTitle.text = "PERIOD ".localized +  "\(self.holidayModel?.from?.getDateStringFromUTC() ?? "") - \(self.holidayModel?.to?.getDateStringFromUTC() ?? "")"
        
        Global.shared.periodTo = self.holidayModel?.to
        Global.shared.periodFrom = self.holidayModel?.from
        //MARK: - Values
        
        self.availableValue.text = "\(self.holidayModel?.available ?? 0)"
        self.requestedValue.text = "\(self.holidayModel?.requested ?? 0)"
        self.usedValue.text = "\(self.holidayModel?.spent ?? 0)"
        self.totalsValue.text = "\(self.holidayModel?.total ?? 0)"
        
        //MARK: - Lbl
        
        self.availableLbl.text = "DISPONIBLES".localized
        self.requestedLbl.text = "SOLICITADOS".localized
        self.usedLbl.text = "USADOS".localized
        self.totalsLbl.text = "TOTALES".localized
        
        let percentage  = Double(self.holidayModel?.available ?? 0) / Double(self.holidayModel?.total ?? 0) * 100
        self.progressPercentage.text = "\(Int(percentage))%"
        
    }
    
    func setupEmpty() {
        if isHistory {
            if self.holidayModel?.records?.count == 0 {
                emptyView.isHidden = false
                tableView.isHidden = false
            }
            else {
                emptyView.isHidden = true
                tableView.isHidden = false
            }
        }
        else {
            if self.holidayModel?.inValidation?.count == 0 {
                emptyView.isHidden = false
                tableView.isHidden = false
            }
            else {
                emptyView.isHidden = true
                tableView.isHidden = false
            }
        }
    }
}

extension HolidaysViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.setupEmpty()
        return isHistory ? self.holidayModel?.records?.count ?? 0 : self.holidayModel?.inValidation?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.register(HolidayTableViewCell.self, indexPath: indexPath)
        if isHistory {
            cell.nextBtn.tag = indexPath.row
            cell.nextBtn.addTarget(self, action: #selector(btnTap(_:)), for: .touchUpInside)
            cell.configDataOfRecords(data: self.holidayModel?.records?[indexPath.row])
        }
        else {
            cell.nextBtn.tag = indexPath.row
            cell.nextBtn.addTarget(self, action: #selector(btnTap(_:)), for: .touchUpInside)
            cell.configDataOfInValidation(data: self.holidayModel?.inValidation?[indexPath.row])
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
