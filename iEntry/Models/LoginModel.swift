//
//  LoginModel.swift
//  iEntry
//
//  Created by ZAFAR on 17/09/2021.
//

import Foundation



//struct BaseStruct<T : Codable> : Codable {
//    let code : Int?
//    let data : T?
//    let success : Bool?
//    let message : String?
//     
//    let status : String?
//}


struct LoginModel : Codable {
    
    
    let code : Int?
    let data : LoginDataModel?
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
        data = try values.decodeIfPresent(LoginDataModel.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    

}

struct LoginDataModel : Codable {
    let id : String?
    let status : Status?
    let userType : UserType?
    let gender : Gender?
    let extraData : ExtraData?
    let userImages : [String]?
    let name : String?
    let phoneNumber : String?
    let dob : Int?
    let email : String?
    let password : String?
    let deviceId : String?
    var selfie : String?
    let firebaseId : String?
    let secret : String?
    let createdAt : Int?
    let updatedAt : Int?
    let showOnboarding : Bool?
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
        case userImages = "userImages"
        case name = "name"
        case phoneNumber = "phoneNumber"
        case dob = "dob"
        case selfie = "selfie"
        case email = "email"
        case password = "password"
        case deviceId = "deviceId"
        case firebaseId = "firebaseId"
        case secret = "secret"
        case showOnboarding = "showOnboarding"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        userType = try values.decodeIfPresent(UserType.self, forKey: .userType)
        gender = try values.decodeIfPresent(Gender.self, forKey: .gender)
        extraData = try values.decodeIfPresent(ExtraData.self, forKey: .extraData)
        userImages = try values.decodeIfPresent([String].self, forKey: .userImages)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        selfie = try values.decodeIfPresent(String.self, forKey: .selfie)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        dob = try values.decodeIfPresent(Int.self, forKey: .dob)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        deviceId = try values.decodeIfPresent(String.self, forKey: .deviceId)
        firebaseId = try values.decodeIfPresent(String.self, forKey: .firebaseId)
        secret = try values.decodeIfPresent(String.self, forKey: .secret)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
        showOnboarding = try values.decodeIfPresent(Bool.self, forKey: .showOnboarding) ?? true
    }

}

struct ExtraData : Codable {
    let id : String?
    let user : CreateExtraUserDataUser?
    var field1 = "---"
    var field2 = "---"
    var field3 = "---"
    var field4 = "---"
    var field5 = "---"
    var field6 = "---"
    var field7 = "---"
    var field8 = "---"
    var field9 = "---"
    var field10 = "---"
    var field11 = "---"
    var field12 = "---"
    var field13 = "---"
    var field14 = "---"
    var field15 = "---"

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user = "user"
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
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user = try values.decodeIfPresent(CreateExtraUserDataUser.self, forKey: .user)
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
    }

}



//MARK:- CheckUser
struct CheckUserModel : Codable {
    let code : Int?
    let data : Bool?
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
        data = try values.decodeIfPresent(Bool.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}


struct Father : Codable {
    let id : String?
    let name : String?
    let company : Company?
    let status : Status?
    let father : String?
    let createdAt : String?
    let updatedAt : String?
    let lastName : String?
    let secondLastName : String?

    enum CodingKeys: String, CodingKey {
        case lastName = "lastName"
        case secondLastName = "secondLastName"
        case id = "id"
        case name = "name"
        case company = "company"
        case status = "status"
        case father = "father"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        father = try values.decodeIfPresent(String.self, forKey: .father)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }

}




struct Company : Codable {
    
    
    
    let id : String?
    let status : Status?
    let acronym : String?
    let path : String?
    let driveId : String?
    let image : String?
    let name : String?
    let address : String?
    let latitud : Double?
    let longitud : Double?
    let ip : String?
    let createdAt : Int?
    let updatedAt : Int?
    let introduction : String?
    let mision : String?
    let vision : String?
    let noEmployees : Int?
    let noVehicles : Int?
    let noZones : Int?
    let lastName : String?
    let secondLastName : String?

    enum CodingKeys: String, CodingKey {
        case lastName = "lastName"
        case secondLastName = "secondLastName"
        case id = "id"
        case status = "status"
        case acronym = "acronym"
        case path = "path"
        case driveId = "driveId"
        case image = "image"
        case name = "name"
        case address = "address"
        case latitud = "latitud"
        case longitud = "longitud"
        case ip = "ip"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case introduction = "introduction"
        case mision = "mision"
        case vision = "vision"
        case noEmployees = "noEmployees"
        case noVehicles = "noVehicles"
        case noZones = "noZones"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        acronym = try values.decodeIfPresent(String.self, forKey: .acronym)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        driveId = try values.decodeIfPresent(String.self, forKey: .driveId)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        latitud = try values.decodeIfPresent(Double.self, forKey: .latitud)
        longitud = try values.decodeIfPresent(Double.self, forKey: .longitud)
        ip = try values.decodeIfPresent(String.self, forKey: .ip)
        vision = try values.decodeIfPresent(String.self, forKey: .vision)
        mision = try values.decodeIfPresent(String.self, forKey: .mision)
        introduction = try values.decodeIfPresent(String.self, forKey: .introduction)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
        noEmployees = try values.decodeIfPresent(Int.self, forKey: .noEmployees)
        noVehicles = try values.decodeIfPresent(Int.self, forKey: .noVehicles)
        noZones = try values.decodeIfPresent(Int.self, forKey: .noZones)
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
    }

}

struct Task : Codable {
    let id : Int?
    let name : String?
    let isMobileApp : Bool?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case isMobileApp = "isMobileApp"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        isMobileApp = try values.decodeIfPresent(Bool.self, forKey: .isMobileApp)
    }

}

