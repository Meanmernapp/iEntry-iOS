//
//  AddHolidayViewController.swift
//  iEntry
//
//  Created by HaiDeR AwAn on 12/04/2023.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextFields
import FittedSheets

class AddHolidayViewController: BaseController {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var txtdate: MDCOutlinedTextField!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var curvView: UIView!
    @IBOutlet weak var mainTitle: UILabel!
    
    //MARK: - Titles
    
    @IBOutlet weak var fromTitle: UILabel!
    @IBOutlet weak var fromValue: UILabel!
    @IBOutlet weak var toTitle: UILabel!
    @IBOutlet weak var toValue: UILabel!
    @IBOutlet weak var totalTitle: UILabel!
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var departmentTitle: UILabel!
    @IBOutlet weak var departmentValue: UILabel!
    @IBOutlet weak var bossTitle: UILabel!
    @IBOutlet weak var bossName: UILabel!
    @IBOutlet weak var bossEmail: UILabel!
    @IBOutlet weak var bossPhoneNumber: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    //MARK: - Variables
    
    var fromDate : Double?
    var endDate : Double?
    var totalDays : Int?
    var mainModel : HolidayModelData?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curvView.roundCorners([.topLeft,.bottomLeft], radius: 5)
        mainView.layer.cornerRadius = 36
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        mainView.layer.masksToBounds = true
        setMDCTxtFieldDesign(txtfiled: txtdate, Placeholder: "PERIODO VACACIONAL".localized, imageIcon: UIImage(named: "ic-calendar-1")!)
        self.setup()
    }
    
    @IBAction func calenderAction(_ sender: UIButton) {
        let controller = CalenderViewController(monthsLayout: .vertical)
        controller.callback  = { startDate , endDate in
            let start = startDate.replacingOccurrences(of: "-", with: "/")
            let end = endDate.replacingOccurrences(of: "-", with: "/")
            self.txtdate.text = start + " - " + end
            self.fromValue.text = start
            self.toValue.text = end
            self.findDays(dateString1: start, dateString2: end)
        }
        let sheetController = SheetViewController(controller: controller)
        self.present(sheetController, animated: true, completion: nil)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createAction(_ sender: Any) {
            if let endDate , let fromDate , let totalDays {
                if totalDays < self.mainModel?.available ?? 0 {
                    let user = ShareData.shareInfo.obj
                    let parama = ["createdAt":Date().timeIntervalSince1970,"fromDate":fromDate,"toDate":endDate,"statusId":41,"totalDay":totalDays, "whoRequestedId" :user?.id ?? "","whoRequestedLastName":user?.lastName ?? "","whoRequestedName" : user?.name ?? "","whoRequestedSecondLastName":user?.secondLastName ?? ""] as [String : Any]
                    
                    createHolidayApi(params: parama)
                    
                }
                else {
                    AppUtility.showInfoMessage(message: "No tienes suficientes hojas".localized)
                }
            }
            else {
                AppUtility.showInfoMessage(message: "Seleccione primero los días".localized)
            }
        
    }
    
    func createHolidayApi(params:[String:Any]) {
        self.showLoader()
        userhandler.createHoliday(params: params) { response in
            self.hidLoader()
            if response?.success == true  {
                AppUtility.showSuccessMessage(message: response?.message ?? "Done")
                self.navigationController?.popViewController(animated: true)
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
    
    func setup() {
        let dateFormatter = DateFormatter() // create a DateFormatter instance
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: Date())
        
        self.txtdate.text = "\(dateString) - \(self.mainModel?.to?.getDateStringFromUTC() ?? "")"
        self.mainTitle.text = "SOLICITUD DE VACACIONES".localized
        self.fromTitle.text = "DESDE".localized
        self.toTitle.text = "HASTA".localized
        self.totalTitle.text = "TOTALES".localized
        self.departmentTitle.text = "DEPARTAMENTO QUE APROBARÁ".localized
        self.bossTitle.text = "JEFE QUE LO APROBARÁ".localized
        self.btn.setTitle("SOLICITAR".localized, for: .normal)
        
        //MARK: - BOSS
        
        self.departmentValue.text = self.mainModel?.departmentName.putDashes()
        self.bossName.text = self.mainModel?.bossName.putDashes()
        self.bossEmail.text = self.mainModel?.bossEmail.putDashes()
        self.bossPhoneNumber.text = self.mainModel?.bossPhoneNumber.putDashes()
    }
    
    func findDays(dateString1:String,dateString2:String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date1 = dateFormatter.date(from: dateString1),
              let date2 = dateFormatter.date(from: dateString2) else {
            fatalError("One or both of the date strings is invalid")
        }
        self.fromDate = date1.timeIntervalSince1970*1000
        self.endDate = date2.timeIntervalSince1970*1000
        let calendar = Calendar.current
        var weekdays = 0
        var currentDate = date1
        while currentDate <= date2 {
            let weekday = calendar.component(.weekday, from: currentDate)
            if weekday >= 2 && weekday <= 6 {
                weekdays += 1
            }
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        self.totalValue.text =  "\(weekdays) \("DÍAS".localized)"
        self.totalDays = weekdays
    }
}
