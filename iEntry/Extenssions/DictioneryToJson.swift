//
//  DictioneryToJson.swift
//  iEntry
//
//  Created by ZAFAR on 20/09/2021.
//

import Foundation
import UIKit

class DictToJson :NSObject {
    static var ConversionDictionery = DictToJson()
    
    
    func dictoJson(dic:[String: String]) ->String {
        var json = ""
        let encoder = JSONEncoder()
                if let jsonData = try? encoder.encode(dic) {
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        json = jsonString
                        print("Nice Json", jsonString)
                    }
                }
        return json
    }
    
}
