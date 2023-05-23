//
//  GetAllZonesModel.swift
//  iEntry
//
//  Created by ZAFAR on 23/12/2021.
//

import Foundation
struct GetAllZonesModel : Codable {
    let code : Int?
    let data : [GetAllZonesModelData]?
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
        data = try values.decodeIfPresent([GetAllZonesModelData].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}


struct GetAllZonesModelData : Codable {
    let id : String?
    let name : String?
    let commonArea : String?
    let children : [String]?
    let status : Status?
    let createdAt : Int?
    let updatedAt : Int?

    let lastName : String?
    let secondLastName : String?

    enum CodingKeys: String, CodingKey {
        case lastName = "lastName"
        case secondLastName = "secondLastName"
        case id = "id"
        case name = "name"
        case commonArea = "commonArea"
        case children = "children"
        case status = "status"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        commonArea = try values.decodeIfPresent(String.self, forKey: .commonArea)
        children = try values.decodeIfPresent([String].self, forKey: .children)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
    }

}
