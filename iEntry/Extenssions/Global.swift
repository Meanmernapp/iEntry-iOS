//
//  Global.swift
//  iEntry
//
//  Created by HaiDer's Macbook Pro on 09/08/2022.
//

import Foundation
import UIKit

class Global {
    class var shared : Global {
        struct Static {
            static let instance : Global = Global()
        }
        return Static.instance
    }
    var selectedIndex = 0
    var companyImage : UIImage?
    var selfiImage : UIImage?
    var isFirst = false
    var isFromLogout = false
    var periodFrom : Int?
    var periodTo : Int?
}
