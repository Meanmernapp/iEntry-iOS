//
//  NotificationsSaveLocaly.swift
//  iEntry
//
//  Created by ZAFAR on 28/01/2022.
//

import Foundation
class CreatedNotification:NSObject, NSCoding,Codable {
    
    var qualification:String
    var message:String
    var notificationkind:String
    var Notificationtime:String
    var Notificationdate:String
    var notificationType:String
    var notificationID:Int
    var username :String
    var createdAt :String
    var type : String
    var dateMeeting: String
    var path: String
    var driveId:String
    var file: String
    var image: String
    var id:String
    var email:String
    init(qualification:String,message:String,notificationkind:String,Notificationtime:String,Notificationdate:String,notificationType:String,username :String,createdAt:String,type:String,dateMeeting:String,path:String,driveId:String,file:String,image:String,id:String,notificationID:Int,email:String) {
        self.qualification = qualification
        self.message = message
        self.notificationkind = notificationkind
        self.Notificationtime =  Notificationtime
        self.Notificationdate = Notificationdate
        self.notificationType = notificationType
        self.notificationID = notificationID
        self.username = username
        self.createdAt = createdAt
        self.type = type
        self.dateMeeting = dateMeeting
        self.path = path
        self.driveId = driveId
        self.file = file
        self.image = image
        self.id = id
        self.email = email
        
    }
    
    required init(coder decoder: NSCoder) {
            self.qualification = decoder.decodeObject(forKey: "qualification") as? String ?? ""
        self.message = decoder.decodeObject(forKey: "message") as? String ?? ""
            self.notificationkind = decoder.decodeObject(forKey: "notificationkind") as? String ?? ""
        self.Notificationtime = decoder.decodeObject(forKey: "Notificationtime") as? String ?? ""
        self.Notificationdate = decoder.decodeObject(forKey: "Notificationdate") as? String ?? ""
        self.notificationType = decoder.decodeObject(forKey: "notificationType") as? String ?? ""
        self.username = decoder.decodeObject(forKey: "username") as? String ?? ""
        self.createdAt = decoder.decodeObject(forKey: "createdAt") as? String ?? ""
        self.type = decoder.decodeObject(forKey: "type") as? String ?? ""
        self.dateMeeting = decoder.decodeObject(forKey: "dateMeeting") as? String ?? ""
        self.path = decoder.decodeObject(forKey: "path") as? String ?? ""
        self.driveId = decoder.decodeObject(forKey: "driveId") as? String ?? ""
        self.file = decoder.decodeObject(forKey: "file") as? String ?? ""
        self.notificationID = decoder.decodeObject(forKey: "notificationAbc") as? Int ?? -1
        self.image = decoder.decodeObject(forKey: "image") as? String ?? ""
        self.id = decoder.decodeObject(forKey: "id") as? String ?? ""
        self.email = decoder.decodeObject(forKey: "email") as? String ?? ""
        
        }
    func encode(with coder: NSCoder) {
        coder.encode(qualification, forKey: "qualification")
        coder.encode(message, forKey: "message")
        coder.encode(notificationkind,forKey: "notificationkind")
        coder.encode(Notificationtime,forKey: "Notificationtime")
        
        coder.encode(Notificationdate,forKey: "Notificationdate")
        coder.encode(notificationType,forKey: "notificationType")
        coder.encode(username,forKey: "username")
        coder.encode(createdAt,forKey: "createdAt")
        coder.encode(type,forKey: "type")
        coder.encode(notificationID,forKey: "notificationAbc")
        coder.encode(dateMeeting,forKey: "dateMeeting")
        coder.encode(path,forKey: "path")
        coder.encode(driveId,forKey: "driveId")
        coder.encode(file,forKey: "file")
        coder.encode(image,forKey: "image")
        coder.encode(id,forKey: "id")
        coder.encode(id,forKey: "email")
        
    }
}
