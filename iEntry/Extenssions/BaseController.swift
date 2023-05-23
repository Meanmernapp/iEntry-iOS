//
//  BaseController.swift
//  iEntry
//
//  Created by ZAFAR on 06/08/2021.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import ContactsUI
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MaterialComponents.MaterialTextControls_FilledTextAreasTheming
import MaterialComponents.MaterialTextControls_FilledTextFieldsTheming
import MaterialComponents.MaterialTextControls_OutlinedTextAreasTheming
import MaterialComponents.MaterialTextControls_OutlinedTextFieldsTheming
//import MaterialComponents.MaterialTextFields_Theming
var randomNumber = Int(arc4random_uniform(UInt32(5)))
class BaseController:UIViewController,NVActivityIndicatorViewable {
   var bas64userimg = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    func clearAllUserDefaults() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
    }
    
    func showLoader() {

      self.startAnimating(Constant.activitySize.size, message: Constant.loaderMessages.loadingMessage.rawValue,messageFont: UIFont.systemFont(ofSize: 20), type: NVActivityIndicatorType.lineSpinFadeLoader)
    }
    
    func hidLoader() {

      self.stopAnimating()
    }
    func setMDCTxtFieldDesign(txtfiled:MDCOutlinedTextField,Placeholder:String,imageIcon:UIImage) {
        
        //txtpassword.delegate = self
        
        //txtpassword.text = "Grace Hopper"
//        txtpassword.leadingView = UIImageView(image: leadingImage)
//        txtpassword.leadingViewMode = .always
        txtfiled.trailingView = UIImageView(image: imageIcon)
        txtfiled.trailingViewMode = .always
        txtfiled.label.text = Placeholder
        //txtpassword.placeholder = "555-555-5555"

        txtfiled.floatingLabelColor(for: .normal)
        txtfiled.tintColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
        txtfiled.setOutlineColor( #colorLiteral(red: 0.4391649365, green: 0.4392448664, blue: 0.4391598701, alpha: 1), for: .editing)
        txtfiled.setOutlineColor( .lightGray , for: .disabled)
        txtfiled.setOutlineColor( #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1) , for: .normal)
        txtfiled.containerRadius = 10
    }
    func setMDCTxtAreaDesign(txtfiled:MDCOutlinedTextArea,Placeholder:String,imageIcon:UIImage) {
        txtfiled.trailingView = UIImageView(image: imageIcon)
        txtfiled.trailingViewMode = .always
        txtfiled.label.text = Placeholder
        txtfiled.floatingLabelColor(for: .normal)
        txtfiled.tintColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
        txtfiled.setOutlineColor( #colorLiteral(red: 0.4391649365, green: 0.4392448664, blue: 0.4391598701, alpha: 1), for: .editing)
        txtfiled.setOutlineColor( .lightGray , for: .disabled)
        txtfiled.setOutlineColor( #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1) , for: .normal)
        txtfiled.containerRadius = 10
    }
    
    
    func dictoJson(dic:[String: String]) ->String {
        var json = ""
        let encoder = JSONEncoder()
                if let jsonData = try? encoder.encode(dic) {
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        json = jsonString
                        print("Nice Json", jsonString)
                    }
                }
        return json
    }
    @objc func hideKeyboard()
    {
      UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
        view.endEditing(true)
    }
    
    func convierteImagen(base64String: String) -> UIImage? {
        if base64String != "" {
            let decodedData = NSData(base64Encoded: base64String, options: [])
                if let data = decodedData {
                    let decodedimage = UIImage(data: data as Data)
                    self.bas64userimg = decodedimage ?? UIImage(named: "user-png")!
                } else {
                    print("error with decodedData")
                }
            } else {
                print("error with base64String")
            }
        return bas64userimg
    }
    
    
    func saveBase64StringToPDF(_ base64String: String,optionName:String,extention :String) -> Bool {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsUrl.appendingPathComponent("\(optionName).\(extention)")
        do {
            let convertedData = Data(base64Encoded: base64String)
            try convertedData?.write(to: fileURL, options: .atomic)
            print("File Write Successfully ")
            return true
        } catch {
            print("Failed Write")
            return false
        }
    }
    
    
    
    
    func alert(message:String) {
        // create the alert
                let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
    
    func getFormattedMilisecondstoDate(seconds: String , formatter:String) -> String {
        let epocTime = TimeInterval(Int(seconds) ?? 0)
        let myDate = Date(timeIntervalSince1970: epocTime / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        dateFormatter.timeZone = NSTimeZone(name: "en_US") as TimeZone?
        let dateString = dateFormatter.string(from: myDate)
        return dateString
    }
    func getMilisecondstoDate(seconds: String) -> Bool {

        let epocTime = TimeInterval(Int(seconds) ?? 0)
        let date = Date()
        
        let myDate = Date(timeIntervalSince1970: epocTime / 1000)
        if myDate < date {
            return true
        }
        else {
            return false
        }
    }
    
    
    func getMilisecondstoDate(seconds: String , formatter:String) -> String {
        let epocTime = TimeInterval(Int(seconds) ?? 0)
        let myDate = Date(timeIntervalSince1970: epocTime / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"  //UTC
        dateFormatter.timeZone = NSTimeZone(name: "en_US") as TimeZone?
        let dateString = dateFormatter.string(from: myDate)
        return dateString
    }
    
    func getMilisecondstoTime(seconds: String , formatter:String) -> String {
        let epocTime = TimeInterval(Int(seconds) ?? 0)
        let myDate = Date(timeIntervalSince1970: epocTime / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = NSTimeZone(name: "en_US") as TimeZone?
        let dateString = dateFormatter.string(from: myDate)
        return dateString
    }
    
    
    
    func getFormattedDate(string: String , formatter:String) -> String{
       let dateFormatterGet = DateFormatter()
       dateFormatterGet.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.SSSZ"//"yyyy-MM-dd'T'HH:mm:ssZ"

       let dateFormatterPrint = DateFormatter()
       dateFormatterPrint.dateFormat = formatter//"MMM/dd//yyyy h:mm a"

       let date: Date? = dateFormatterGet.date(from: string)
       //print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
       return dateFormatterPrint.string(from: date ?? Date());
   }
    
    func getCurrentDate() -> String{
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        let dateString = df.string(from: date)
       return dateString
   }
    
  func getCurrentTime() -> String{
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "HH:mm a"
        let dateString = df.string(from: date)
       return dateString
   }
    
    
    //MARK:- this giving hours 0, mintus 0, seconds 0 mean start of the day ,
    func startDay()->Int{
        let formatter = DateFormatter()

    let calendar = Calendar.current
    let newdate = calendar.date(bySettingHour: 0,
                             minute: 0,
                             second: 0, of: Date(),
                             matchingPolicy: .strict,
                             repeatedTimePolicy: .first,
                             direction: .backward)
    
    formatter.timeZone = TimeZone.current // defaults to GMT
    formatter.dateFormat = "yyyy-MM-dd HH:mm :ss"
    let string = formatter.string(from: newdate!)
    
    let dateFormatterGet = DateFormatter()
     dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm :ss"
    let date: Date? = dateFormatterGet.date(from: string)

   let timeInMiliSec = Int (date!.timeIntervalSince1970 * 1000)
    return timeInMiliSec
    }
    
    
    func StartDayMiliSeconds(newdate:Date) ->Int?{
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current // defaults to GMT
        formatter.dateFormat = "yyyy-MM-dd HH:mm :ss"
        let string = formatter.string(from: newdate)
        
        let dateFormatterGet = DateFormatter()
         dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm :ss"
        let date: Date? = dateFormatterGet.date(from: string)

       let timeInMiliSec = Int (date!.timeIntervalSince1970 * 1000)
        return timeInMiliSec
    }
    
    
    
    func getCountryCallingCode(countryRegionCode:String)->String{

            let prefixCodes = ["AF": "93", "AE": "971", "AL": "355", "AN": "599", "AS":"1", "AD": "376", "AO": "244", "AI": "1", "AG":"1", "AR": "54","AM": "374", "AW": "297", "AU":"61", "AT": "43","AZ": "994", "BS": "1", "BH":"973", "BF": "226","BI": "257", "BD": "880", "BB": "1", "BY": "375", "BE":"32","BZ": "501", "BJ": "229", "BM": "1", "BT":"975", "BA": "387", "BW": "267", "BR": "55", "BG": "359", "BO": "591", "BL": "590", "BN": "673", "CC": "61", "CD":"243","CI": "225", "KH":"855", "CM": "237", "CA": "1", "CV": "238", "KY":"345", "CF":"236", "CH": "41", "CL": "56", "CN":"86","CX": "61", "CO": "57", "KM": "269", "CG":"242", "CK": "682", "CR": "506", "CU":"53", "CY":"537","CZ": "420", "DE": "49", "DK": "45", "DJ":"253", "DM": "1", "DO": "1", "DZ": "213", "EC": "593", "EG":"20", "ER": "291", "EE":"372","ES": "34", "ET": "251", "FM": "691", "FK": "500", "FO": "298", "FJ": "679", "FI":"358", "FR": "33", "GB":"44", "GF": "594", "GA":"241", "GS": "500", "GM":"220", "GE":"995","GH":"233", "GI": "350", "GQ": "240", "GR": "30", "GG": "44", "GL": "299", "GD":"1", "GP": "590", "GU": "1", "GT": "502", "GN":"224","GW": "245", "GY": "595", "HT": "509", "HR": "385", "HN":"504", "HU": "36", "HK": "852", "IR": "98", "IM": "44", "IL": "972", "IO":"246", "IS": "354", "IN": "91", "ID":"62", "IQ":"964", "IE": "353","IT":"39", "JM":"1", "JP": "81", "JO": "962", "JE":"44", "KP": "850", "KR": "82","KZ":"77", "KE": "254", "KI": "686", "KW": "965", "KG":"996","KN":"1", "LC": "1", "LV": "371", "LB": "961", "LK":"94", "LS": "266", "LR":"231", "LI": "423", "LT": "370", "LU": "352", "LA": "856", "LY":"218", "MO": "853", "MK": "389", "MG":"261", "MW": "265", "MY": "60","MV": "960", "ML":"223", "MT": "356", "MH": "692", "MQ": "596", "MR":"222", "MU": "230", "MX": "52","MC": "377", "MN": "976", "ME": "382", "MP": "1", "MS": "1", "MA":"212", "MM": "95", "MF": "590", "MD":"373", "MZ": "258", "NA":"264", "NR":"674", "NP":"977", "NL": "31","NC": "687", "NZ":"64", "NI": "505", "NE": "227", "NG": "234", "NU":"683", "NF": "672", "NO": "47","OM": "968", "PK": "92", "PM": "508", "PW": "680", "PF": "689", "PA": "507", "PG":"675", "PY": "595", "PE": "51", "PH": "63", "PL":"48", "PN": "872","PT": "351", "PR": "1","PS": "970", "QA": "974", "RO":"40", "RE":"262", "RS": "381", "RU": "7", "RW": "250", "SM": "378", "SA":"966", "SN": "221", "SC": "248", "SL":"232","SG": "65", "SK": "421", "SI": "386", "SB":"677", "SH": "290", "SD": "249", "SR": "597","SZ": "268", "SE":"46", "SV": "503", "ST": "239","SO": "252", "SJ": "47", "SY":"963", "TW": "886", "TZ": "255", "TL": "670", "TD": "235", "TJ": "992", "TH": "66", "TG":"228", "TK": "690", "TO": "676", "TT": "1", "TN":"216","TR": "90", "TM": "993", "TC": "1", "TV":"688", "UG": "256", "UA": "380", "US": "1", "UY": "598","UZ": "998", "VA":"379", "VE":"58", "VN": "84", "VG": "1", "VI": "1","VC":"1", "VU":"678", "WS": "685", "WF": "681", "YE": "967", "YT": "262","ZA": "27" , "ZM": "260", "ZW":"263"]
            let countryDialingCode = prefixCodes[countryRegionCode]
            return countryDialingCode!

    }
}

extension UIImage {
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }

    func compress(to kb: Int, allowedMargin: CGFloat = 0.2) -> Data {
        let bytes = kb * 1024
        var compression: CGFloat = 1.0
        let step: CGFloat = 0.05
        var holderImage = self
        var complete = false
        while(!complete) {
            if let data = holderImage.jpegData(compressionQuality: 1.0) {
                let ratio = data.count / bytes
                if data.count < Int(CGFloat(bytes) * (1 + allowedMargin)) {
                    complete = true
                    return data
                } else {
                    let multiplier:CGFloat = CGFloat((ratio / 5) + 1)
                    compression -= (step * multiplier)
                }
            }
            
            guard let newImage = holderImage.resized(withPercentage: compression) else { break }
            holderImage = newImage
        }
        return Data()
    }
    
}
