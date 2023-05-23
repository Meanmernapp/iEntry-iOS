//
//  HolidayModel.swift
//  iEntry
//
//  Created by HaiDeR AwAn on 14/04/2023.
//

import Foundation

struct HolidayModel : Codable {
    let code : Int?
    let data : HolidayModelData?
    let success : Bool?
    let message : String?
    let timestamp : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case data = "data"
        case success = "success"
        case message = "message"
        case timestamp = "timestamp"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        data = try values.decodeIfPresent(HolidayModelData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct HolidayModelData : Codable {
    let from : Int?
    let to : Int?
    let available : Int?
    let requested : Int?
    let spent : Int?
    let total : Int?
    let inValidation : [InValidationList]?
    let records : [RecordsList]?
    let departmentId : String?
    let departmentName : String?
    let bossId : String?
    let bossName : String?
    let bossLastName : String?
    let bossSecondLastName : String?
    let bossEmail : String?
    let bossPhoneNumber : String?

    enum CodingKeys: String, CodingKey {

        case from = "from"
        case to = "to"
        case available = "available"
        case requested = "requested"
        case spent = "spent"
        case total = "total"
        case inValidation = "inValidation"
        case records = "records"
        case departmentId = "departmentId"
        case departmentName = "departmentName"
        case bossId = "bossId"
        case bossName = "bossName"
        case bossLastName = "bossLastName"
        case bossSecondLastName = "bossSecondLastName"
        case bossEmail = "bossEmail"
        case bossPhoneNumber = "bossPhoneNumber"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        from = try values.decodeIfPresent(Int.self, forKey: .from)
        to = try values.decodeIfPresent(Int.self, forKey: .to)
        available = try values.decodeIfPresent(Int.self, forKey: .available)
        requested = try values.decodeIfPresent(Int.self, forKey: .requested)
        spent = try values.decodeIfPresent(Int.self, forKey: .spent)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        inValidation = try values.decodeIfPresent([InValidationList].self, forKey: .inValidation)
        records = try values.decodeIfPresent([RecordsList].self, forKey: .records)
        departmentId = try values.decodeIfPresent(String.self, forKey: .departmentId)
        departmentName = try values.decodeIfPresent(String.self, forKey: .departmentName)
        bossId = try values.decodeIfPresent(String.self, forKey: .bossId)
        bossName = try values.decodeIfPresent(String.self, forKey: .bossName)
        bossLastName = try values.decodeIfPresent(String.self, forKey: .bossLastName)
        bossSecondLastName = try values.decodeIfPresent(String.self, forKey: .bossSecondLastName)
        bossEmail = try values.decodeIfPresent(String.self, forKey: .bossEmail)
        bossPhoneNumber = try values.decodeIfPresent(String.self, forKey: .bossPhoneNumber)
    }

}

struct InValidationList : Codable {
    let id : String?
        let whoRequestedId : String?
        let whoRequestedName : String?
        let whoRequestedLastName : String?
        let whoRequestedSecondLastName : String?
        let statusId : Int?
        let statusName : String?
        let totalDay : Int?
        let fromDate : Int?
        let toDate : Int?
        let createdAt : Int?
        let department : DepartmentHoliday?
        let manager : ManagerHoliday?

        enum CodingKeys: String, CodingKey {

            case id = "id"
            case whoRequestedId = "whoRequestedId"
            case whoRequestedName = "whoRequestedName"
            case whoRequestedLastName = "whoRequestedLastName"
            case whoRequestedSecondLastName = "whoRequestedSecondLastName"
            case statusId = "statusId"
            case statusName = "statusName"
            case totalDay = "totalDay"
            case fromDate = "fromDate"
            case toDate = "toDate"
            case createdAt = "createdAt"
            case department = "department"
            case manager = "manager"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decodeIfPresent(String.self, forKey: .id)
            whoRequestedId = try values.decodeIfPresent(String.self, forKey: .whoRequestedId)
            whoRequestedName = try values.decodeIfPresent(String.self, forKey: .whoRequestedName)
            whoRequestedLastName = try values.decodeIfPresent(String.self, forKey: .whoRequestedLastName)
            whoRequestedSecondLastName = try values.decodeIfPresent(String.self, forKey: .whoRequestedSecondLastName)
            statusId = try values.decodeIfPresent(Int.self, forKey: .statusId)
            statusName = try values.decodeIfPresent(String.self, forKey: .statusName)
            totalDay = try values.decodeIfPresent(Int.self, forKey: .totalDay)
            fromDate = try values.decodeIfPresent(Int.self, forKey: .fromDate)
            toDate = try values.decodeIfPresent(Int.self, forKey: .toDate)
            createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
            department = try values.decodeIfPresent(DepartmentHoliday.self, forKey: .department)
            manager = try values.decodeIfPresent(ManagerHoliday.self, forKey: .manager)
        }

    }
struct RecordsList : Codable {
    let id : String?
        let whoRequestedId : String?
        let whoRequestedName : String?
        let whoRequestedLastName : String?
        let whoRequestedSecondLastName : String?
        let statusId : Int?
        let statusName : String?
        let totalDay : Int?
        let fromDate : Int?
        let toDate : Int?
        let createdAt : Int?
        let department : DepartmentHoliday?
        let manager : ManagerHoliday?

        enum CodingKeys: String, CodingKey {

            case id = "id"
            case whoRequestedId = "whoRequestedId"
            case whoRequestedName = "whoRequestedName"
            case whoRequestedLastName = "whoRequestedLastName"
            case whoRequestedSecondLastName = "whoRequestedSecondLastName"
            case statusId = "statusId"
            case statusName = "statusName"
            case totalDay = "totalDay"
            case fromDate = "fromDate"
            case toDate = "toDate"
            case createdAt = "createdAt"
            case department = "department"
            case manager = "manager"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decodeIfPresent(String.self, forKey: .id)
            whoRequestedId = try values.decodeIfPresent(String.self, forKey: .whoRequestedId)
            whoRequestedName = try values.decodeIfPresent(String.self, forKey: .whoRequestedName)
            whoRequestedLastName = try values.decodeIfPresent(String.self, forKey: .whoRequestedLastName)
            whoRequestedSecondLastName = try values.decodeIfPresent(String.self, forKey: .whoRequestedSecondLastName)
            statusId = try values.decodeIfPresent(Int.self, forKey: .statusId)
            statusName = try values.decodeIfPresent(String.self, forKey: .statusName)
            totalDay = try values.decodeIfPresent(Int.self, forKey: .totalDay)
            fromDate = try values.decodeIfPresent(Int.self, forKey: .fromDate)
            toDate = try values.decodeIfPresent(Int.self, forKey: .toDate)
            createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
            department = try values.decodeIfPresent(DepartmentHoliday.self, forKey: .department)
            manager = try values.decodeIfPresent(ManagerHoliday.self, forKey: .manager)
        }

    }

struct ManagerHoliday : Codable {
    let id : String?
    let holidayId : String?
    let statusId : Int?
    let whoRequestedId : String?
    let whoRequestedName : String?
    let whoRequestedLastName : String?
    let whoRequestedSecondLastName : String?
    let whoManagedId : String?
    let whoManagedName : String?
    let whoManagedLastName : String?
    let whoManagedSecondLastName : String?
    let message : String?
    let departmentId : String?
    let departmentName : String?
    let createdAt : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case holidayId = "holidayId"
        case statusId = "statusId"
        case whoRequestedId = "whoRequestedId"
        case whoRequestedName = "whoRequestedName"
        case whoRequestedLastName = "whoRequestedLastName"
        case whoRequestedSecondLastName = "whoRequestedSecondLastName"
        case whoManagedId = "whoManagedId"
        case whoManagedName = "whoManagedName"
        case whoManagedLastName = "whoManagedLastName"
        case whoManagedSecondLastName = "whoManagedSecondLastName"
        case message = "message"
        case departmentId = "departmentId"
        case departmentName = "departmentName"
        case createdAt = "createdAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        holidayId = try values.decodeIfPresent(String.self, forKey: .holidayId)
        statusId = try values.decodeIfPresent(Int.self, forKey: .statusId)
        whoRequestedId = try values.decodeIfPresent(String.self, forKey: .whoRequestedId)
        whoRequestedName = try values.decodeIfPresent(String.self, forKey: .whoRequestedName)
        whoRequestedLastName = try values.decodeIfPresent(String.self, forKey: .whoRequestedLastName)
        whoRequestedSecondLastName = try values.decodeIfPresent(String.self, forKey: .whoRequestedSecondLastName)
        whoManagedId = try values.decodeIfPresent(String.self, forKey: .whoManagedId)
        whoManagedName = try values.decodeIfPresent(String.self, forKey: .whoManagedName)
        whoManagedLastName = try values.decodeIfPresent(String.self, forKey: .whoManagedLastName)
        whoManagedSecondLastName = try values.decodeIfPresent(String.self, forKey: .whoManagedSecondLastName)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        departmentId = try values.decodeIfPresent(String.self, forKey: .departmentId)
        departmentName = try values.decodeIfPresent(String.self, forKey: .departmentName)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
    }

}

struct DepartmentHoliday : Codable {
    let id : String?
        let whoRequestedId : String?
        let whoRequestedName : String?
        let whoRequestedLastName : String?
        let whoRequestedSecondLastName : String?
        let statusId : Int?
        let statusName : String?
        let totalDay : Int?
        let fromDate : Int?
        let toDate : Int?
        let createdAt : Int?
        let department : String?
        let manager : String?

