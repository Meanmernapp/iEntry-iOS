//
//  CreateEventVC.swift
//  iEntry
//
//  Created by ZAFAR on 12/08/2021.
//

import UIKit
import FSCalendar
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import SMDatePicker
import CoreAudio
import DropDown

class CreateEventVC: BaseController, FSCalendarDelegate, FSCalendarDataSource,UITextFieldDelegate, SMDatePickerDelegate {
    
    
    //MARK: - IBOutlets

    @IBOutlet weak var lblreservationtitle: UILabel!
    
    @IBOutlet weak var txtmint: MDCOutlinedTextField!
    @IBOutlet weak var lblagreetitle: UILabel!
    @IBOutlet weak var lblreservationbottomtitle: UILabel!
    @IBOutlet weak var lblcreateEventtitle: UILabel!
    @IBOutlet weak var lblreservationlisttitle: UILabel!
    
    
    //MARK: - Variables
    
    var  commenAreasdata : [CommenAreasModelsData]? = nil
    
    var starttimeInMiliSecDate = 0
    var endtimeInMiliSecDate = 0
    var reservationName = ""
    var reservationId = ""
    var startdate = Date()
    var endDate = Date()
    var myDatePicker: SMDatePicker = SMDatePicker()
    var MainDrowpDown = DropDown()
    let durationList = ["10 MIN","15 MIN","20 MIN","25 MIN","30 MIN","35 MIN","40 MIN","45 MIN","50 MIN","55 MIN","1 HOUR","1.5 HOUR","2 HOUR","2.5 HOUR","3 HOUR","4 HOUR","5 HOUR","6 HOUR","12 HOUR","18 HOUR","1 DAY","2 DAY","3 DAY","1 WEEK"]
    var selectedId = -1
    //MARK: - here are the iboutlet
    
    @IBOutlet weak var lblschedualtitle: UILabel!
    @IBOutlet weak var btncross: UIButton!
    @IBOutlet weak var btnprevius: UIButton!
    @IBOutlet weak var btnnext: UIButton!
    @IBOutlet weak var fcCalaender: FSCalendar!
    @IBOutlet weak var txtEnterEvent: MDCOutlinedTextField!
    @IBOutlet weak var txtdate: MDCOutlinedTextField!
    @IBOutlet weak var txttime: MDCOutlinedTextField!
    @IBOutlet weak var stripView: UIView!
    @IBOutlet weak var tblheight: NSLayoutConstraint!
    @IBOutlet weak var noAreasView: UIView!
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var noCommonAreaTxt: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.isScrollEnabled = false
        
            let timeInMiliSecDate = Date()
            let timeInMiliSecEndDate = Date()
        
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "dd/MM/yyyy" //HH:mm
            let stringDate1 = dateFormatter1.string(from: timeInMiliSecDate)
            self.txtdate.text = stringDate1
           
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "HH:mm:ss"
            let stringDate2 = dateFormatter2.string(from: timeInMiliSecEndDate)
            self.txttime.text = stringDate2
            
         starttimeInMiliSecDate = StartDayMiliSeconds(newdate: Date().startOfDay()!) ?? 0//Int (Date().timeIntervalSince1970 * 1000)
         endtimeInMiliSecDate = StartDayMiliSeconds(newdate: Date().startOfDay()!) ?? 0//Int (Date().timeIntervalSince1970 * 1000)
        
        getallCommenAreasApi(startdate: timeInMiliSecDate, endDate: timeInMiliSecEndDate)
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    navigationBarHidShow(isTrue: true)
        self.tblView.register(UINib.init(nibName: "NearChoosCell", bundle: nil), forCellReuseIdentifier: "NearChoosCell")
        self.configUi()
        self.fcCalaender.bringSubviewToFront(btnnext)
        self.fcCalaender.bringSubviewToFront(btnprevius)
        
        self.noCommonAreaTxt.text = "NO HAY AREAS COMUNES DISPONIBLES".localized
        self.lblcreateEventtitle.text = "C R E A R  E V E N T O".localized
        
