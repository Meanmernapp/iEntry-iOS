//
//  RegisterComoanyModel.swift
//  iEntry
//
//  Created by ZAFAR on 16/10/2021.
//

import Foundation
struct CompanyRegisterModel : Codable {
    let code : Int?
    let data : CompanyRegisterData?
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
        data = try values.decodeIfPresent(CompanyRegisterData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
struct CompanyRegisterData : Codable {
    let id : String?
    let companyRestriction : CompanyRestriction?
    let status : Status?
    let acronym : String?
    let name : String?
    let address : String?
    let latitud : Double?
    let longitud : Double?
    let ip : String?
    let createdAt : Int?
    let updatedAt : Int?

    let lastName : String?
    let secondLastName : String?

    enum CodingKeys: String, CodingKey {
        case lastName = "lastName"
        case secondLastName = "secondLastName"
        case id = "id"
        case companyRestriction = "companyRestriction"
        case status = "status"
        case acronym = "acronym"
        case name = "name"
        case address = "address"
        case latitud = "latitud"
        case longitud = "longitud"
        case ip = "ip"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        companyRestriction = try values.decodeIfPresent(CompanyRestriction.self, forKey: .companyRestriction)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        acronym = try values.decodeIfPresent(String.self, forKey: .acronym)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        latitud = try values.decodeIfPresent(Double.self, forKey: .latitud)
        longitud = try values.decodeIfPresent(Double.self, forKey: .longitud)
        ip = try values.decodeIfPresent(String.self, forKey: .ip)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
    }


}


struct CompanyRestriction : Codable {
    let id : String?
    let sentEmail : Bool?
    let eventApproval : Bool?
    let extraDataEvent : Bool?
    let extraDataEmployee : Bool?
    let biocrValidation : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case sentEmail = "sentEmail"
        case eventApproval = "eventApproval"
        case extraDataEvent = "extraDataEvent"
        case extraDataEmployee = "extraDataEmployee"
        case biocrValidation = "biocrValidation"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        sentEmail = try values.decodeIfPresent(Bool.self, forKey: .sentEmail)
        eventApproval = try values.decodeIfPresent(Bool.self, forKey: .eventApproval)
        extraDataEvent = try values.decodeIfPresent(Bool.self, forKey: .extraDataEvent)
        extraDataEmployee = try values.decodeIfPresent(Bool.self, forKey: .extraDataEmployee)
        biocrValidation = try values.decodeIfPresent(Bool.self, forKey: .biocrValidation)
    }

}


//MARK:- Company Ristriction Model

struct CompanyRistriction : Codable {
    let code : Int?
    let data : CompanyRistrictionData?
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
        data = try values.decodeIfPresent(CompanyRistrictionData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}



struct CompanyRistrictionData : Codable {
    let id : String?
    let company : Company?
    let sentEmail : Bool?
    let eventApproval : Bool?
    let extraDataEvent : Bool?
    let extraDataEmployee : Bool?
    let biocrValidation : Bool?
    let driveService : Bool?
    let emailService : Bool?
    let eventValidation :Bool?
    let isOnuEvent :Bool?
    let sharePdfInMobileApp :Bool?
    let smsService: Bool?
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case company = "company"
        case sentEmail = "sentEmail"
        case eventApproval = "eventApproval"
        case extraDataEvent = "extraDataEvent"
        case extraDataEmployee = "extraDataEmployee"
        case biocrValidation = "biocrValidation"
        case driveService = "driveService"
        case emailService = "emailService"
        case eventValidation = "eventValidation"
        case isOnuEvent = "isOnuEvent"
        case sharePdfInMobileApp = "sharePdfInMobileApp"
        case smsService = "smsService"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        sentEmail = try values.decodeIfPresent(Bool.self, forKey: .sentEmail)
        eventApproval = try values.decodeIfPresent(Bool.self, forKey: .eventApproval)
        extraDataEvent = try values.decodeIfPresent(Bool.self, forKey: .extraDataEvent)
        extraDataEmployee = try values.decodeIfPresent(Bool.self, forKey: .extraDataEmployee)
        biocrValidation = try values.decodeIfPresent(Bool.self, forKey: .biocrValidation)
        driveService = try values.decodeIfPresent(Bool.self, forKey: .driveService)
        emailService = try values.decodeIfPresent(Bool.self, forKey: .emailService)
        eventValidation = try values.decodeIfPresent(Bool.self, forKey: .eventValidation)
        isOnuEvent = try values.decodeIfPresent(Bool.self, forKey: .isOnuEvent)
        sharePdfInMobileApp = try values.decodeIfPresent(Bool.self, forKey: .sharePdfInMobileApp)
        smsService = try values.decodeIfPresent(Bool.self, forKey: .smsService)
    }

}
