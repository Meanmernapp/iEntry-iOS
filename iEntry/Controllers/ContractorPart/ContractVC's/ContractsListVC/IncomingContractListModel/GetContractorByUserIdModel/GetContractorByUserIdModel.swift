//
//  GetContractorByUserIdModel.swift
//  iEntry
//
//  Created by ZAFAR on 22/02/2022.
//

import Foundation
struct GetContractorByUserIdModel : Codable {
    let code : Int?
    let data : GetContractorByUserIdModelData?
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
        data = try values.decodeIfPresent(GetContractorByUserIdModelData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
struct GetVehicalByUserIdModel : Codable {
    let code : Int?
    let data : [VehicalModelData]?
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
        data = try values.decodeIfPresent([VehicalModelData].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct GetContractorByUserIdModelData : Codable {
    let id : String?
    let user : User?
    let status : Status?
    let company : Company?
    let acronym : String?
    let contractorCompanyName : String?
    let createdAt : Int?
    let updatedAt : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user = "user"
        case status = "status"
        case company = "company"
        case acronym = "acronym"
        case contractorCompanyName = "contractorCompanyName"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        acronym = try values.decodeIfPresent(String.self, forKey: .acronym)
        contractorCompanyName = try values.decodeIfPresent(String.self, forKey: .contractorCompanyName)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }

}
struct VehicalModelData : Codable {
    let id : String?
    let status : Int?
    let brand : String?
    let subBrand : String?
    let model : Int?
    let color : String?
    let plate : String?
    let serialNumber : String?
    let vin : String?
    let createdAt : Int?
    let updatedAt : Int?
    let image : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case status = "statusId"
        case brand = "brand"
        case subBrand = "subBrand"
        case model = "model"
        case color = "color"
        case plate = "plate"
        case vin = "vin"
        case image = "image"
        case serialNumber = "serialNumber"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        brand = try values.decodeIfPresent(String.self, forKey: .brand)
        subBrand = try values.decodeIfPresent(String.self, forKey: .subBrand)
        model = try values.decodeIfPresent(Int.self, forKey: .model)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        plate = try values.decodeIfPresent(String.self, forKey: .plate)
        serialNumber = try values.decodeIfPresent(String.self, forKey: .serialNumber)
        vin = try values.decodeIfPresent(String.self, forKey: .vin)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }

}

struct GetEmployeeByUserIdModel : Codable {
    let code : Int?
    let data : [EmployeeUserDetailsData]?
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
        data = try values.decodeIfPresent([EmployeeUserDetailsData].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct EmployeeUserDetailsData : Codable {
    
    let createdAt : Int?
    let deviceId : String?
    let dob : Int?
    let email : String?
    let extraDataId : String?
    var field1 = "-"
    var field2 = "-"
    var field3 = "-"
    var field4 = "-"
    var field5 = "-"
    var field6 = "-"
    var field7 = "-"
    var field8 = "-"
    var field9 = "-"
    var field10 = "-"
    var field11 = "-"
    var field12 = "-"
    var field13 = "-"
    var field14 = "-"
    var field15 = "-"
    let firebaseId : String?
    let genderID : Int?
    let id : String?
    let name : String?
    let password : String?
    let phoneNumber : String?
    let showOnboarding : Bool?
    let updatedAt : Int?
    let statusId : Int?
    let userTypeId : Int?

    let lastName : String?
    let secondLastName : String?

    enum CodingKeys: String, CodingKey {
        case lastName = "lastName"
        case secondLastName = "secondLastName"
        case id = "id"
        case field1 = "field1"
        case field2 = "field2"
        case field3 = "field3"
        case field4 = "field4"
        case field5 = "field5"
        case field6 = "field6"
        case field7 = "field7"
        case field8 = "field8"
        case field9 = "field9"
        case field10 = "field10"
        case field11 = "field11"
        case field12 = "field12"
        case field13 = "field13"
        case field14 = "field14"
        case field15 = "field15"
        case name = "name"
        case genderID = "genderId"
        case extraDataId = "extraDataId"
        case phoneNumber = "phoneNumber"
        case dob = "dob"
        case email = "email"
        case password = "password"
        case deviceId = "deviceId"
        case firebaseId = "firebaseId"
        case showOnboarding = "showOnboarding"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case statusId = "statusId"
        case userTypeId = "userTypeId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        extraDataId = try values.decodeIfPresent(String.self, forKey: .extraDataId)
        field1 = try values.decodeIfPresent(String.self, forKey: .field1) ?? "---"
        field2 = try values.decodeIfPresent(String.self, forKey: .field2) ?? "---"
        field3 = try values.decodeIfPresent(String.self, forKey: .field3) ?? "---"
        field4 = try values.decodeIfPresent(String.self, forKey: .field4) ?? "---"
        field5 = try values.decodeIfPresent(String.self, forKey: .field5) ?? "---"
        field6 = try values.decodeIfPresent(String.self, forKey: .field6) ?? "---"
        field7 = try values.decodeIfPresent(String.self, forKey: .field7) ?? "---"
        field8 = try values.decodeIfPresent(String.self, forKey: .field8) ?? "---"
        field9 = try values.decodeIfPresent(String.self, forKey: .field9) ?? "---"
        field10 = try values.decodeIfPresent(String.self, forKey: .field10) ?? "---"
        field11 = try values.decodeIfPresent(String.self, forKey: .field11) ?? "---"
        field12 = try values.decodeIfPresent(String.self, forKey: .field12) ?? "---"
        field13 = try values.decodeIfPresent(String.self, forKey: .field13) ?? "---"
        field14 = try values.decodeIfPresent(String.self, forKey: .field14) ?? "---"
        field15 = try values.decodeIfPresent(String.self, forKey: .field15) ?? "---"
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        dob = try values.decodeIfPresent(Int.self, forKey: .dob)
        genderID = try values.decodeIfPresent(Int.self, forKey: .genderID)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        deviceId = try values.decodeIfPresent(String.self, forKey: .deviceId)
        firebaseId = try values.decodeIfPresent(String.self, forKey: .firebaseId)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
        statusId = try values.decodeIfPresent(Int.self, forKey: .statusId)
        userTypeId = try values.decodeIfPresent(Int.self, forKey: .userTypeId)
        showOnboarding = try values.decodeIfPresent(Bool.self, forKey: .showOnboarding) ?? true
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
    }

}
