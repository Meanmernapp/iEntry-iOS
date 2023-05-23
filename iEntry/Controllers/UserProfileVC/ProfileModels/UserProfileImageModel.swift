//
//  UserProfileImageModel.swift
//  iEntry
//
//  Created by ZAFAR on 21/06/2022.
//

import Foundation

struct UserProfileImageModel : Codable {
    
    
    let code : Int?
    let data : UserProfileImageModelData?
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
        data = try values.decodeIfPresent(UserProfileImageModelData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    

}

struct UserProfileImageModelData : Codable {
    let createdAt : Int?
    let deleted : Bool?
    let description : String?
    let driveId : String?
    let id : String?
    let image : String?
    let path : String?
    let user : User?

    enum CodingKeys: String, CodingKey {
        case createdAt = "createdAt"
        case deleted = "deleted"
        case description = "description"
        case driveId = "driveId"
        case id = "id"
        case image = "image"
        case path = "path"
        case user = "user"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        driveId = try values.decodeIfPresent(String.self, forKey: .driveId)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        user = try values.decodeIfPresent(User.self, forKey: .user)
    }

}
