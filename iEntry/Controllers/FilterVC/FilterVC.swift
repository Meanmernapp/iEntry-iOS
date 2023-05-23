//
//  FilterVC.swift
//  iEntry
//
//  Created by ZAFAR on 12/08/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import DropDown
import SMDatePicker
class FilterVC: BaseController ,UITextFieldDelegate, SMDatePickerDelegate{
    
    //MARK:- here are iboutlet
    @IBOutlet weak var btndatetwo: UIButton!
    @IBOutlet weak var txtgraphics: MDCOutlinedTextField!
    @IBOutlet weak var btndateone: UIButton!
    
    @IBOutlet weak var btnfilter: UIButton!
    @IBOutlet weak var txtchoose: MDCOutlinedTextField!
    @IBOutlet weak var txtEnter: MDCOutlinedTextField!
    @IBOutlet weak var mainView: UIView!
    var MainDrowpDown = DropDown()
    var startdatePicker = UIDatePicker()
    var enddatePicker = UIDatePicker()
    //MARK:- datepicker
    var myDatePicker: SMDatePicker = SMDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       

        mainView.roundCorners([.topLeft,.topRight], radius: 20)
        TextFieldConfig()
        txtchoose.delegate  = self
        txtgraphics.delegate =  self
        txtEnter.delegate =  self
        
