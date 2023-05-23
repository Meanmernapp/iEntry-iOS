//
//  CreateNotificationModel.swift
//  iEntry
//
//  Created by ZAFAR on 27/01/2022.
//

import Foundation
struct CreateNotificationModel : Codable {
    let code : Int?
    let data : CreateNotificationModelData?
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
        data = try values.decodeIfPresent(CreateNotificationModelData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct CreateNotificationModelData : Codable {
    let id : String?
    let user : User?
    let company : Company?
    let notificationType : NotificationType?
    let type : String?
    let title : String?
    let message : String?
    let dateMeeting : Int?
    let path : String?
    let driveId : String?
    let file : String?
    let image : String?
    
    let createdAt : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user = "user"
        case company = "company"
        case notificationType = "notificationType"
        case type = "type"
        case title = "title"
        case message = "message"
        case dateMeeting = "dateMeeting"
        case path = "path"
        case driveId = "driveId"
        case file = "file"
        case image = "image"
        case createdAt = "createdAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        notificationType = try values.decodeIfPresent(NotificationType.self, forKey: .notificationType)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        dateMeeting = try values.decodeIfPresent(Int.self, forKey: .dateMeeting)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        driveId = try values.decodeIfPresent(String.self, forKey: .driveId)
        file = try values.decodeIfPresent(String.self, forKey: .file)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
    }

}
