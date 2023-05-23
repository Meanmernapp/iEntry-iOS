//
//  CalenderViewController.swift
//  Earth Quacks
//
//  Created by Shoaib on 30/03/2023.
//

import UIKit
import HorizonCalendar

class CalenderViewController: CalenderBaseViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var parentCalenderView: UIView!
    @IBOutlet weak var selectDataBtn: UIButton!
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var topTitle: UILabel!
    //MARK: - Variables
    
    var callback : ((String,String) -> Void)?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - IBAction
    
    @IBAction func selectAction(_ sender: Any) {
        if let selectedDayRange {
            callback?(selectedDayRange.lowerBound.description,selectedDayRange.upperBound.description)
            self.dismiss(animated: true)
        }
    }
    
    //MARK: -  UIFunction
    
    func setupUI() {
        self.selectDataBtn.setTitle("Seleccionar fechas".localized, for: .normal)
        self.topTitle.text = "Seleccionar fechas".localized
        selectDataBtn.alpha = 0.5
        selectDataBtn.isEnabled = false
        self.calendarView.frame = CGRect(x: 0, y: 0, width: parentCalenderView.bounds.width, height: parentCalenderView.bounds.height)
        self.calendarView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        self.parentCalenderView.addSubview(calendarView)
//        calendarView.scroll(toMonthContaining: Date(), scrollPosition: .centered, animated: true)
        calendarView.daySelectionHandler = { [weak self] day in
            guard let self else { return }
            let calendar = Calendar.current
            let todayDate = Date()
            let selectedDate = calendar.date(from: DateComponents(year: day.month.year, month: day.month.month, day: day.day))!
            if selectedDate < todayDate {
                AppUtility.showInfoMessage(message: "No puede seleccionar una fecha del pasado".localized)
                return
            }
            DayRangeSelectionHelper.updateDayRange(
                afterTapSelectionOf: day,
                existingDayRange: &self.selectedDayRange)
            
            self.calendarView.setContent(self.makeContent())
            if self.selectedDayRange?.upperBound == self.selectedDayRange?.lowerBound {
                self.selectDataBtn.alpha = 0.5
                self.selectDataBtn.isEnabled = false
            }
            else {
                self.selectDataBtn.alpha = 1
                self.selectDataBtn.isEnabled = true
            }
            print(self.selectedDayRange ?? "")
        }
    }
    
}
