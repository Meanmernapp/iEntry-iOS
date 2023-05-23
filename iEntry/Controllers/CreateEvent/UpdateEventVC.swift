//
//  UpdateEventVC.swift
//  iEntry
//
//  Created by ZAFAR on 18/08/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import SMDatePicker
import EPContactsPicker

class UpdateEventVC: BaseController,UITextFieldDelegate,SMDatePickerDelegate, EPPickerDelegate {
    @IBOutlet weak var lblupdatetitle: UILabel!
    
    @IBOutlet weak var selectedReservationTitle: UILabel!
    @IBOutlet weak var selectedReservation: UILabel!
    @IBOutlet weak var txtmint: MDCOutlinedTextField!
    @IBOutlet weak var currentReservationTblView: UITableView!
    @IBOutlet weak var lblsavechangestitle: UILabel!
    @IBOutlet weak var actualReservationTitle: UILabel!
    @IBOutlet weak var lblchoosdatetitle: UILabel!
    @IBOutlet weak var reserveTableView: UITableView!
    @IBOutlet weak var reserveTableHeight: NSLayoutConstraint!
    @IBOutlet weak var stripView: UIView!
    @IBOutlet weak var txtEvent: MDCOutlinedTextField!
    @IBOutlet weak var txtdate: MDCOutlinedTextField!
    @IBOutlet weak var txttime: MDCOutlinedTextField!
    @IBOutlet weak var lblreservationTitle: UILabel!
    
    var myDatePicker: SMDatePicker = SMDatePicker()
    var startDatemyDate = Date()
    var endDatemyDate = Date()
    var startMiliSecond = 0
    var endMiliSecond = 0
    var invitationsData : [getAllInvitationsAgainstEventModelData]? = nil
    var eventdata : EventModuleData? = nil
    var eventDetaildata : EventDetailModelData? = nil
    var  commenAreasdata = [CommenAreasModelsData]()
    var usersIDsarr = [String]()
    var checkRegisterUser = [checkUserExistModel]()
    var invitationlist = [InvitationsHistoryModel]()
    var reservationName = ""
    var reservationId = ""
    var isNewReservation = false
    var change = false
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblreservationTitle.text = "RESERVACIÓN".localized
        