        datePickerConfig()
        
    }
    
    //MARK:- datepicker funtion to pick the date
    func datePickerConfig() {
        myDatePicker.delegate = self
    
        myDatePicker.toolbarBackgroundColor = UIColor.white
        myDatePicker.pickerBackgroundColor = UIColor.white
        myDatePicker.pickerMode = .date
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

    
    @objc func datePickerValueChanged(_ picker : UIDatePicker) {
        print(picker.date)
    }
    
    @IBAction func startDateAction(_ sender: Any) {
    
        myDatePicker.showPickerInView(view, animated: true)

    }
    //MARK:- datepicker delegates
    
    func  datePickerWillAppear(_ picker: SMDatePicker){
        print(picker.pickerDate)
        self.hideKeyboard()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        self.btndatetwo.setTitle(stringDate, for: .normal)
    }
    func datePickerDidAppear(_ picker: SMDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        self.btndatetwo.setTitle(stringDate, for: .normal)
    }

    private func  datePicker(picker: SMDatePicker, didPickDate date: NSDate) {
        print(date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        self.btndatetwo.setTitle(stringDate, for: .normal)
    }
    func  datePickerDidCancel(_ picker: SMDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        self.btndatetwo.setTitle(stringDate, for: .normal)
    }

    func  datePickerWillDisappear(_ picker: SMDatePicker) {
        print(picker.pickerDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        self.btndatetwo.setTitle(stringDate, for: .normal)
    }
    func  datePickerDidDisappear(_ picker: SMDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        self.btndatetwo.setTitle(stringDate, for: .normal)
    }

    
    
    
    
    @IBAction func sendateAction(_ sender: Any) {
        myDatePicker.showPickerInView(view, animated: true)

    }
    
    //MARK:- date picker tool funtion
    @objc func canceleDatePicker() {
       /// myDatePicker.hidePicker(true)
        myDatePicker.pressedCancel(self)
    }

    //Toolbar done button function
    @objc func onClickDoneButton() {
        myDatePicker.hidePicker(true)
        
    }

    
    
    @objc func pickerChnaged(_ picker : UIDatePicker){
        if picker == startdatePicker {
            print("Date :\(picker.date)")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd,MMMM, yyyy" //HH:mm
            let stringDate = dateFormatter.string(from: picker.date)
            self.btndateone.setTitle(stringDate, for: .normal)
            
        }else if picker == enddatePicker {
            print("Date :\(picker.date)")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy" //HH:mm
            let stringDate = dateFormatter.string(from: picker.date)
            self.btndatetwo.setTitle(stringDate, for: .normal)
        }
    }
    //MARK:- this funtion use to  set the textfiled UI
    func TextFieldConfig() {
        btnfilter.roundButtonWithCustomRadius(radius: 8)
        btndatetwo.roundButtonWithCustomRadius(radius: 5)
        btndateone.roundButtonWithCustomRadius(radius: 5)
        setMDCTxtFieldDesign(txtfiled: txtEnter, Placeholder: "QUE ENTRA", imageIcon: trailingImage)
        
        let number1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        txtEnter.trailingView?.addGestureRecognizer(number1)
        
        txtEnter.trailingView?.isUserInteractionEnabled = true
        
        setMDCTxtFieldDesign(txtfiled: txtchoose, Placeholder: "ELIGE UN VEHICULO", imageIcon: trailingImage)
        
        let number2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        txtchoose.trailingView?.addGestureRecognizer(number2)
        
        txtchoose.trailingView?.isUserInteractionEnabled = true
        
        setMDCTxtFieldDesign(txtfiled: txtgraphics, Placeholder: "TIPO DE GRAFICA", imageIcon: trailingImage)
        
        let number = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        txtgraphics.trailingView?.addGestureRecognizer(number)
        
        txtgraphics.trailingView?.isUserInteractionEnabled = true
    

    }
    var leadingImage: UIImage = {
      return UIImage.init(named: "eye-regular",
                          in: Bundle(for: ChangePasswordVC.self),
                          compatibleWith: nil) ?? UIImage()
    }()
    
    var trailingImage: UIImage = {
      return UIImage.init(named: "sort-down-solid",
                          in: Bundle(for: ChangePasswordVC.self),
                          compatibleWith: nil) ?? UIImage()
    }()
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
//        MainDrowpDown.anchorView = txt
//        MainDrowpDown.backgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        MainDrowpDown.selectionBackgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//
//        MainDrowpDown.dataSource =  ["a","b"]
//        DropDown.appearance().textColor = #colorLiteral(red: 0.5527616143, green: 0.5568413734, blue: 0.5609211326, alpha: 1)
//        DropDown.appearance().selectedTextColor = UIColor.red
//        //DropDown.appearance().textFont = UIFont(name: "JosefinSans-Regular", size: 18)!
//        self.MainDrowpDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
//
//            cell.optionLabel.textAlignment = .center
//
//        }
//
//        MainDrowpDown.bottomOffset = CGPoint(x: 0, y: btndropwdown.bounds.height)
//        MainDrowpDown.selectionAction = {(index: Int, item: String) in
//
////            self.txtselcted.text = item
////            self.question?.selectedAns = index
////            self.question?.answerText = item
////            self.delegate?.myclaimdropdown(cell:self, ind: index, Section: self.mysection  )
//
//
//
//        }
//        MainDrowpDown.show()
    }
    
    @IBAction func entryAction(_ sender: UIButton) {
        
        
            dropDownConfig(txtField: txtEnter, data: ["a","b","c"])
           
        
    }
    @IBAction func chooseActiojn(_ sender: UIButton) {
        
        
       
            dropDownConfig(txtField: txtchoose, data: ["a","b","c"])
           
        
      
    }
    @IBAction func graphicsAction(_ sender: UIButton) {
        
            dropDownConfig(txtField: txtgraphics, data: ["a","b","c"])
           
        
    }
    //MARK:- this is general funtion that will use to appear the dropdown
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
//            self.txtselcted.text = item
//            self.question?.selectedAns = index
//            self.question?.answerText = item
//            self.delegate?.myclaimdropdown(cell:self, ind: index, Section: self.mysection  )
            
            if self.txtchoose ==  txtField {
                txtchoose.text = item
            } else if txtgraphics == txtField {
                txtgraphics.text = item
            } else {
                txtEnter.text = item
            }
            
        }
        MainDrowpDown.show()
    }
    
    
    
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
//        if textField == txtchoose {
//            dropDownConfig(txtField: txtchoose, data: ["a","b","c"])
//            return true
//        }
//
//        if textField == txtgraphics {
//            dropDownConfig(txtField: txtgraphics, data: ["a","b","c"])
//            return true
//        }
//
//        if textField == txtEnter {
//            dropDownConfig(txtField: txtEnter, data: ["a","b","c"])
//            return true
//        }
        return true

    }
}
