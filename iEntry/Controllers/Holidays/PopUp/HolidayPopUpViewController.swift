//
//  HolidayPopUpViewController.swift
//  iEntry
//
//  Created by HaiDeR AwAn on 12/04/2023.
//

import UIKit

class HolidayPopUpViewController: UIViewController {
    

    //MARK: - IBOutlet
    
    @IBOutlet weak var mainTitle: UILabel!
    
    //MARK: - From section
    @IBOutlet weak var fromTitle: UILabel!
    @IBOutlet weak var fromValue: UILabel!
    
    //MARK: - Until section
    @IBOutlet weak var untilTitle: UILabel!
    @IBOutlet weak var untilValue: UILabel!
    
    //MARK: - Total section
    @IBOutlet weak var totalTitle: UILabel!
    @IBOutlet weak var totalValueStatus: UILabel!
    @IBOutlet weak var totalStatus: UIView!
    
    //MARK: - new total
    
    @IBOutlet weak var totallsTitle: UILabel!
    @IBOutlet weak var totallsValue: UILabel!
    
    //MARK: - Department section
    @IBOutlet weak var departmentTitle: UILabel!
    @IBOutlet weak var departmentValue: UILabel!
    @IBOutlet weak var departmentApproveImageBtn: UIButton!
    
    //MARK: - boss section
    @IBOutlet weak var bossTitle: UILabel!
    @IBOutlet weak var bossName: UILabel!
    @IBOutlet weak var bossEmail: UILabel!
    @IBOutlet weak var bossPhoneNumber: UILabel!
    @IBOutlet weak var bossApproveImageBtn: UIButton!
    
    
    //MARK: - Requested section
    @IBOutlet weak var requestTitle: UILabel!
    @IBOutlet weak var requestValue: UILabel!
    
    @IBOutlet weak var cancelHolidayBtn: UIButton!
    
    //MARK: - Variables
    
    var callBack: ((_ cancelPress:String) ->Void)? = nil
    var isRecord = false
    var recordModel : RecordsList?
    var inValidModel : InValidationList?
    var mainModel : HolidayModelData?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func cancelRequestAction(_ sender: Any) {
        self.dismiss(animated: true)
        if isRecord {
            callBack?(recordModel?.id ?? "")
        }
        else {
            callBack?(inValidModel?.id ?? "")
        }
       
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    //MARK: -  Functions
    
    func setupUI() {
        self.mainTitle.text = "DETALLES DE SOLICITUD".localized
        self.fromTitle.text = "DESDE".localized
        self.untilTitle.text = "HASTA".localized
        self.totallsTitle.text = "TOTALES".localized
        self.totalTitle.text = "ESTATUS".localized
        self.departmentTitle.text = "DEPARTAMENTO QUE APROBARÁ".localized
        self.bossTitle.text = "JEFE".localized
        self.requestTitle.text = "SOLITITADO EN".localized
        if isRecord {
            cancelHolidayBtn.isHidden = true
            
            self.fromValue.text = self.recordModel?.fromDate?.getDateStringFromUTC().putDashes()
            self.untilValue.text = self.recordModel?.toDate?.getDateStringFromUTC().putDashes()
            if let date = self.recordModel?.createdAt?.getDateStringFromUTC().putDashes() {
                self.requestValue.text = date
            }
            else {
                self.requestValue.text = "--"
            }
            self.departmentValue.text = self.mainModel?.departmentName.putDashes()
            self.bossName.text = self.mainModel?.bossName.putDashes()
            self.bossEmail.text = self.mainModel?.bossEmail.putDashes()
            self.bossPhoneNumber.text = self.mainModel?.bossPhoneNumber.putDashes()
            self.totallsValue.text = "\(self.recordModel?.totalDay ?? 0)"
            self.recordModel?.manager?.statusId == 43 ? self.bossApproveImageBtn.setImage(UIImage(named: "ic-check-2"), for: .normal) : self.bossApproveImageBtn.setImage(UIImage(named: "ic-cancel"), for: .normal)
            self.recordModel?.department?.statusId == 43 ? self.departmentApproveImageBtn.setImage(UIImage(named: "ic-check-2"), for: .normal) : self.departmentApproveImageBtn.setImage(UIImage(named: "ic-cancel"), for: .normal)
            self.setupStatus(id: self.recordModel?.statusName.putDashes())
            
        }
        else {
            cancelHolidayBtn.isHidden = false
            self.fromValue.text = self.inValidModel?.fromDate?.getDateStringFromUTC().putDashes()
            self.untilValue.text = self.inValidModel?.toDate?.getDateStringFromUTC().putDashes()
            if let date = self.inValidModel?.createdAt?.getDateStringFromUTC().putDashes() {
                self.requestValue.text = date
            }
            else {
                self.requestValue.text = "--"
            }
            self.inValidModel?.department?.statusId == 43 ? self.departmentApproveImageBtn.setImage(UIImage(named: "ic-check-2"), for: .normal) : self.departmentApproveImageBtn.setImage(UIImage(named: "ic-cancel"), for: .normal)
            self.inValidModel?.manager?.statusId == 43 ? self.bossApproveImageBtn.setImage(UIImage(named: "ic-check-2"), for: .normal) : self.bossApproveImageBtn.setImage(UIImage(named: "ic-cancel"), for: .normal)
            self.departmentValue.text = self.mainModel?.departmentName.putDashes()
            self.bossName.text = self.mainModel?.bossName.putDashes()
            self.bossEmail.text = self.mainModel?.bossEmail.putDashes()
            self.bossPhoneNumber.text = self.mainModel?.bossPhoneNumber.putDashes()
            self.totallsValue.text = "\(self.inValidModel?.totalDay ?? 0)"
            self.setupStatus(id: self.inValidModel?.statusName.putDashes())
        }
    }

    func setupStatus(id:String?) {
        if id == "HOLIDAY_PENDING_TO_VALIDATE" {
            self.totalValueStatus.text = "HOLIDAY_PENDING_TO_VALIDATE".localized
            self.totalValueStatus.textColor = UIColor(hexString: "707070")
            self.totalStatus.backgroundColor = UIColor(hexString: "707070") // gray
        }
        else
        if id == "HOLIDAY_DENIED" {
            self.totalValueStatus.text = "HOLIDAY_DENIED".localized
            self.totalValueStatus.textColor = UIColor(hexString: "BC0000")
            self.totalStatus.backgroundColor = UIColor(hexString: "BC0000") // red
        }
        else
        if id == "HOLIDAY_APPROVED" {
            self.totalValueStatus.text = "HOLIDAY_APPROVED".localized
            self.totalValueStatus.textColor = UIColor(hexString: "146F62")
            self.totalStatus.backgroundColor = UIColor(hexString: "146F62") // greeen
        }
        else
        if id == "HOLIDAY_CANCELED" {
            self.totalValueStatus.text = "HOLIDAY_CANCELED".localized
            self.totalValueStatus.textColor = UIColor(hexString: "F2A100") // yellow
            self.totalStatus.backgroundColor = UIColor(hexString: "F2A100")
        }
    }
    
}