        self.lblupdatetitle.text = "A C T U A L I Z A R".localized
        self.lblchoosdatetitle.text = "NUEVA FECHA DEL EVENTO".localized
        self.lblsavechangestitle.text = "GUARDAR CAMBIOS".localized
        self.reserveTableView.isScrollEnabled = false
        setMDCTxtFieldDesign(txtfiled: txtEvent, Placeholder: "NOMBRE DEL EVENTO".localized, imageIcon: UIImage(named: "ic-piñata") ?? UIImage())
        setMDCTxtFieldDesign(txtfiled: txttime, Placeholder: "HORA".localized, imageIcon: UIImage(named: "ic-clock")!)
        setMDCTxtFieldDesign(txtfiled: txtdate, Placeholder: "FECHA".localized, imageIcon: UIImage(named: "ic-calendar-1")!)
        setMDCTxtFieldDesign(txtfiled: txtmint, Placeholder: "DURACIÓN".localized, imageIcon: UIImage())
        self.navigationBarHidShow(isTrue: true)
        self.reserveTableView.register(UINib.init(nibName: "NearChoosCell", bundle: nil), forCellReuseIdentifier: "NearChoosCell")
        self.currentReservationTblView.register(UINib.init(nibName: "NearChoosCell", bundle: nil), forCellReuseIdentifier: "NearChoosCell")
        stripView.roundViiew()
        txttime.delegate = self
        txtdate.delegate = self
        conFigData()
        self.reserveTableView.addObserver(self, forKeyPath: "contentSize1", options: .new, context: nil)
        
    }
    
    
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                DispatchQueue.main.async {
                    let newsize  = newvalue as! CGSize
                    self.reserveTableHeight.constant = self.reserveTableView.contentSize.height
                    self.view.layoutIfNeeded()
                }
                
            }
        } else if(keyPath == "contentSize1")  {
            if let newvalue = change?[.newKey]
            {
                DispatchQueue.main.async {
                    let newsize  = newvalue as! CGSize
                    self.reserveTableHeight.constant = newsize.height
                    self.view.layoutIfNeeded()
                }
                
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.reserveTableHeight.constant = self.reserveTableView.contentSize.height
        self.view.layoutIfNeeded()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.reserveTableHeight.constant = self.reserveTableView.contentSize.height
        
        self.view.layoutIfNeeded()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        if !change {
            self.navigationController?.popViewController(animated: true)
        }
        else {
            let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationDownloadImageAlertVC") as? NotificationDownloadImageAlertVC
            vc?.titlofDialog = "CAMBIOS DETECTADOS".localized
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
    
    
    
    func conFigData(){
        
        
        self.checkRegisterUser.removeAll()
        for item in invitationsData ?? [] {
            self.checkRegisterUser.append(checkUserExistModel(name: item.guest?.name ?? "", phone: item.guest?.phoneNumber ?? "", isregister: true, guestid: item.guest?.id ?? "", registertype: 0, email: item.guest?.email ?? ""))
        }
        txtEvent.text =  eventDetaildata?.name
        txtdate.text = self.getMilisecondstoDate(seconds: "\(self.eventDetaildata?.startDate ?? 0)", formatter: "")
        txttime.text = self.getMilisecondstoTime(seconds: "\(self.eventDetaildata?.endDate ?? 0)", formatter: "")
        
        self.reservationName =  eventdata?.reservation?.zone?.name ?? ""
        self.reservationId = eventdata?.reservation?.zone?.id ?? ""
        self.txtmint.text = "\(eventdata?.duration ?? 0)"
        getallCommenAreasApi(startdate:self.eventDetaildata?.startDate ?? 0,endDate:self.eventDetaildata?.endDate ?? 0)
        
    }
    @IBAction func removeReservationAction(_ sender: Any) {
        for item in 0..<self.commenAreasdata.count{
            self.commenAreasdata[item].isSelected = false
        }
        self.reservationId = ""
        self.reservationName = ""
        self.selectedReservation.text = "None"
        self.reserveTableView.reloadData()
    }
    
    func getallCommenAreasApi(startdate:Int,endDate:Int){
        self.showLoader()
        startMiliSecond = startdate
        endMiliSecond = endDate
        
        //30 * 24 * 60 * 60 * 1000
        let dic : [String:Any] = ["startDate":startMiliSecond,"endDate": endMiliSecond,"userId":ShareData.shareInfo.obj?.id ?? ""]
        userhandler.getallCommenAreas(params: dic) { response in
            self.hidLoader()
            if response?.success == true {
                self.commenAreasdata =  (response?.data)!
                
                for item in self.commenAreasdata {
                    if self.eventdata?.reservation?.zone?.id == item.zoneId {
                        item.isSelected = true
                        self.reservationName =  item.name ?? ""
                        self.reservationId = item.zoneId ?? ""
                    }
                }
                
                self.reserveTableView.reloadData()
                self.currentReservationTblView.reloadData()
                self.reserveTableHeight.constant =  self.reserveTableView.contentSize.height
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
                
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        } Failure: { error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        }
        
    }
    
    @IBAction func StripAction(_ sender: UIButton) {
        if isNewReservation == false {
            
        } else {
            
            if self.commenAreasdata.count == 0 {
                AppUtility.showErrorMessage(message: "No free reservarion areas")
                return
            }
        }
        
//        if self.change {
            if self.selectedReservation.text != "None" {
                let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"ConfirmEventVC") as? ConfirmEventVC
                vc?.isNewReservation = self.isNewReservation
                vc?.name = txtEvent.text! //eventDetaildata?.name ?? ""
                vc?.startDate = "\(startMiliSecond)"
                vc?.endDate = "\(endMiliSecond)"
                vc?.resevationid = reservationId
                vc?.duration = self.txtmint.text ?? ""
                vc?.reservationName = reservationName
                vc?.eventid = self.eventDetaildata?.id ?? ""
                if self.invitationsData?.count ?? 0 > 0{
                    vc?.guestNumber = self.invitationsData?[0].guestNumber ?? 0
                } else {
                    vc?.guestNumber = 1
                }
                self.usersIDsarr.removeAll()
                for item in self.checkRegisterUser {
                    if item.isregister == true {
                        self.usersIDsarr.append(item.guestid)
                    }
                }
                vc?.usersIDsarr = self.usersIDsarr
                vc?.isfromupdate = true
                vc?.modalPresentationStyle = .overFullScreen
                vc?.callBack = { Ok,eventid in
                    if Ok == true {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                self.present(vc!, animated: false, completion: nil)
            }
            else {
                AppUtility.showErrorMessage(message: "Please select reservation")
            }

//        }
//        else {
//            AppUtility.showErrorMessage(message: "No changes done yet!")
//        }
    }
    
    func deleteInvitationApi(invid:String){
        userhandler.deleteInvitation(invitationid: invid, Success: {response in
            if response?.success == true {
                
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "Error perfoming request")
            }
        }, Failure: {error in
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    //MARK:- datepicker funtion
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtdate {
            self.datePickerConfig(DatePickerMood:.date)
            myDatePicker.showPickerInView(view, animated: true)
        } else if textField == txttime {
            self.datePickerConfig(DatePickerMood:.time)
            myDatePicker.showPickerInView(view, animated: true)
        }
    }
    

    //MARK:- datepicker funtion use to pick the time and date
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
            startDatemyDate = picker.date
            
            
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let stringDate = dateFormatter.string(from: picker.date)
            self.txttime.text = stringDate
            endDatemyDate = picker.date
        }
        getallCommenAreasApi(startdate:StartDayMiliSeconds(newdate: startDatemyDate.startOfDay()!) ?? 0, endDate: StartDayMiliSeconds(newdate: endDatemyDate.startOfDay()!) ?? 0)
    }
    
    
    
    
}
//MARK:- tableview datesource and delegate
extension UpdateEventVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  tableView == reserveTableView  {
            return  self.commenAreasdata.count
        }
        else  if tableView ==  currentReservationTblView {
            return  1
        }
        else {
            return self.checkRegisterUser.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView ==  reserveTableView {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "NearChoosCell") as? NearChoosCell
            self.view.setNeedsLayout()
            cell?.lblname.text = self.commenAreasdata[indexPath.row].name
            cell?.lblvenu.text = self.commenAreasdata[indexPath.row].name
            cell?.lblactive.text = self.commenAreasdata[indexPath.row].status?.name
            
            
            if self.commenAreasdata[indexPath.row].isSelected == true {
                cell?.mainView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            } else {
                cell?.mainView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            return cell!
        }
        else {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "NearChoosCell") as? NearChoosCell
            if let i = self.commenAreasdata.firstIndex(where:{$0.isSelected == true}) {
                cell?.lblname.text = self.commenAreasdata[i].name
                cell?.lblvenu.text = self.commenAreasdata[i].name
                cell?.lblactive.text = self.commenAreasdata[i].status?.name
                self.selectedReservation.text = self.commenAreasdata[i].name
            }
            return cell!
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for item in 0..<self.commenAreasdata.count{
            self.commenAreasdata[item].isSelected = false
        }
        self.commenAreasdata[indexPath.row].isSelected = true
        change = true
        reservationName =  self.commenAreasdata[indexPath.row].name ?? ""
        self.selectedReservation.text = self.commenAreasdata[indexPath.row].name ?? ""
        reservationId = self.commenAreasdata[indexPath.row].zoneId ?? ""
        self.isNewReservation = true
        self.reserveTableView.reloadData()
    }
    
    //MARK:- datepicker delegates
    func  datePickerWillAppear(_ picker: SMDatePicker){
        
        print(picker.pickerDate)
        self.hideKeyboard()
        if picker.pickerMode == .date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
            let stringDate = dateFormatter.string(from: picker.pickerDate)
            self.txtdate.text = stringDate
            startDatemyDate = picker.pickerDate
            //getallCommenAreasApi(startdate:startDatemyDate,endDate:endDatemyDate)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let stringDate = dateFormatter.string(from: picker.pickerDate)
            self.txttime.text = stringDate
            endDatemyDate = picker.pickerDate
            //getallCommenAreasApi(startdate:startDatemyDate,endDate:endDatemyDate)
        }
        getallCommenAreasApi(startdate:StartDayMiliSeconds(newdate: startDatemyDate.startOfDay()!) ?? 0, endDate: StartDayMiliSeconds(newdate: endDatemyDate.startOfDay()!) ?? 0)
    }
    func datePickerDidAppear(_ picker: SMDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
        let _ = dateFormatter.string(from: picker.pickerDate)
        
    }
    
    private func  datePicker(picker: SMDatePicker, didPickDate date: NSDate) {
        print(date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
        let _ = dateFormatter.string(from: picker.pickerDate)
    }
    func  datePickerDidCancel(_ picker: SMDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
        let _ = dateFormatter.string(from: picker.pickerDate)
        
    }
    
    func  datePickerWillDisappear(_ picker: SMDatePicker) {
        print(picker.pickerDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
        let _ = dateFormatter.string(from: picker.pickerDate)
        
    }
    func  datePickerDidDisappear(_ picker: SMDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
        let _ = dateFormatter.string(from: picker.pickerDate)
        
    }
}
