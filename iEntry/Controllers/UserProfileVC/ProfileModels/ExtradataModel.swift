//
//  ExtradataModel.swift
//  iEntry
//
//  Created by ZAFAR on 31/01/2022.
//

import Foundation
struct ExtradataModel : Codable {
    let code : Int?
    let data : ExtraData?
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
        data = try values.decodeIfPresent(ExtraData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
//struct ExtradataModelData : Codable {
//    let id : String?
//    let town : String?
//    let country : String?
//    let postalCode : String?
//    let homePhone : String?
//    let arabicName : String?
//    let bloodType : String?
//    let contractorName : String?
//    let note : String?
//    let wasVaccinated : Bool?
//    let address1 : String?
//    let address2 : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case town = "town"
//        case country = "country"
//        case postalCode = "postalCode"
//        case homePhone = "homePhone"
//        case arabicName = "arabicName"
//        case bloodType = "bloodType"
//        case contractorName = "contractorName"
//        case note = "note"
//        case wasVaccinated = "wasVaccinated"
//        case address1 = "address1"
//        case address2 = "address2"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        town = try values.decodeIfPresent(String.self, forKey: .town)
//        country = try values.decodeIfPresent(String.self, forKey: .country)
//        postalCode = try values.decodeIfPresent(String.self, forKey: .postalCode)
//        homePhone = try values.decodeIfPresent(String.self, forKey: .homePhone)
//        arabicName = try values.decodeIfPresent(String.self, forKey: .arabicName)
//        bloodType = try values.decodeIfPresent(String.self, forKey: .bloodType)
//        contractorName = try values.decodeIfPresent(String.self, forKey: .contractorName)
//        note = try values.decodeIfPresent(String.self, forKey: .note)
//        wasVaccinated = try values.decodeIfPresent(Bool.self, forKey: .wasVaccinated)
//        address1 = try values.decodeIfPresent(String.self, forKey: .address1)
//        address2 = try values.decodeIfPresent(String.self, forKey: .address2)
//    }
//
//}
