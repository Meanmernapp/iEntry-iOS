//
//  VehicleInvitationModel.swift
//  iEntry
//
//  Created by ZAFAR on 12/05/2022.
//

import Foundation
struct VehicleInvitationModel : Codable {
    let code : Int?
    let data : [VehicleInvitationModelData]?
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
        data = try values.decodeIfPresent([VehicleInvitationModelData].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
       
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct VehicleInvitationModelData : Codable {
    let id : String?
//    let event : Event?
//    let vehicle : Vehicle?

    enum CodingKeys: String, CodingKey {

        case id = "id"
//        case event = "event"
//        case vehicle = "vehicle"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
//        event = try values.decodeIfPresent(Event.self, forKey: .event)
//        vehicle = try values.decodeIfPresent(Vehicle.self, forKey: .vehicle)
    }

}
