//
//  HolidayTableViewCell.swift
//  iEntry
//
//  Created by HaiDeR AwAn on 07/04/2023.
//

import UIKit

class HolidayTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var statusValue: UILabel!
    @IBOutlet weak var mainValue: UILabel!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var thirdStackValue: UILabel!
    @IBOutlet weak var thirdStackTitle: UILabel!
    @IBOutlet weak var secondStackValue: UILabel!
    @IBOutlet weak var secondStackTitle: UILabel!
    @IBOutlet weak var firstStackValue: UILabel!
    @IBOutlet weak var firstStackTitle: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    
    //MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    //MARK: - IBAction
    
    @IBAction func nextAction(_ sender: Any) {
        
    }
    
    //MARK: -  Functions
    
    func configDataOfInValidation(data:InValidationList?) {
        self.mainTitle.text = "SOLITITADO EN".localized
        self.firstStackTitle.text = "DESDE".localized
        self.secondStackTitle.text = "HASTA".localized
        self.thirdStackTitle.text = "DÍAS TOTALES".localized
        if let date = data?.createdAt?.getDateStringFromUTC().putDashes() {
            self.mainValue.text = date
        }
        else {
            self.mainValue.text = "--"
        }
        self.firstStackValue.text = data?.fromDate?.getDateStringFromUTC()
        self.secondStackValue.text = data?.toDate?.getDateStringFromUTC()
        self.thirdStackValue.text = "\(data?.totalDay ?? 0) \("DÍAS".localized)"
        self.setupStatus(id: data?.statusName)
    }
    
    func configDataOfRecords(data:RecordsList?) {
        self.mainTitle.text = "SOLITITADO EN".localized
        self.firstStackTitle.text = "DESDE".localized
        self.secondStackTitle.text = "HASTA".localized
        self.thirdStackTitle.text = "DÍAS TOTALES".localized
        if let date = data?.createdAt?.getDateStringFromUTC().putDashes() {
            self.mainValue.text = date
        }
        else {
            self.mainValue.text = "--"
        }
        
        self.firstStackValue.text = data?.fromDate?.getDateStringFromUTC()
        self.secondStackValue.text = data?.toDate?.getDateStringFromUTC()
        self.thirdStackValue.text = "\(data?.totalDay ?? 0) \("DÍAS".localized)"
        self.setupStatus(id: data?.statusName)
    }
    
    func setupStatus(id:String?) {
        if id == "HOLIDAY_PENDING_TO_VALIDATE" {
            self.statusValue.text = "HOLIDAY_PENDING_TO_VALIDATE".localized
            self.statusValue.textColor = UIColor(hexString: "707070")
            self.statusView.backgroundColor = UIColor(hexString: "707070") // gray
        }
        else
        if id == "HOLIDAY_DENIED" {
            self.statusValue.text = "HOLIDAY_DENIED".localized
            self.statusValue.textColor = UIColor(hexString: "BC0000")
            self.statusView.backgroundColor = UIColor(hexString: "BC0000") // red
        }
        else
        if id == "HOLIDAY_APPROVED" {
            self.statusValue.text = "HOLIDAY_APPROVED".localized
            self.statusValue.textColor = UIColor(hexString: "146F62")
            self.statusView.backgroundColor = UIColor(hexString: "146F62") // greeen
        }
        else
        if id == "HOLIDAY_CANCELED" {
            self.statusValue.text = "HOLIDAY_CANCELED".localized
            self.statusValue.textColor = UIColor(hexString: "F2A100") // yellow
            self.statusView.backgroundColor = UIColor(hexString: "F2A100")
        }
    }
}
