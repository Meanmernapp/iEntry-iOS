//
//  CreateEventModel.swift
//  iEntry
//
//  Created by ZAFAR on 06/01/2022.
//

import Foundation
struct CreateEventModel : Codable {
    let code : Int?
    let data : CreateEventModelData?
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
        data = try values.decodeIfPresent(CreateEventModelData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct CreateEventModelData : Codable {
    let id : String?
//    let user : User?
//    let reservation : Reservation?
//    let name : String?
//    let description : String?
//    let wasApprove : String?
//    let startDate : Int?
//    let endDate : Int?
//    let createdAt : Int?
//    let updatedAt : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
//        case user = "user"
//        case reservation = "reservation"
//        case name = "name"
//        case description = "description"
//        case wasApprove = "wasApprove"
//        case startDate = "startDate"
//        case endDate = "endDate"
//        case createdAt = "createdAt"
//        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
//        user = try values.decodeIfPresent(User.self, forKey: .user)
//        reservation = try values.decodeIfPresent(Reservation.self, forKey: .reservation)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
//        wasApprove = try values.decodeIfPresent(String.self, forKey: .wasApprove)
//        startDate = try values.decodeIfPresent(Int.self, forKey: .startDate)
//        endDate = try values.decodeIfPresent(Int.self, forKey: .endDate)
//        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
//        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }

}
