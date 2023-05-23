//
//  GenerateTokenModel.swift
//  iEntry
//
//  Created by ZAFAR on 15/10/2021.
//

import Foundation
struct GenerateTokenModel : Codable {
    let code : Int?
    let data : GenerateTokenDataModel?
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
        data = try values.decodeIfPresent(GenerateTokenDataModel.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct GenerateTokenDataModel : Codable {
   
    let username : String?
    let id : Int?
    enum CodingKeys: String, CodingKey {

       
        case username = "username"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
    }

}
