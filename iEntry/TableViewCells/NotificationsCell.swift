//
//  NotificationsCell.swift
//  iEntry
//
//  Created by ZAFAR on 14/08/2021.
//

import UIKit
import SDWebImage

class NotificationsCell: UITableViewCell {
    //MARK:- here are the IBOutlet
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var fileIconImg: UIImageView!
    @IBOutlet weak var lblfileName: UILabel!
    @IBOutlet weak var fileView: UIView!
    @IBOutlet weak var lblmeetingDate: UILabel!
    @IBOutlet weak var lbldetail: UILabel!
    @IBOutlet weak var attachedimg: UIImageView!
    @IBOutlet weak var lblusername: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var stackHeight: NSLayoutConstraint!
    var callBack:((_ extention:String,_ name:String)->Void)? = nil
    var imageshowCallBack :(()->Void)? = nil
    var obj : CreatedNotification?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))

        self.attachedimg.isUserInteractionEnabled = true
        self.attachedimg.addGestureRecognizer(tap)
        self.selectionStyle = .none
        mainView.shadowAndRoundcorner(cornerRadius: 8, shadowColor: #colorLiteral(red: 0.7293313146, green: 0.7294581532, blue: 0.7293233275, alpha: 1), shadowRadius: 4, shadowOpacity: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configdate(obj:CreatedNotification){
        self.obj = obj
        self.lbltitle.text = obj.notificationType
        self.lbldetail.text = obj.message
        self.lbldate.text =  getFormattedMilisecondstoDate(seconds:"\(obj.createdAt)", formatter: "")
        self.lblmeetingDate.text = "Fecha Reunión : ".localized + getFormattedMilisecondstoDate(seconds:"\(obj.Notificationtime)", formatter: "")
//        if obj.Notificationdate == "0" {
//            self.lblmeetingDate.isHidden = true
//            self.lblmeetingDate.text = "Fecha Reunión : ".localized + getFormattedMilisecondstoDate(seconds:"\(obj.Notificationdate)", formatter: "")
//        } else {
//            self.lblmeetingDate.isHidden = false
//            self.lblmeetingDate.text = "Fecha Reunión : ".localized + getFormattedMilisecondstoDate(seconds:"\(obj.Notificationdate)", formatter: "")
//        }
        self.lblusername.text = obj.username
        if obj.notificationType == "EVENT" {
            self.lblmeetingDate.isHidden = true
            img.image = UIImage(named: "notificationCalender")
        } else if obj.notificationType == "AD" {
            self.lblmeetingDate.isHidden = true
            img.image = UIImage(named: "notificationAd")
        } else if obj.notificationType == "MEETING" {
            self.lblmeetingDate.isHidden = false
            img.image = UIImage(named: "notificationComputer")
        }
        else if obj.notificationType == "OTHER" {
            self.lblmeetingDate.isHidden = true
            img.image = UIImage(named: "notificationOption")
        }
        else {
            self.lblmeetingDate.isHidden = true
            img.image = UIImage(named: "notificationMail")
        }
        
        mainView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        makeImage(extention: obj.path)
        if obj.path.contains("notification_file") {
            let replaced = obj.path.replacingOccurrences(of: "notification_file_", with: "")
            stackHeight.constant = 90
            self.fileView.isHidden = false
            self.attachedimg.isHidden = true
            fileIconImg.image = UIImage(named: "file")
            self.lblfileName.text = replaced
        } else if obj.path.contains("notification_image") {
            stackHeight.constant = 90
            self.fileView.isHidden = true
            self.attachedimg.isHidden = false
            self.attachedimg.image = UIImage(named: "iEntry_corporeta_large")!
//            self.downloadImageNotificationApi(notificationid: obj.id)
        }
        else {
            self.fileView.isHidden = true
            self.attachedimg.isHidden = true
            stackHeight.constant = 0
        }
    }
    
    func makeImage(extention:String) {
        if extention.contains("jpg".lowercased()) || extention.contains("jpeg".lowercased()) || extention.contains("png".lowercased()) {
            fileIconImg.image = UIImage(named: "jpg")
        }
        else if extention.contains("pdf".lowercased()){
            fileIconImg.image = UIImage(named: "pdf")
        }
        else if extention.contains("doc".lowercased()) || extention.contains("docx".lowercased()){
            fileIconImg.image = UIImage(named: "doc")
        }
        else if extention.contains("xls".lowercased()){
            fileIconImg.image = UIImage(named: "xls")
        }
        else {
            fileIconImg.image = UIImage(named: "file")
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        imageshowCallBack?()
    }
    
    func downloadImageNotificationApi(notificationid:String){
        userhandler.downloadNotificationimage(notificationid: notificationid, option: "notification_image", Success: {response in
            if response?.success == true  {
                self.attachedimg.image =  self.convierteImagen(base64String: response?.data ?? "") ?? UIImage()
                
            } else {
                
            }
        }, Failure: {error in
            print("image download error")
        })
    }
    
    @IBAction func dowloadFileAction(_ sender: UIButton) {
        let replaced = self.obj?.path.replacingOccurrences(of: "notification_file_", with: "") ?? "fileName"
        if let extention = replaced.components(separatedBy: ".").last , let name = replaced.components(separatedBy: ".").first {
            callBack?(String(extention), name)
        }
    }
    
    func getFormattedMilisecondstoDate(seconds: String , formatter:String) -> String {
        let epocTime = TimeInterval(Int(seconds) ?? 0)

        let myDate = Date(timeIntervalSince1970: epocTime / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        dateFormatter.timeZone = .current
//        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let dateString = dateFormatter.string(from: myDate)
        return dateString
    }
    func convierteImagen(base64String: String) -> UIImage? {
        if base64String != "" {
            let decodedData = NSData(base64Encoded: base64String, options: [])
                if let data = decodedData {
                    let decodedimage = UIImage(data: data as Data)
                    return  decodedimage ?? UIImage()
                } else {
                    print("error with decodedData")
                    return nil
                }
            } else {
                print("error with base64String")
                return nil
            }
        
    }
}

