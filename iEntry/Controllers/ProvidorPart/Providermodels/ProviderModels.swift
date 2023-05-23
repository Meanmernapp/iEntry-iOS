//
//  ProviderModels.swift
//  iEntry
//
//  Created by ZAFAR on 08/03/2022.
//

import Foundation
struct ProviderModels : Codable {
    let code : Int?
    let data : [ProviderModelsData]?
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
        data = try values.decodeIfPresent([ProviderModelsData].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct ProviderModelsData : Codable {
    let id : String?
    let folio : String?
    let supplierId : String?
    let supplierName : String?
    let supplierLastName : String?
    let supplierSecondLastName : String?
    let supplierCompanyName : String?
    let supplierCompanyAcronym : String?
    let supplierEmployeeId : String?
    let supplierEmployeeName : String?
    let supplierEmployeeLastName : String?
    let supplierEmployeeSecondLastName : String?
    let supplierEmployeeEmail : String?
    let supplierEmployeePhoneNumber : String?
    let supplierVehicleId : String?
    let supplierVehicleBrand : String?
    let supplierVehicleSubBrand : String?
    let supplierVehicleModel : Int?
    let supplierVehicleColor : String?
    let supplierVehiclePlate : String?
    let supplierVehicleVin : String?
    let supplierVehicleSerialNumber : String?
    let statusId : Int?
    let userReceivedId : String?
    let userReceivedName : String?
    let userReceivedLastName : String?
    let userReceivedSecondLastName : String?
    let deliveryDate : Int?
    let isDelivery : Bool?
    let eta : String?
    let item : String?
    let description : String?
    let createdAt : Int?
    let updatedAt : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case folio = "folio"
        case supplierId = "supplierId"
        case supplierName = "supplierName"
        case supplierLastName = "supplierLastName"
        case supplierSecondLastName = "supplierSecondLastName"
        case supplierCompanyName = "supplierCompanyName"
        case supplierCompanyAcronym = "supplierCompanyAcronym"
        case supplierEmployeeId = "supplierEmployeeId"
        case supplierEmployeeName = "supplierEmployeeName"
        case supplierEmployeeLastName = "supplierEmployeeLastName"
        case supplierEmployeeSecondLastName = "supplierEmployeeSecondLastName"
        case supplierEmployeeEmail = "supplierEmployeeEmail"
        case supplierEmployeePhoneNumber = "supplierEmployeePhoneNumber"
        case supplierVehicleId = "supplierVehicleId"
        case supplierVehicleBrand = "supplierVehicleBrand"
        case supplierVehicleSubBrand = "supplierVehicleSubBrand"
        case supplierVehicleModel = "supplierVehicleModel"
        case supplierVehicleColor = "supplierVehicleColor"
        case supplierVehiclePlate = "supplierVehiclePlate"
        case supplierVehicleVin = "supplierVehicleVin"
        case supplierVehicleSerialNumber = "supplierVehicleSerialNumber"
        case statusId = "statusId"
        case userReceivedId = "userReceivedId"
        case userReceivedName = "userReceivedName"
        case userReceivedLastName = "userReceivedLastName"
        case userReceivedSecondLastName = "userReceivedSecondLastName"
        case deliveryDate = "deliveryDate"
        case isDelivery = "isDelivery"
        case eta = "eta"
        case item = "item"
        case description = "description"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        folio = try values.decodeIfPresent(String.self, forKey: .folio)
        supplierId = try values.decodeIfPresent(String.self, forKey: .supplierId)
        supplierName = try values.decodeIfPresent(String.self, forKey: .supplierName)
        supplierLastName = try values.decodeIfPresent(String.self, forKey: .supplierLastName)
        supplierSecondLastName = try values.decodeIfPresent(String.self, forKey: .supplierSecondLastName)
        supplierCompanyName = try values.decodeIfPresent(String.self, forKey: .supplierCompanyName)
        supplierCompanyAcronym = try values.decodeIfPresent(String.self, forKey: .supplierCompanyAcronym)
        supplierEmployeeId = try values.decodeIfPresent(String.self, forKey: .supplierEmployeeId)
        supplierEmployeeName = try values.decodeIfPresent(String.self, forKey: .supplierEmployeeName)
        supplierEmployeeLastName = try values.decodeIfPresent(String.self, forKey: .supplierEmployeeLastName)
        supplierEmployeeSecondLastName = try values.decodeIfPresent(String.self, forKey: .supplierEmployeeSecondLastName)
        supplierEmployeeEmail = try values.decodeIfPresent(String.self, forKey: .supplierEmployeeEmail)
        supplierEmployeePhoneNumber = try values.decodeIfPresent(String.self, forKey: .supplierEmployeePhoneNumber)
        supplierVehicleId = try values.decodeIfPresent(String.self, forKey: .supplierVehicleId)
        supplierVehicleBrand = try values.decodeIfPresent(String.self, forKey: .supplierVehicleBrand)
        supplierVehicleSubBrand = try values.decodeIfPresent(String.self, forKey: .supplierVehicleSubBrand)
        supplierVehicleModel = try values.decodeIfPresent(Int.self, forKey: .supplierVehicleModel)
        supplierVehicleColor = try values.decodeIfPresent(String.self, forKey: .supplierVehicleColor)
        supplierVehiclePlate = try values.decodeIfPresent(String.self, forKey: .supplierVehiclePlate)
        supplierVehicleVin = try values.decodeIfPresent(String.self, forKey: .supplierVehicleVin)
        supplierVehicleSerialNumber = try values.decodeIfPresent(String.self, forKey: .supplierVehicleSerialNumber)
        statusId = try values.decodeIfPresent(Int.self, forKey: .statusId)
        userReceivedId = try values.decodeIfPresent(String.self, forKey: .userReceivedId)
        userReceivedName = try values.decodeIfPresent(String.self, forKey: .userReceivedName)
        userReceivedLastName = try values.decodeIfPresent(String.self, forKey: .userReceivedLastName)
        userReceivedSecondLastName = try values.decodeIfPresent(String.self, forKey: .userReceivedSecondLastName)
        deliveryDate = try values.decodeIfPresent(Int.self, forKey: .deliveryDate)
        isDelivery = try values.decodeIfPresent(Bool.self, forKey: .isDelivery)
        eta = try values.decodeIfPresent(String.self, forKey: .eta)
        item = try values.decodeIfPresent(String.self, forKey: .item)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }

}


struct Provider : Codable {
    let id : String?
    let user : User?
    let status : Status?
    let acronym : String?
    let contractorCompanyName : String?
    let createdAt : Int?
    let updatedAt : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user = "user"
        case status = "status"
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
        acronym = try values.decodeIfPresent(String.self, forKey: .acronym)
        contractorCompanyName = try values.decodeIfPresent(String.self, forKey: .contractorCompanyName)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }

}



