//
//  CreateEventModels.swift
//  iEntry
//
//  Created by ZAFAR on 04/01/2022.
//

import Foundation
struct CommenAreasModels : Codable {
    let code : Int?
    let data : [CommenAreasModelsData]?
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
        data = try values.decodeIfPresent([CommenAreasModelsData].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

class CommenAreasModelsData : Codable {
    var zoneId : String?
    var isCommonArea:Bool?
    var name : String?
    var status : Status?
    var isSelected = false
    let lastName : String?
    let secondLastName : String?

    enum CodingKeys: String, CodingKey {
        case lastName = "lastName"
        case secondLastName = "secondLastName"
        case zoneId = "zoneId"
        case name = "name"
        case status = "status"
        case isCommonArea = "isCommonArea"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        zoneId = try values.decodeIfPresent(String.self, forKey: .zoneId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        isCommonArea = try values.decodeIfPresent(Bool.self, forKey: .isCommonArea)
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
    }

}
