//
//  CreateExtraUserDataModel.swift
//  iEntry
//
//  Created by ZAFAR on 02/12/2021.
//

import Foundation
struct CreateExtraUserDataModel : Codable {
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

//struct CreateExtraUserDataModelData : Codable {
//    let id : String?
//    let user : CreateExtraUserDataUser?
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
//        case user = "user"
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
//        user = try values.decodeIfPresent(CreateExtraUserDataUser.self, forKey: .user)
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
struct Gender : Codable {
    let id : Int?
    let name : String?

    let lastName : String?
    let secondLastName : String?

    enum CodingKeys: String, CodingKey {
        case lastName = "lastName"
        case secondLastName = "secondLastName"
        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
    }

}

struct CreateExtraUserDataUser : Codable {
    let id : String?
    let status : Status?
    let userType : UserType?
    let gender : Gender?
    let extraData : String?
    let name : String?
    let phoneNumber : String?
     let dob : Int?
    let email : String?
    let password : String?
    let deviceId : String?
    let firebaseId : String?
    let secret : String?
    let createdAt : String?
    let updateAt : String?

    let lastName : String?
    let secondLastName : String?

    enum CodingKeys: String, CodingKey {
        case lastName = "lastName"
        case secondLastName = "secondLastName"
        case id = "id"
        case status = "status"
        case userType = "userType"
        case gender = "gender"
        case extraData = "extraData"
        case name = "name"
        case phoneNumber = "phoneNumber"
        case dob = "dob"
        case email = "email"
        case password = "password"
        case deviceId = "deviceId"
        case firebaseId = "firebaseId"
        case secret = "secret"
        case createdAt = "createdAt"
        case updateAt = "updateAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        userType = try values.decodeIfPresent(UserType.self, forKey: .userType)
        gender = try values.decodeIfPresent(Gender.self, forKey: .gender)
        extraData = try values.decodeIfPresent(String.self, forKey: .extraData)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        dob = try values.decodeIfPresent(Int.self, forKey: .dob)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        deviceId = try values.decodeIfPresent(String.self, forKey: .deviceId)
        firebaseId = try values.decodeIfPresent(String.self, forKey: .firebaseId)
        secret = try values.decodeIfPresent(String.self, forKey: .secret)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updateAt = try values.decodeIfPresent(String.self, forKey: .updateAt)
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
    }

}
