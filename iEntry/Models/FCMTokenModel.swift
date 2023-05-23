//
//  FCMTokenModel.swift
//  iEntry
//
//  Created by ZAFAR on 06/12/2021.
//

import Foundation
struct FCMTokenModel : Codable {
    let code : Int?
    let data : FCMTokenModelData?
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
        data = try values.decodeIfPresent(FCMTokenModelData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct FCMTokenModelData : Codable {
    let id : String?
    let status : Status?
    let userType : UserType?
//    let gender : String?
//    let extraData : String?
//    let name : String?
//    let phoneNumber : String?
//     let dob : Int?
//    let email : String?
//    let password : String?
//    let deviceId : String?
//    let firebaseId : String?
//    let secret : String?
//    let createdAt : String?
//    let updateAt : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case status = "status"
        case userType = "userType"
//        case gender = "gender"
//        case extraData = "extraData"
//        case name = "name"
//        case phoneNumber = "phoneNumber"
//        case dob = "dob"
//        case email = "email"
//        case password = "password"
//        case deviceId = "deviceId"
//        case firebaseId = "firebaseId"
//        case secret = "secret"
//        case createdAt = "createdAt"
//        case updateAt = "updateAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        userType = try values.decodeIfPresent(UserType.self, forKey: .userType)
//        gender = try values.decodeIfPresent(String.self, forKey: .gender)
//        extraData = try values.decodeIfPresent(String.self, forKey: .extraData)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
//        dob = try values.decodeIfPresent(Int.self, forKey: .dob)
//        email = try values.decodeIfPresent(String.self, forKey: .email)
//        password = try values.decodeIfPresent(String.self, forKey: .password)
//        deviceId = try values.decodeIfPresent(String.self, forKey: .deviceId)
//        firebaseId = try values.decodeIfPresent(String.self, forKey: .firebaseId)
//        secret = try values.decodeIfPresent(String.self, forKey: .secret)
//        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
//        updateAt = try values.decodeIfPresent(String.self, forKey: .updateAt)
    }

}
