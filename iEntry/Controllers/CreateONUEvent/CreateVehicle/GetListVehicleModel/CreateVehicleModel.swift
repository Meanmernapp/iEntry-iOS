//
//  CreateVehicleModel.swift
//  iEntry
//
//  Created by ZAFAR on 11/05/2022.
//

import Foundation
struct CreateVehicleModel : Codable {
    let code : Int?
    let data : CreateVehicleModelData?
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
        data = try values.decodeIfPresent(CreateVehicleModelData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct CreateVehicleModelData : Codable {
    let id : String?
    let vehicle : Vehicle?
    let user : User?
    let company : Company?
    let tag : String?

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
        tag = try values.decodeIfPresent(String.self, forKey: .tag)
    }

}
