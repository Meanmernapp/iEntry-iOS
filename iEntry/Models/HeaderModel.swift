//
//  HeaderModel.swift
//  iEntry
//
//  Created by HaiDer's Macbook Pro on 30/11/2022.
//

import Foundation

import Foundation
struct HeadersModel : Codable {
    let code : Int?
    let data : HeadersData?
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
        data = try values.decodeIfPresent(HeadersData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct HeadersData : Codable {
    let id : Int?
    let company : Company?
    var header1 = "Header1"
    var header2 = "Header2"
    var header3 = "Header3"
    var header4 = "Header4"
    var header5 = "Header5"
    var header6 = "Header6"
    var header7 = "Header7"
    var header8 = "Header8"
    var header9 = "Header9"
    var header10 = "Header10"
    var header11 = "Header11"
    var header12 = "Header12"
    var header13 = "Header13"
    var header14 = "Header14"
    var header15 = "Header15"

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case company = "company"
        case header1 = "header1"
        case header2 = "header2"
        case header3 = "header3"
        case header4 = "header4"
        case header5 = "header5"
        case header6 = "header6"
        case header7 = "header7"
        case header8 = "header8"
        case header9 = "header9"
        case header10 = "header10"
        case header11 = "header11"
        case header12 = "header12"
        case header13 = "header13"
        case header14 = "header14"
        case header15 = "header15"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        header1 = try values.decodeIfPresent(String.self, forKey: .header1) ?? "Header1"
        header2 = try values.decodeIfPresent(String.self, forKey: .header2) ?? "Header2"
        header3 = try values.decodeIfPresent(String.self, forKey: .header3) ?? "Header3"
        header4 = try values.decodeIfPresent(String.self, forKey: .header4) ?? "Header4"
        header5 = try values.decodeIfPresent(String.self, forKey: .header5) ?? "Header5"
        header6 = try values.decodeIfPresent(String.self, forKey: .header6) ?? "Header6"
        header7 = try values.decodeIfPresent(String.self, forKey: .header7) ?? "Header7"
        header8 = try values.decodeIfPresent(String.self, forKey: .header8) ?? "Header8"
        header9 = try values.decodeIfPresent(String.self, forKey: .header9) ?? "Header9"
        header10 = try values.decodeIfPresent(String.self, forKey: .header10) ?? "Header10"
        header11 = try values.decodeIfPresent(String.self, forKey: .header11) ?? "Header11"
        header12 = try values.decodeIfPresent(String.self, forKey: .header12) ?? "Header12"
        header13 = try values.decodeIfPresent(String.self, forKey: .header13) ?? "Header13"
        header14 = try values.decodeIfPresent(String.self, forKey: .header14) ?? "Header14"
        header15 = try values.decodeIfPresent(String.self, forKey: .header15) ?? "Header15"
    }

}

