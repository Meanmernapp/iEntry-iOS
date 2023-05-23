//
//  userCompanyRestrictionModel.swift
//  iEntry
//
//  Created by ZAFAR on 23/06/2022.
//

import Foundation
struct userCompanyRestrictionModel : Codable {
    let code : Int?
    let data : userCompanyRestrictionModelData?
    let success : Bool?
    let message : String?
    let timestamp : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case data = "data"
        case success = "success"
        case message = "message"
        case timestamp = "timestamp"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        data = try values.decodeIfPresent(userCompanyRestrictionModelData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct userCompanyRestrictionModelData : Codable {
    let id : String?
    let company : Company?
    let emailService : Bool?
    let smsService : Bool?
    let driveService : Bool?
    let isOnuEvent : Bool?
    let fireArmsModule : Bool?
    let alertTimeIncomingEvent : Int?
    let alertTimeIncomingInvitation : Int?
    let biocrValidationExternal : Bool?
    let extraDataExternal : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case company = "company"
        case emailService = "emailService"
        case smsService = "smsService"
        case driveService = "driveService"
        case isOnuEvent = "isOnuEvent"
        case fireArmsModule = "fireArmsModule"
        case alertTimeIncomingEvent = "alertTimeIncomingEvent"
        case alertTimeIncomingInvitation = "alertTimeIncomingInvitation"
        case biocrValidationExternal = "biocrValidationExternal"
        case extraDataExternal = "extraDataExternal"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        emailService = try values.decodeIfPresent(Bool.self, forKey: .emailService)
        smsService = try values.decodeIfPresent(Bool.self, forKey: .smsService)
        driveService = try values.decodeIfPresent(Bool.self, forKey: .driveService)
        isOnuEvent = try values.decodeIfPresent(Bool.self, forKey: .isOnuEvent)
        fireArmsModule = try values.decodeIfPresent(Bool.self, forKey: .fireArmsModule)
        alertTimeIncomingEvent = try values.decodeIfPresent(Int.self, forKey: .alertTimeIncomingEvent)
        alertTimeIncomingInvitation = try values.decodeIfPresent(Int.self, forKey: .alertTimeIncomingInvitation)
        biocrValidationExternal = try values.decodeIfPresent(Bool.self, forKey: .biocrValidationExternal)
        extraDataExternal = try values.decodeIfPresent(Bool.self, forKey: .extraDataExternal)
    }

}