        enum CodingKeys: String, CodingKey {

            case id = "id"
            case whoRequestedId = "whoRequestedId"
            case whoRequestedName = "whoRequestedName"
            case whoRequestedLastName = "whoRequestedLastName"
            case whoRequestedSecondLastName = "whoRequestedSecondLastName"
            case statusId = "statusId"
            case statusName = "statusName"
            case totalDay = "totalDay"
            case fromDate = "fromDate"
            case toDate = "toDate"
            case createdAt = "createdAt"
            case department = "department"
            case manager = "manager"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decodeIfPresent(String.self, forKey: .id)
            whoRequestedId = try values.decodeIfPresent(String.self, forKey: .whoRequestedId)
            whoRequestedName = try values.decodeIfPresent(String.self, forKey: .whoRequestedName)
            whoRequestedLastName = try values.decodeIfPresent(String.self, forKey: .whoRequestedLastName)
            whoRequestedSecondLastName = try values.decodeIfPresent(String.self, forKey: .whoRequestedSecondLastName)
            statusId = try values.decodeIfPresent(Int.self, forKey: .statusId)
            statusName = try values.decodeIfPresent(String.self, forKey: .statusName)
            totalDay = try values.decodeIfPresent(Int.self, forKey: .totalDay)
            fromDate = try values.decodeIfPresent(Int.self, forKey: .fromDate)
            toDate = try values.decodeIfPresent(Int.self, forKey: .toDate)
            createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
            department = try values.decodeIfPresent(String.self, forKey: .department)
            manager = try values.decodeIfPresent(String.self, forKey: .manager)
        }

    }
