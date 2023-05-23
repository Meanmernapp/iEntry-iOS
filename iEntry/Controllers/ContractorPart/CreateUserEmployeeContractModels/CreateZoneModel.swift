//
//  CreateZoneModel.swift
//  iEntry
//
//  Created by ZAFAR on 02/12/2021.
//

import Foundation
struct CreateZoneModel : Codable {
    let code : Int?
    let data : CreateZoneModelData?
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
        data = try values.decodeIfPresent(CreateZoneModelData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct CreateZoneModelData : Codable {
    let id : String?
    let name : String?
    let company : Company?
    let status : Status?
    let father : String?
    let createdAt : String?
    let updatedAt : String?
    let lastName : String?
    let secondLastName : String?

    enum CodingKeys: String, CodingKey {
        case lastName = "lastName"
        case secondLastName = "secondLastName"
        case id = "id"
        case name = "name"
        case company = "company"
        case status = "status"
        case father = "father"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        father = try values.decodeIfPresent(String.self, forKey: .father)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
    }

}
