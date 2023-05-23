//
//  GetAllInvitationModel.swift
//  iEntry
//
//  Created by ZAFAR on 22/12/2021.
//

import Foundation
struct GetallInvitationModel : Codable {
    let code : Int?
    let data : [GetallInvitationModelData]?
    let success : Bool?
    let message : String?
    let status : String?
}


struct GetallInvitationModelData : Codable {
    
    let id : String?
    let host : Host?
    let guest : Guest?
    let status : Status?
    let event : Event?
    let zone : Zone?
    let startDate : Int?
    let endDate : Int?
    let guestNumber : Int?
    let createdAt : Int?
    let updatedAt : Int?
    let sharePdf : Bool?
    let organization : String?
    let placeToPickUp : String?
    let gzBadge : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case host = "host"
        case guest = "guest"
        case status = "status"
        case event = "event"
        case zone = "zone"
        case startDate = "startDate"
        case endDate = "endDate"
        case guestNumber = "guestNumber"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case sharePdf = "sharePdf"
        case organization = "organization"
        case placeToPickUp = "placeToPickUp"
        case gzBadge = "gzBadge"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        host = try values.decodeIfPresent(Host.self, forKey: .host)
        guest = try values.decodeIfPresent(Guest.self, forKey: .guest)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        do {
            event = try values.decodeIfPresent(Event.self, forKey: .event)
        }
        catch {
            event = nil
        }
        zone = try values.decodeIfPresent(Zone.self, forKey: .zone)
        startDate = try values.decodeIfPresent(Int.self, forKey: .startDate)
        endDate = try values.decodeIfPresent(Int.self, forKey: .endDate)
        guestNumber = try values.decodeIfPresent(Int.self, forKey: .guestNumber)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
        sharePdf = try values.decodeIfPresent(Bool.self, forKey: .sharePdf)
        organization = try values.decodeIfPresent(String.self, forKey: .organization)
        placeToPickUp = try values.decodeIfPresent(String.self, forKey: .placeToPickUp)
        gzBadge = try values.decodeIfPresent(Bool.self, forKey: .gzBadge)
    }

    
    
    
    
    
//    let id : String?
//    let manager : Manager?
//    let guest : Guest?
//    let event : String?
//    let zone : Zone?
//    let startDate : Int?
//    let guestNumber : Int?
//    let attend : String?
//    let createdAt : Int?
//    let updatedAt : Int?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case manager = "manager"
//        case guest = "guest"
//        case event = "event"
//        case zone = "zone"
//        case startDate = "startDate"
//        case guestNumber = "guestNumber"
//        case attend = "attend"
//        case createdAt = "createdAt"
//        case updatedAt = "updatedAt"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        manager = try values.decodeIfPresent(Manager.self, forKey: .manager)
//        guest = try values.decodeIfPresent(Guest.self, forKey: .guest)
//        event = try values.decodeIfPresent(String.self, forKey: .event)
//        zone = try values.decodeIfPresent(Zone.self, forKey: .zone)
//        startDate = try values.decodeIfPresent(Int.self, forKey: .startDate)
//        guestNumber = try values.decodeIfPresent(Int.self, forKey: .guestNumber)
//        attend = try values.decodeIfPresent(String.self, forKey: .attend)
//        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
//        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
//    }

}

struct Guest : Codable {
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

struct Manager : Codable {
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

struct Host : Codable {
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
