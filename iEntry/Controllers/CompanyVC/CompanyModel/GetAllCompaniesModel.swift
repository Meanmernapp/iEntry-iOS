//
//  GetAllCompaniesModel.swift
//  iEntry
//
//  Created by ZAFAR on 02/12/2021.
//

import Foundation
struct GetAllCompaniesModel : Codable {
    let code : Int?
    let data : [GetAllCompaniesModelData]?
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
        data = try values.decodeIfPresent([GetAllCompaniesModelData].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct GetAllCompaniesModelData : Codable {
    let id : String?
    let companyRestriction : String?
    let status : Status?
    let acronym : String?
    let name : String?
    let address : String?
    let latitud : Double?
    let longitud : Double?
    let ip : String?
    let createdAt : String?
    let updatedAt : String?

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
        companyRestriction = try values.decodeIfPresent(String.self, forKey: .companyRestriction)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        acronym = try values.decodeIfPresent(String.self, forKey: .acronym)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        latitud = try values.decodeIfPresent(Double.self, forKey: .latitud)
        longitud = try values.decodeIfPresent(Double.self, forKey: .longitud)
        ip = try values.decodeIfPresent(String.self, forKey: .ip)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
    }

}
