//
//  CreateUserContractModel.swift
//  iEntry
//
//  Created by ZAFAR on 02/12/2021.
//

import Foundation
struct CreateUserContractModel : Codable {
    let code : Int?
    let data : CreateUserContractModelData?
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
        data = try values.decodeIfPresent(CreateUserContractModelData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct CreateUserContractModelData : Codable {
    let id : String?
    let user : User?
    let status : Status?
    let company : Company?
    let role : Role?
    let zone : Zone?
    let startDate : String?
    let endDate : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user = "user"
        case status = "status"
        case company = "company"
        case role = "role"
        case zone = "zone"
        case startDate = "startDate"
        case endDate = "endDate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        role = try values.decodeIfPresent(Role.self, forKey: .role)
        zone = try values.decodeIfPresent(Zone.self, forKey: .zone)
        startDate = try values.decodeIfPresent(String.self, forKey: .startDate)
        endDate = try values.decodeIfPresent(String.self, forKey: .endDate)
    }

}
