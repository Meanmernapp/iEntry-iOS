//
//  OnboardingModel.swift
//  iEntry
//
//  Created by HaiDer's Macbook Pro on 22/11/2022.
//

import Foundation

struct OnboardingDoneModel : Codable {
    let code : Int?
    let data : [OnboardingProcesses]?
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
        data = try values.decodeIfPresent([OnboardingProcesses].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct OnboardingModel : Codable {
    let code : Int?
    let data : onBoardingData?
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
        data = try values.decodeIfPresent(onBoardingData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
 
struct onBoardingData : Codable {
    let id : String?
    let role : OnBoardingRole?
    let introduction : String?
    let zone : OnboardingZone?
    let user : OnboardingUser?
    let deleted : Bool?
    let deletedAt : Int?
    let onboardingProcesses : [OnboardingProcesses]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case role = "role"
        case introduction = "introduction"
        case zone = "zone"
        case user = "user"
        case deleted = "deleted"
        case deletedAt = "deletedAt"
        case onboardingProcesses = "onboardingProcesses"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        role = try values.decodeIfPresent(OnBoardingRole.self, forKey: .role)
        introduction = try values.decodeIfPresent(String.self, forKey: .introduction)
        zone = try values.decodeIfPresent(OnboardingZone.self, forKey: .zone)
        user = try values.decodeIfPresent(OnboardingUser.self, forKey: .user)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        deletedAt = try values.decodeIfPresent(Int.self, forKey: .deletedAt)
        onboardingProcesses = try values.decodeIfPresent([OnboardingProcesses].self, forKey: .onboardingProcesses)
    }

}

struct OnBoardingRole : Codable {
    let id : String?
    let name : String?
    let createdAt : Int?
    let updatedAt : Int?
    let deleted : Bool?
    let deletedAt : Int?

    let lastName : String?
    let secondLastName : String?

    enum CodingKeys: String, CodingKey {
        case lastName = "lastName"
        case secondLastName = "secondLastName"
        case id = "id"
        case name = "name"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case deletedAt = "deletedAt"
        case deleted = "deleted"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
        deletedAt = try values.decodeIfPresent(Int.self, forKey: .deletedAt)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
    }

}

struct OnboardingProcesses : Codable {
    let id : String?
    let process : String?
    let deleted : Bool?
    let deletedAt : Int?
//    let userProcesses : [onBoardingProcessDetail]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case process = "process"
        case deleted = "deleted"
        case deletedAt = "deletedAt"
//        case userProcesses = "userProcesses"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        process = try values.decodeIfPresent(String.self, forKey: .process)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        deletedAt = try values.decodeIfPresent(Int.self, forKey: .deletedAt)
//        userProcesses = try values.decodeIfPresent([onBoardingProcessDetail].self, forKey: .userProcesses)
    }

}

struct onBoardingProcessDetail : Codable {
    let id : String?
    let user : OnboardingUserIDs?
    let deleted : Bool?
    let deletedAt : Int?
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user = "user"
        case deleted = "deleted"
        case deletedAt = "deletedAt"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user = try values.decodeIfPresent(OnboardingUserIDs.self, forKey: .user)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        deletedAt = try values.decodeIfPresent(Int.self, forKey: .deletedAt)
    }
    
}

struct OnboardingUserIDs : Codable {
    let id : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        
    }
    
}

struct OnboardingUser : Codable {
    let id : String?
    let status : OnboardingStatus?
    let userType : OnboardingUserType?
    let gender : OnboardingGender?
    let name : String?
    let phoneNumber : String?
    let dob : Int?
    let email : String?
    let deviceId : String?
    let firebaseId : String?
    let secret : String?
    let createdAt : Int?
    let updatedAt : Int?
    let showOnboarding : Bool?
    let selfie : String?

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
        case showOnboarding = "showOnboarding"
        case selfie = "selfie"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        status = try values.decodeIfPresent(OnboardingStatus.self, forKey: .status)
        userType = try values.decodeIfPresent(OnboardingUserType.self, forKey: .userType)
        gender = try values.decodeIfPresent(OnboardingGender.self, forKey: .gender)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        dob = try values.decodeIfPresent(Int.self, forKey: .dob)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        deviceId = try values.decodeIfPresent(String.self, forKey: .deviceId)
        firebaseId = try values.decodeIfPresent(String.self, forKey: .firebaseId)
        secret = try values.decodeIfPresent(String.self, forKey: .secret)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
        showOnboarding = try values.decodeIfPresent(Bool.self, forKey: .showOnboarding)
        selfie = try values.decodeIfPresent(String.self, forKey: .selfie)
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
    }

}

struct OnboardingUserType : Codable {
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

struct OnboardingStatus : Codable {
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

struct OnboardingGender : Codable {
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

struct OnboardingZone : Codable {
    let id : String?
    let name : String?
    let status : Status?
    let latitud : Double?
    let longitud : Double?
    let createdAt : Int?
    let updatedAt : Int?

    let lastName : String?
    let secondLastName : String?

    enum CodingKeys: String, CodingKey {
        case lastName = "lastName"
        case secondLastName = "secondLastName"
        case id = "id"
        case name = "name"
        case status = "status"
        case latitud = "latitud"
        case longitud = "longitud"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        latitud = try values.decodeIfPresent(Double.self, forKey: .latitud)
        longitud = try values.decodeIfPresent(Double.self, forKey: .longitud)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
        lastName = try values.decodeIfPresent(String.self,forKey: .lastName)
        secondLastName = try values.decodeIfPresent(String.self,forKey: .secondLastName)
    }

}

struct HideOnBoarding : Codable {
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
