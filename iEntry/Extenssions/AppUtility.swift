//
//  AppUtility.swift

//
//  Created by ZAFAR on 24/11/2021.
//
//AppUtility.showErrorMessage(message: "Please select the Package")
import Foundation
import SwiftMessages
class AppUtility {
    
    class func showErrorMessage(message:String , showTitle:Bool = true) {
        let error = MessageView.viewFromNib(layout: .tabView)
        error.configureTheme(.error)
        error.configureContent(title: showTitle ? "" : "", body: message)
        error.button?.isHidden = true
        SwiftMessages.show(view: error)
    }
    
    class func showSuccessMessage(message:String , showTitle:Bool = true) {
        let success = MessageView.viewFromNib(layout: .tabView)
        success.configureTheme(.success)
        success.configureContent(title: showTitle ? "" : "", body: message)
        success.button?.isHidden = true
        SwiftMessages.show(view: success)
    }
    
    class func showInfoMessage(message:String , showTitle:Bool = true) {
        let info = MessageView.viewFromNib(layout: .tabView)
        info.configureTheme(.info)
        info.configureContent(title: showTitle ? "" : "", body: message)
        info.button?.isHidden = true
        SwiftMessages.show(view: info)
    }
    class func showWarningMessage(message:String , showTitle:Bool = true) {
        let info = MessageView.viewFromNib(layout: .tabView)
        info.configureTheme(.info)
        info.configureContent(title: showTitle ? "" : "", body: message)
        info.button?.isHidden = true
        SwiftMessages.show(view: info)
    }
    
    
    
}
extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    
}