        self.lblschedualtitle.text = "ELÍGE UN HORARIO".localized
        self.lblreservationtitle.text = "ELÍGE LA AREA COMÚN A RESERVAR:".localized
        self.lblreservationbottomtitle.text = "RESERVACIÓN".localized
        self.lblagreetitle.text = "AGREGAR EVENTO".localized

    }
    
    @IBAction func durationAction(_ sender: Any) {

        dropDownConfig(txtField: txtmint
                       , data: durationList)
    }
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
            
            self.txtmint.text = item
            
        }
        MainDrowpDown.show()
    }
    //MARK:- this funtion use to set the UI
    func configUi() {
      
        fcCalaender.shadowAndRoundcorner(cornerRadius: 8, shadowColor: #colorLiteral(red: 0.6744349003, green: 0.6745528579, blue: 0.6744274497, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1.0)
        fcCalaender.delegate = self
        fcCalaender.dataSource = self
        fcCalaender.scrollDirection = .horizontal
        fcCalaender.pagingEnabled = true
        fcCalaender.scrollEnabled = true
        fcCalaender.scope = .month
        fcCalaender.appearance.headerMinimumDissolvedAlpha = 0
        setMDCTxtFieldDesign(txtfiled: txtEnterEvent, Placeholder: "NOMBRE DE TU EVENTO", imageIcon: trailingImage)
        
        setMDCTxtFieldDesign(txtfiled: txtmint, Placeholder: "DURACIÓN", imageIcon:UIImage())
        
        setMDCTxtFieldDesign(txtfiled: txttime, Placeholder: "HORA", imageIcon: UIImage(named: "ic-clock")!)
        setMDCTxtFieldDesign(txtfiled: txtdate, Placeholder: "FECHA", imageIcon: UIImage(named: "ic-calendar-1")!)
        stripView.roundViiew()
    
        txttime.delegate = self
        txtdate.delegate = self
    }
    
    var trailingImage: UIImage = {
      return UIImage.init(named: "ic-piñata",
                          in: Bundle(for: CreateEventVC.self),
                          compatibleWith: nil) ?? UIImage()
    }()
    
    //MARK:- Calender Delegate
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    func showHide() {
        if commenAreasdata?.count ?? 0 > 0 {
            self.noAreasView.isHidden = true
            self.tblView.isHidden = false
        }
        else {
            self.noAreasView.isHidden = false
            self.tblView.isHidden = true
        }
    }
  

    @IBAction func addEventAction(_ sender: UIButton) {
        
        if self.commenAreasdata?.count == 0 {
            AppUtility.showErrorMessage(message: "NO HAY AREAS COMUNES DISPONIBLES".localized)
            return
        }
        
        if reservationId == "" {
            AppUtility.showErrorMessage(message: "ELÍGE LA AREA COMÚN A RESERVAR:".localized)
            return
        }
        
        if txtEnterEvent.text == "" {
            AppUtility.showErrorMessage(message: "lb_empty_event_name".localized)
            return
        }
        let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ConfirmEventVC") as? ConfirmEventVC
        vc?.name = self.txtEnterEvent.text!
        vc?.startDate = "\(starttimeInMiliSecDate)"
        vc?.endDate = "\(endtimeInMiliSecDate)"
        vc?.resevationid = reservationId
        vc?.reservationName = reservationName
        vc?.isfromupdate = false 
        vc?.duration = txtmint.text ?? ""
        vc?.modalPresentationStyle = .overFullScreen
        vc?.callBack = { Ok , eventid in
            if Ok == true {
                self.dismiss(animated: true, completion: nil)
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"EventInvitation") as? EventInvitation
                vc?.eventid = eventid
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        self.present(vc!, animated: false, completion: nil)
        
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
         if(keyPath == "contentSize"){
             if let newvalue = change?[.newKey]
             {
                 DispatchQueue.main.async {
                 let newsize  = newvalue as! CGSize
                 self.tblheight.constant = newsize.height
                 }

             }
         }
     }
    func getallCommenAreasApi(startdate:Date,endDate:Date){
        self.showLoader()
        
        let timeInMiliSecDate = startdate//Date()
        let timeInMiliSec = StartDayMiliSeconds(newdate: Date().startOfDay()!) ?? 0//Int (timeInMiliSecDate.timeIntervalSince1970 * 1000)
        
        let timeInMiliSecEndDate = endDate//Date()
        let secEndDatetimeInMili = StartDayMiliSeconds(newdate: Date().startOfDay()!) ?? 0//Int (timeInMiliSecEndDate.timeIntervalSince1970 * 1000)
        
        //30 * 24 * 60 * 60 * 1000
        let dic : [String:Any] = ["startDate":timeInMiliSec,"endDate": secEndDatetimeInMili,"userId":ShareData.shareInfo.obj?.id ?? ""]
        userhandler.getallCommenAreas(params: dic) { response in
            self.hidLoader()
            if response?.success == true {
                self.commenAreasdata =  response?.data
                
                self.tblView.reloadData()
                self.tblheight.constant =  self.tblView.contentSize.height

                self.view.layoutIfNeeded()
               
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        } Failure: { error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        }

    }
    
    
    //MARK: - Next Button Action
    
    @IBAction func btnNextMonthClicked(sender: UIButton) {

        let currentDate = self.fcCalaender.currentPage
        let date = self.dateByAddingMonths(dMonths: 1, currentDate: currentDate as NSDate)
        self.fcCalaender.setCurrentPage(date as Date, animated: true)
    }

    // For getting Next month
    func dateByAddingMonths(dMonths: Int, currentDate: NSDate) -> NSDate{

        let dateComponent = NSDateComponents()
        dateComponent.month = dMonths
        let newDate = NSCalendar.current.date(byAdding: dateComponent as DateComponents, to: currentDate as Date)
        return newDate! as NSDate
    }

    //MARK: - Previous Button Action -
    @IBAction func btnPreviousMonthClicked(sender: AnyObject) {

        let currentDate = self.fcCalaender.currentPage
        let date = self.dateBySubtractingMonths(dMonths: 1, currentDate: currentDate as NSDate)
        self.fcCalaender.setCurrentPage(date as Date, animated: true)
    }

    // For Previous Month
    func dateBySubtractingMonths(dMonths: Int, currentDate: NSDate) -> NSDate{

        return self.dateByAddingMonths(dMonths: -dMonths, currentDate: currentDate)
    }
    
    
    
    
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func crossAction(_ sender: UIButton) {
        for item in 0..<self.commenAreasdata!.count{
            self.commenAreasdata?[item].isSelected = false
        }
        self.tblView.reloadData()
        self.lblreservationtitle.text = ""
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.hideKeyboard()
        if textField == txtdate {
            self.datePickerConfig(DatePickerMood:.date)
            myDatePicker.showPickerInView(view, animated: true)
        } else if textField == txttime {
           self.datePickerConfig(DatePickerMood:.time)
            myDatePicker.showPickerInView(view, animated: true)
        }
    }
    
    
    
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
    
    
    @objc func canceleDatePicker() {
       /// myDatePicker.hidePicker(true)
        myDatePicker.pressedCancel(self)
    }

    //Toolbar done button function
    @objc func onClickDoneButton() {
        myDatePicker.hidePicker(true)
        
    }
    
    
    @objc func datePickerValueChanged(_ picker : UIDatePicker) {
        print(picker.date)
        
        if picker.datePickerMode == .date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
            let stringDate = dateFormatter.string(from: picker.date)
            self.txtdate.text = stringDate
            self.starttimeInMiliSecDate =  StartDayMiliSeconds(newdate: picker.date.startOfDay()!) ?? 0//Int (picker.date.timeIntervalSince1970 * 1000)
            startdate = picker.date
            getallCommenAreasApi(startdate:startdate,endDate:endDate)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let stringDate = dateFormatter.string(from: picker.date)
            self.txttime.text = stringDate
            self.endtimeInMiliSecDate =  StartDayMiliSeconds(newdate: picker.date.startOfDay()!) ?? 0//Int (picker.date.timeIntervalSince1970 * 1000)
            endDate = picker.date
            getallCommenAreasApi(startdate:startdate,endDate:endDate)
        }
    }
    func  datePickerWillAppear(_ picker: SMDatePicker){
        print(picker.pickerDate)
        self.hideKeyboard()
        if picker.pickerMode == .date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
            let stringDate = dateFormatter.string(from: picker.pickerDate)
            self.txtdate.text = stringDate
            
            self.startdate = picker.pickerDate
            self.starttimeInMiliSecDate = StartDayMiliSeconds(newdate: picker.pickerDate.startOfDay()!) ?? 0 //Int (picker.pickerDate.timeIntervalSince1970 * 1000)
            getallCommenAreasApi(startdate:startdate,endDate:endDate)
            print(starttimeInMiliSecDate)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let stringDate = dateFormatter.string(from: picker.pickerDate)
            self.txttime.text = stringDate
            
            //let timeInMiliSecDate = picker.pickerDate
//             endtimeInMiliSecDate = Int (timeInMiliSecDate.timeIntervalSince1970 * 1 * 24 * 60 * 60 * 1000)
            self.endtimeInMiliSecDate = StartDayMiliSeconds(newdate: picker.pickerDate.startOfDay()!) ?? 0 //Int (picker.pickerDate.timeIntervalSince1970 * 1000)
            self.endDate = picker.pickerDate
            getallCommenAreasApi(startdate:startdate,endDate:endDate)
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

extension CreateEventVC :  UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        showHide()
        return self.commenAreasdata?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "NearChoosCell") as? NearChoosCell

        cell?.lblname.text = self.commenAreasdata?[indexPath.row].name
        cell?.lblvenu.text = self.commenAreasdata?[indexPath.row].name
        cell?.lblactive.text = self.commenAreasdata?[indexPath.row].status?.name
        if self.commenAreasdata?[indexPath.row].isCommonArea == true {
            cell?.iscommenareaicon.isHidden = false
        } else {
            cell?.iscommenareaicon.isHidden = true
        }
    
        if self.commenAreasdata?[indexPath.row].isSelected == true {
            cell?.mainView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else {
            cell?.mainView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for item in 0..<self.commenAreasdata!.count{
            self.commenAreasdata?[item].isSelected = false
        }
        self.commenAreasdata?[indexPath.row].isSelected = true
        self.reservationName =  self.commenAreasdata?[indexPath.row].name ?? ""
        self.reservationId = self.commenAreasdata?[indexPath.row].zoneId ?? ""
        self.lblreservationtitle.text = self.commenAreasdata?[indexPath.row].name ?? ""
        self.tblView.reloadData()
    }

}