struct Status : Codable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}


struct RoleTasks : Codable {
    let id : String?
    let task : Task?
    let privilege : Int?
    let createdAt : Double?
    let updatedAt : Double?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case task = "task"
        case privilege = "privilege"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        task = try values.decodeIfPresent(Task.self, forKey: .task)
        privilege = try values.decodeIfPresent(Int.self, forKey: .privilege)
        createdAt = try values.decodeIfPresent(Double.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Double.self, forKey: .updatedAt)
    }

}

struct Role : Codable {
    let id : String?
    let name : String?
    let roleTasks : [RoleTasks]?
    let roleRestriction : RoleRestriction?
    let createdAt : Int?
    let updatedAt : Int?

    let lastName : String?
    let secondLastName : String?

    enum CodingKeys: String, CodingKey {
        case lastName = "lastName"
        case secondLastName = "secondLastName"
        case id = "id"
        case name = "name"
        case roleTasks = "roleTasks"
        case roleRestriction = "roleRestriction"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        roleTasks = try values.decodeIfPresent([RoleTasks].self, forKey: .roleTasks)
        roleRestriction = try values.decodeIfPresent(RoleRestriction.self, forKey: .roleRestriction)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
    }

}
struct RoleRestriction : Codable {
    let id : String?
    let eventValidation : Bool?
    let sharePdfInMobileApp : Bool?
    let extraDataEmployee : Bool?
    let biocrValidation : Bool?
    let keepSessionActiveWebApp : Bool?
    let useTokenWebApp : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case eventValidation = "eventValidation"
        case sharePdfInMobileApp = "sharePdfInMobileApp"
        case extraDataEmployee = "extraDataEmployee"
        case biocrValidation = "biocrValidation"
        case keepSessionActiveWebApp = "keepSessionActiveWebApp"
        case useTokenWebApp = "useTokenWebApp"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        eventValidation = try values.decodeIfPresent(Bool.self, forKey: .eventValidation)
        sharePdfInMobileApp = try values.decodeIfPresent(Bool.self, forKey: .sharePdfInMobileApp)
        extraDataEmployee = try values.decodeIfPresent(Bool.self, forKey: .extraDataEmployee)
        biocrValidation = try values.decodeIfPresent(Bool.self, forKey: .biocrValidation)
        keepSessionActiveWebApp = try values.decodeIfPresent(Bool.self, forKey: .keepSessionActiveWebApp)
        useTokenWebApp = try values.decodeIfPresent(Bool.self, forKey: .useTokenWebApp)
    }

}

struct Zone : Codable {
    let id : String?
    let zonecommonArea :commonArea?
    let name : String?
    let company : Company?
    let status : Status?
    let createdAt : Int?
    let updatedAt : Int?

    let lastName : String?
    let secondLastName : String?

    enum CodingKeys: String, CodingKey {
        case lastName = "lastName"
        case secondLastName = "secondLastName"
        case id = "id"
        case zonecommonArea = "commonArea"
        case name = "name"
        case company = "company"
        case status = "status"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        zonecommonArea = try values.decodeIfPresent(commonArea.self, forKey:.zonecommonArea)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
    }
    
    
    
}


struct commonArea:Codable {
                      
    var createdAt:Int?
    var fromTime : Int?
    var id : String?
    var toTime : Int?
    var updatedAt :Int?
    
    enum CodingKeys: String, CodingKey {

        case createdAt = "createdAt"
        case fromTime = "fromTime"
        case id = "id"
        case toTime = "toTime"
        case updatedAt = "updatedAt"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        fromTime = try values.decodeIfPresent(Int.self, forKey: .fromTime)
        toTime = try values.decodeIfPresent(Int.self, forKey: .toTime)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }
}
struct UserType : Codable {
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

struct User : Codable {
    let id : String?
    let status : Status?
    let userType : UserType?
    let gender : Gender?
    let extraData : ExtraData?
    let name : String?
    let phoneNumber : String?
     let dob : Int?
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
        case extraData = "extraData"
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
        gender = try values.decodeIfPresent(Gender.self, forKey: .gender)
        extraData = try values.decodeIfPresent(ExtraData.self, forKey: .extraData)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        dob = try values.decodeIfPresent(Int.self, forKey: .dob)
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


struct SendEmailModel: Codable {
    let code : Int?
    let data : Bool?
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
        data = try values.decodeIfPresent(Bool.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
