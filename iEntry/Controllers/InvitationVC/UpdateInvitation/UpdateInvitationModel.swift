//
//  UpdateInvitationModel.swift
//  iEntry
//
//  Created by ZAFAR on 12/04/2022.
//

import Foundation
struct UpdateInvitationModel : Codable {
    let code : Int?
    let data : UpdateInvitationModelData?
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
        data = try values.decodeIfPresent(UpdateInvitationModelData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}


struct UpdateInvitationModelData : Codable {
    let id : String?
//    let host : Host?
//    let guest : Guest?
//    let status : Status?
//   // let event : String?
//    let zone : Zone?
//    let startDate : Int?
//    let endDate : String?
//    let guestNumber : Int?
//    let createdAt : Int?
//    let updatedAt : Int?
//    let sharePdf : String?
//    let organization : String?
//    let placeToPickUp : String?
//    let gzBadge : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
//        case host = "host"
//        case guest = "guest"
//        case status = "status"
       // case event = "event"
//        case zone = "zone"
//        case startDate = "startDate"
//        case endDate = "endDate"
//        case guestNumber = "guestNumber"
//        case createdAt = "createdAt"
//        case updatedAt = "updatedAt"
//        case sharePdf = "sharePdf"
//        case organization = "organization"
//        case placeToPickUp = "placeToPickUp"
//        case gzBadge = "gzBadge"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
//        host = try values.decodeIfPresent(Host.self, forKey: .host)
//        guest = try values.decodeIfPresent(Guest.self, forKey: .guest)
//        status = try values.decodeIfPresent(Status.self, forKey: .status)
       // event = try values.decodeIfPresent(String.self, forKey: .event)
//        zone = try values.decodeIfPresent(Zone.self, forKey: .zone)
//        startDate = try values.decodeIfPresent(Int.self, forKey: .startDate)
//        endDate = try values.decodeIfPresent(String.self, forKey: .endDate)
//        guestNumber = try values.decodeIfPresent(Int.self, forKey: .guestNumber)
//        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
//        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
//        sharePdf = try values.decodeIfPresent(String.self, forKey: .sharePdf)
//        organization = try values.decodeIfPresent(String.self, forKey: .organization)
//        placeToPickUp = try values.decodeIfPresent(String.self, forKey: .placeToPickUp)
//        gzBadge = try values.decodeIfPresent(String.self, forKey: .gzBadge)
    }

}
