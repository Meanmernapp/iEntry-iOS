//
//  InvitationsHistoryModel.swift
//  iEntry
//
//  Created by ZAFAR on 05/01/2022.
//

import Foundation
class InvitationsHistoryModel:NSObject, NSCoding {
    
    var name : String
    var phone:String
    var date:String
    var guestid :String
    var id:String
    init(name:String,phone:String,date:String,guestid:String,id:String) {
        self.name = name
        self.phone = phone
        self.date = date
        self.guestid = guestid
        self.id = id
    }
    
    required init(coder decoder: NSCoder) {
            self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.phone = decoder.decodeObject(forKey: "phone") as? String ?? ""
            self.date = decoder.decodeObject(forKey: "date") as? String ?? ""
        self.guestid = decoder.decodeObject(forKey: "guestid") as? String ?? ""
        self.id = decoder.decodeObject(forKey: "id") as? String ?? ""
        }
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(phone, forKey: "phone")
        coder.encode(date,forKey: "date")
        coder.encode(guestid,forKey: "guestid")
        coder.encode(id,forKey: "id")
    }
    
}
