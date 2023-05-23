//
//  EventModels.swift
//  iEntry
//
//  Created by ZAFAR on 04/01/2022.
//

import Foundation


struct EventModule : Codable {
    //    let code : Int?
    //    let data : [EventModuleData]?
    //    let success : Bool?
    //    let message : String?
    //    let timestamp : String?
    //    let status : String?
    let code : Int?
    let data : [EventModuleData]?
    let success : Bool?
    let message : String?
    
    let status : String?
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case data = "data"
        case success = "success"
        case message = "message"
        
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        data = try values.decodeIfPresent([EventModuleData].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}
struct EventModuleData : Codable {
    
    let id : String?
    let user : User?
    let host : Host?
    //let validatedBy : ValidatedBy?
    let reservation : Reservation?
    let status : Status?
    let name : String?
    let visitPurpose : String?
    let startDate : Int?
    let endDate : Int?
    let duration : Int?
    let userInvitationNo : Int?
    let vehicleInvitationNo : Int?
    let createdAt : Int?
    let updatedAt : Int?
    //    let accompanied : String?
    //    let unitSection : String?
    //    let visitorComment : String?
    //    let validationComment : String?
    //    let requiredTransportation : String?
    
    let lastName : String?
    let secondLastName : String?
    
    enum CodingKeys: String, CodingKey {
        case lastName = "lastName"
        case secondLastName = "secondLastName"
        case id = "id"
        case user = "user"
        case host = "host"
        //case validatedBy = "validatedBy"
        case reservation = "reservation"
        case status = "status"
        case name = "name"
        case visitPurpose = "visitPurpose"
        case startDate = "startDate"
        case endDate = "endDate"
        case duration = "duration"
        case userInvitationNo = "userInvitationNo"
        case vehicleInvitationNo = "vehicleInvitationNo"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        //        case accompanied = "accompanied"
        //        case unitSection = "unitSection"
        //        case visitorComment = "visitorComment"
        //        case validationComment = "validationComment"
        //        case requiredTransportation = "requiredTransportation"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        host = try values.decodeIfPresent(Host.self, forKey: .host)
        do {
            let d = try? values.decodeIfPresent(Reservation.self, forKey: .reservation)
            if d != nil {
                reservation = d
            } else {
                reservation =  nil
            }
        } catch{
            print("nil Value")
            reservation =  nil
            
        }
        
        
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        visitPurpose = try values.decodeIfPresent(String.self, forKey: .visitPurpose)
        startDate = try values.decodeIfPresent(Int.self, forKey: .startDate)
        endDate = try values.decodeIfPresent(Int.self, forKey: .endDate)
        duration = try values.decodeIfPresent(Int.self, forKey: .duration)
        userInvitationNo = try values.decodeIfPresent(Int.self, forKey: .userInvitationNo)
        vehicleInvitationNo = try values.decodeIfPresent(Int.self, forKey: .vehicleInvitationNo)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
    }
    
}




struct ValidatedBy : Codable {
    let id : String?
    let status : Status?
    let userType : UserType?
    let gender : Gender?
    let name : String?
    let phoneNumber : String?
    let dob : Int?
    let email : String?
    let deviceId : String?
    let firebaseId : String?
    let secret : String?
    let createdAt : Int?
    let updatedAt : Int?
    
    let lastName : String?
    let secondLastName : String?
    
    enum CodingKeys: String, CodingKey {
        case lastName = "lastName"
        case secondLastName = "secondLastName"
        case id = "id"
        case status = "status"
        case userType = "userType"
        case gender = "gender"
        case name = "name"
        case phoneNumber = "phoneNumber"
        case dob = "dob"
        case email = "email"
        case deviceId = "deviceId"
        case firebaseId = "firebaseId"
        case secret = "secret"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        userType = try values.decodeIfPresent(UserType.self, forKey: .userType)
        gender = try values.decodeIfPresent(Gender.self, forKey: .gender)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        dob = try values.decodeIfPresent(Int.self, forKey: .dob)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        deviceId = try values.decodeIfPresent(String.self, forKey: .deviceId)
        firebaseId = try values.decodeIfPresent(String.self, forKey: .firebaseId)
        secret = try values.decodeIfPresent(String.self, forKey: .secret)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
    }
    
}




struct Reservation : Codable {
    let id : String?
    let zone : Zone?
    let fromDate : Int?
    let toDate : Int?
    let createdAt : Int?
    let updatedAt : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case zone = "zone"
        case fromDate = "fromDate"
        case toDate = "toDate"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        zone = try values.decodeIfPresent(Zone.self, forKey: .zone)
        fromDate = try values.decodeIfPresent(Int.self, forKey: .fromDate)
        toDate = try values.decodeIfPresent(Int.self, forKey: .toDate)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }
    
}

struct OnuEvent : Codable {
    let code : Int?
    let data : OnuEventData?
    let success : Bool?
    let message : String?
    
    let status : String?
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case data = "data"
        case success = "success"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        data = try values.decodeIfPresent(OnuEventData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}
struct OnuEventData : Codable {
    let id : Int?
    let isOnuEvent:Bool?
    let alertTimeIncoming:Int?
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case isOnuEvent = "isOnuEvent"
        case alertTimeIncoming = "alertTimeIncoming"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        isOnuEvent = try values.decodeIfPresent(Bool.self, forKey: .isOnuEvent)
        alertTimeIncoming = try values.decodeIfPresent(Int.self, forKey: .alertTimeIncoming)
    }
    
}
