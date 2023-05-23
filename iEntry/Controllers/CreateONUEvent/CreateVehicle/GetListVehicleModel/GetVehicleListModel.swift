//
//  GetVehicleListModel.swift
//  iEntry
//
//  Created by ZAFAR on 10/05/2022.
//

import Foundation
struct GetVehicleListModel : Codable {
    let code : Int?
    let data : [GetVehicleListModelData]?
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
        data = try values.decodeIfPresent([GetVehicleListModelData].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct GetVehicleListModelData : Codable {
    let id : String?
    let vehicle : Vehicle?
    let user : User?
    let company : Company?
    let tag : Tag?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case vehicle = "vehicle"
        case user = "user"
        case company = "company"
        case tag = "tag"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        vehicle = try values.decodeIfPresent(Vehicle.self, forKey: .vehicle)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        tag = try values.decodeIfPresent(Tag.self, forKey: .tag)
    }

}

struct Vehicle : Codable {
    let id : String?
    let status : Status?
    let brand : String?
    let model : Int?
    let color : String?
    let plate : String?
    let serialNumber : String?
    let createdAt : Int?
    let updatedAt : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case status = "status"
        case brand = "brand"
        case model = "model"
        case color = "color"
        case plate = "plate"
        case serialNumber = "serialNumber"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        brand = try values.decodeIfPresent(String.self, forKey: .brand)
        model = try values.decodeIfPresent(Int.self, forKey: .model)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        plate = try values.decodeIfPresent(String.self, forKey: .plate)
        serialNumber = try values.decodeIfPresent(String.self, forKey: .serialNumber)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }

}

struct Tag : Codable {
    let id : String?
    let tag : String?
    let status : Status?
    let createdAt : Int?
    let updatedAt : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case tag = "tag"
        case status = "status"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        tag = try values.decodeIfPresent(String.self, forKey: .tag)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }

}
