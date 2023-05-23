//
//  GetContractByUserModel.swift
//  iEntry
//
//  Created by ZAFAR on 22/12/2021.
//

import Foundation
struct BaseModelCompanyDataV2 : Codable {
    
    
    let code : Int?
    let data : CompanyDataV2?
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
        data = try values.decodeIfPresent(CompanyDataV2.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}
struct BaseModelCompanyRoleV2 : Codable {
    
    
    let code : Int?
    let data : [Task]??
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
        data = try values.decodeIfPresent([Task].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}
struct GetContractByUserModel : Codable {
    
    
    let code : Int?
    let data : GetContractByUserModelData?
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
        data = try values.decodeIfPresent(GetContractByUserModelData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct CompanyDataV2 : Codable {
    let id : String?
    let userId : String?
    let roleId : String?
    let roleName : String?
    let statusId : Int?
    let zoneId : String?
    let zoneName : String?
    let employeeId : String?
    let departmentId : String?
    let departmentName : String?
    let startDate : Int?
    let endDate : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case userId = "userId"
        case roleId = "roleId"
        case roleName = "roleName"
        case statusId = "statusId"
        case zoneId = "zoneId"
        case zoneName = "zoneName"
        case employeeId = "employeeId"
        case departmentId = "departmentId"
        case departmentName = "departmentName"
        case startDate = "startDate"
        case endDate = "endDate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        roleId = try values.decodeIfPresent(String.self, forKey: .roleId)
        roleName = try values.decodeIfPresent(String.self, forKey: .roleName)
        statusId = try values.decodeIfPresent(Int.self, forKey: .statusId)
        zoneId = try values.decodeIfPresent(String.self, forKey: .zoneId)
        zoneName = try values.decodeIfPresent(String.self, forKey: .zoneName)
        employeeId = try values.decodeIfPresent(String.self, forKey: .employeeId)
        departmentId = try values.decodeIfPresent(String.self, forKey: .departmentId)
        departmentName = try values.decodeIfPresent(String.self, forKey: .departmentName)
        startDate = try values.decodeIfPresent(Int.self, forKey: .startDate)
        endDate = try values.decodeIfPresent(Int.self, forKey: .endDate)
    }

}

struct GetContractByUserModelData : Codable {
    
    let id : String?
    let user : User?
    let status : Status?
    let company : Company?
    let role : Role?
    let employeeId : String?
    let zone : Zone?
    let startDate : Int?
    let endDate : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
         case user = "user"
        case status = "status"
        case company = "company"
        case role = "role"
        case employeeId = "employeeId"
        case zone = "zone"
        case startDate = "startDate"
        case endDate = "endDate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        role = try values.decodeIfPresent(Role.self, forKey: .role)
        employeeId = try values.decodeIfPresent(String.self, forKey: .employeeId)
        zone = try values.decodeIfPresent(Zone.self, forKey: .zone)
        startDate = try values.decodeIfPresent(Int.self, forKey: .startDate)
        endDate = try values.decodeIfPresent(Int.self, forKey: .endDate)
    }

//    let id : String?
//    let user : User?
//    let status : Status?
//    let company : Company?
//    let role : Role?
//    let employeeId : String?
//    let zone : Zone?
//    let startDate : Int?
//    let endDate : Int?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case user = "user"
//        case status = "status"
//        case company = "company"
//        case role = "role"
//        case employeeId = "employeeId"
//        case zone = "zone"
//        case startDate = "startDate"
//        case endDate = "endDate"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        user = try values.decodeIfPresent(User.self, forKey: .user)
//        status = try values.decodeIfPresent(Status.self, forKey: .status)
//        company = try values.decodeIfPresent(Company.self, forKey: .company)
//        role = try values.decodeIfPresent(Role.self, forKey: .role)
//        employeeId = try values.decodeIfPresent(String.self, forKey: .employeeId)
//        zone = try values.decodeIfPresent(Zone.self, forKey: .zone)
//        startDate = try values.decodeIfPresent(Int.self, forKey: .startDate)
//        endDate = try values.decodeIfPresent(Int.self, forKey: .endDate)
//    }
}


class checkUserExistModel:NSObject, NSCoding{
    var isregister : Bool
    var name : String
    var phoneemail : String
    var guestid : String
    var registertype : Int
    var email:String
    init(name:String,phone:String,isregister:Bool,guestid:String,registertype:Int,email:String) {
        self.name = name
        self.phoneemail = phone
        self.isregister = isregister
        self.guestid = guestid
        self.registertype = registertype
        self.email = email
    }
    
    required init(coder decoder: NSCoder) {
            self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.phoneemail = decoder.decodeObject(forKey: "phoneemail") as? String ?? ""
            self.isregister = decoder.decodeObject(forKey: "isregister") as? Bool ?? false
        self.guestid = decoder.decodeObject(forKey: "guestid") as? String ?? ""
        self.registertype = decoder.decodeObject(forKey: "registertype") as? Int ?? 0
        self.email = decoder.decodeObject(forKey: "email") as? String ?? ""
        }
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(phoneemail, forKey: "phoneemail")
        coder.encode(isregister,forKey: "isregister")
        coder.encode(guestid,forKey: "guestid")
        coder.encode(registertype,forKey: "registertype")
        coder.encode(email,forKey: "email")
    }
}