struct UserReceived : Codable {
    let id : String?
    let status : Status?
    let userType : UserType?
    let gender : String?
    let name : String?
    let phoneNumber : String?
    let dob : String?
    let email : String?
    let deviceId : String?
    let firebaseId : String?
    let secret : String?
    let createdAt : Int?
    let updatedAt : Int?

    let lastName : String?
    let secondLastName : String?

    enum CodingKeys: String, CodingKey {
        case lastName = "lastName"
        case secondLastName = "secondLastName"
        case id = "id"
        case status = "status"
        case userType = "userType"
        case gender = "gender"
        case name = "name"
        case phoneNumber = "phoneNumber"
        case dob = "dob"
        case email = "email"
        case deviceId = "deviceId"
        case firebaseId = "firebaseId"
        case secret = "secret"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        userType = try values.decodeIfPresent(UserType.self, forKey: .userType)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        deviceId = try values.decodeIfPresent(String.self, forKey: .deviceId)
        firebaseId = try values.decodeIfPresent(String.self, forKey: .firebaseId)
        secret = try values.decodeIfPresent(String.self, forKey: .secret)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
    }

}




//struct ProviderEmployee : Codable {
//    let id : String?
//    let provider : Provider?
//    let user : User?
//    let status : Status?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case provider = "supplier"
//        case user = "user"
//        case status = "status"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        provider = try values.decodeIfPresent(Provider.self, forKey: .provider)
//        user = try values.decodeIfPresent(User.self, forKey: .user)
//        status = try values.decodeIfPresent(Status.self, forKey: .status)
//    }
//
//}
