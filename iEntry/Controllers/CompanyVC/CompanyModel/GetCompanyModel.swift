//
//  GetCompanyModel.swift
//  iEntry
//
//  Created by ZAFAR on 16/10/2021.
//

import Foundation
struct GetCompanyModel : Codable {
    let code : Int?
    let data : GetCompanData?
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
        data = try values.decodeIfPresent(GetCompanData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct GetCompanData : Codable {
    let id : Int?
    let name : String?
    let address : String?
    let acronym : String?
    let ip : String?
    let domain : String?
    let latitude : Double?
    let longitude : Double?
    let createdAt : String?
    let updatedAt : String?
    let statusId : Int?
    let lastName : String?
    let secondLastName : String?

    enum CodingKeys: String, CodingKey {
        case lastName = "lastName"
        case secondLastName = "secondLastName"
        case id = "id"
        case name = "name"
        case address = "address"
        case acronym = "acronym"
        case ip = "ip"
        case domain = "domain"
        case latitude = "latitude"
        case longitude = "longitude"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case statusId = "statusId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        acronym = try values.decodeIfPresent(String.self, forKey: .acronym)
        ip = try values.decodeIfPresent(String.self, forKey: .ip)
        domain = try values.decodeIfPresent(String.self, forKey: .domain)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        statusId = try values.decodeIfPresent(Int.self, forKey: .statusId)
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
    }

}
