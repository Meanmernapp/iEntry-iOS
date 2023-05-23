//
//  Networkhandler.swift
//  CarInsurance
//
//  Created by Apple on 7/3/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

import Alamofire

class Networkhandler{
    
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
    class func fetchNewToken() {
        TokenManager.shareToken.token(email: ShareData.shareInfo.Email ?? "", password: ShareData.shareInfo.password ?? "", token: { accessToken in
            ShareData.shareInfo.token = accessToken
        })
    }
    class func PostRequest(url: String, parameters: Parameters?, success:@escaping (AFDataResponse<Any>)->Void ,Falioure: @escaping (NetworkError) -> Void )
    {
        
        let data = try! JSONSerialization.data(withJSONObject: parameters ?? [:], options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        if let json = json {
            print(json)
        }
        
        let jsonData = json!.data(using: String.Encoding.utf8.rawValue);
        print(jsonData)
        let newurl = URL(string: url)!
        var request = URLRequest(url: newurl)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        let bearer = "Bearer "
        let newtoken = ShareData.shareInfo.token ?? ""
        let  token = bearer + newtoken
        request.setValue("\( token )",forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        AF.request(request).responseJSON { (response) in
            
            switch(response.result){
            case .success:
                let ModelRespons = response.result
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("api response",ModelRespons)
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                success(response)
                
                
                break
            case .failure (let error):
                
                var networkError = NetworkError()
                
                if error._code == NSURLErrorTimedOut {
                    networkError.status = Constant.NetworkErrorType.timout
                    networkError.message = Constant.NetworkErrorType.timoutError
                    
                    Falioure(networkError)
                } else if error._code == NSURLErrorNetworkConnectionLost{
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorNotConnectedToInternet{
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorCannotConnectToHost {
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorSecureConnectionFailed{
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                    
                }else{
                    
                    networkError.status = Constant.NetworkErrorType.generic
                    networkError.message = Constant.NetworkErrorType.genericError
                    
                    Falioure(networkError)
                }
                break
            }
            
            
        }
    }
    
    class func PostArrayRequest(url: String, parameters: [String], success:@escaping (AFDataResponse<Any>)->Void ,Falioure: @escaping (NetworkError) -> Void )
    {
        
        let data = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        if let json = json {
            print(json)
        }
        
        let jsonData = json!.data(using: String.Encoding.utf8.rawValue);
        print(jsonData)
        let newurl = URL(string: url)!
        var request = URLRequest(url: newurl)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        let bearer = "Bearer "
        let newtoken = ShareData.shareInfo.token ?? ""
        let  token = bearer + newtoken
        request.setValue("\( token )",forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        AF.request(request).responseJSON { (response) in
            
            switch(response.result){
            case .success:
                let ModelRespons = response.result
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("api response",ModelRespons)
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                success(response)
                
                
                break
            case .failure (let error):
                
                var networkError = NetworkError()
                
                if error._code == NSURLErrorTimedOut {
                    networkError.status = Constant.NetworkErrorType.timout
                    networkError.message = Constant.NetworkErrorType.timoutError
                    
                    Falioure(networkError)
                } else if error._code == NSURLErrorNetworkConnectionLost{
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorNotConnectedToInternet{
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorCannotConnectToHost {
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorSecureConnectionFailed{
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                    
                }else{
                    
                    networkError.status = Constant.NetworkErrorType.generic
                    networkError.message = Constant.NetworkErrorType.genericError
                    
                    Falioure(networkError)
                }
                break
            }
            
            
        }
    }
    
    
    class func PostRequest2(url: String, parameters: Parameters?, success:@escaping (AFDataResponse<Any>)->Void ,Falioure: @escaping (NetworkError) -> Void )
    {
        let cookieStore = HTTPCookieStorage.shared
        for cookie in cookieStore.cookies ?? [] {
            cookieStore.deleteCookie(cookie)
        }
        let Manger = Alamofire.Session.default
        var Headers : HTTPHeaders
        
        
        if let userToken = ShareData.shareInfo.token {
            Headers = [
                "Accept": "application/json",
                "Authorization" : "Bearer " +  userToken,
                "Content-Type" : "application/json",//"Authorization"
                "Accept": "application/json",
                "Content-type": "multipart/form-data",
                "Content-Type" :"application/x-www-form-urlencoded"
            ]
        } else {
            Headers = [
                "Accept": "application/json",
                "Content-Type" : "application/json",
                "Content-Type": "application/json",
                "Accept": "application/json",
                "Content-type": "multipart/form-data",
                "Content-Type": "application/json",
                "Accept": "application/json",
                "Content-type": "multipart/form-data",
                "Content-Type" :"application/x-www-form-urlencoded"
                //"application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type"
            ]
            
        }
        
        Manger.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Headers).validate(statusCode: 200..<600).responseJSON{ (response)-> Void in
            
            switch(response.result)
            {
            case .success:
                let ModelRespons = response.result
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("api response",ModelRespons)
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                success(response)
                
                
                break
            case .failure (let error):
                
                var networkError = NetworkError()
                
                if error._code == NSURLErrorTimedOut {
                    networkError.status = Constant.NetworkErrorType.timout
                    networkError.message = Constant.NetworkErrorType.timoutError
                    
                    Falioure(networkError)
                } else if error._code == NSURLErrorNetworkConnectionLost{
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorNotConnectedToInternet{
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorCannotConnectToHost {
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorSecureConnectionFailed{
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                    
                }else{
                    
                    networkError.status = Constant.NetworkErrorType.generic
                    networkError.message = Constant.NetworkErrorType.genericError
                    
                    Falioure(networkError)
                }
                break
            }
            
            
        }
    }
    
    
    
    class func PutRequest(url: String,isfromQR:Bool = false, parameters: Parameters?, success:@escaping (AFDataResponse<Any>)->Void ,Falioure: @escaping (NetworkError) -> Void )
    {
        
        let data = try! JSONSerialization.data(withJSONObject: parameters ?? [:], options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        if let json = json {
            print(json)
        }
        
        let jsonData = json!.data(using: String.Encoding.utf8.rawValue);
        print(jsonData)
        let newurl = URL(string: url)!
        var request = URLRequest(url: newurl)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        //"Content-Type" :"application/x-www-form-urlencoded"
        let bearer = "Bearer "
        let newtoken = ShareData.shareInfo.token ?? ""
        let  token = bearer + newtoken
        request.setValue("\(token)",forHTTPHeaderField: "Authorization")
        
        
        if isfromQR {
            if let body = parameters?["body"] as? String {
                if let data = body.data(using: .utf8) {
                    print(body)
                    request.httpBody = data
                }
                else {
                    request.httpBody = jsonData
                }
            }
            else
            {
                request.httpBody = jsonData
            }
            
        }
        else
        {
            request.httpBody = jsonData
        }
        
        AF.request(request).responseJSON { (response) in
            
            switch(response.result){
            case .success:
                let ModelRespons = response.result
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("api response",ModelRespons)
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                success(response)
                
                
                break
            case .failure (let error):
                
                var networkError = NetworkError()
                
                if error._code == NSURLErrorTimedOut {
                    networkError.status = Constant.NetworkErrorType.timout
                    networkError.message = Constant.NetworkErrorType.timoutError
                    
                    Falioure(networkError)
                } else if error._code == NSURLErrorNetworkConnectionLost{
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorNotConnectedToInternet{
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorCannotConnectToHost {
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorSecureConnectionFailed{
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                    
                }else{
                    
                    networkError.status = Constant.NetworkErrorType.generic
                    networkError.message = Constant.NetworkErrorType.genericError
                    
                    Falioure(networkError)
                }
                break
            }
            
            
        }
    }
    
    
    
    
    class func GetRequiest(url: String, parameters: Parameters?, success: @escaping (AFDataResponse<Any>)->Void, Falioure: @escaping (NetworkError) -> Void)   {
        let cookieStore = HTTPCookieStorage.shared
        for cookie in cookieStore.cookies ?? [] {
            cookieStore.deleteCookie(cookie)
        }
        let Manger = Alamofire.Session.default
        //UserDefaults.standard.value(forKey: "userAuthToken") as? String
        let  Headers : HTTPHeaders
        if let userToken = ShareData.shareInfo.token  {
            Headers = [
                "Accept": "application/json",
                "Authorization" : "Bearer " +  userToken,
            ]
        } else {
            Headers = [
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Accept": "application/json",
                "Content-type": "multipart/form-data"
            ]
        }
        print(Headers)
        
        Manger.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Headers).validate(statusCode: 200..<600).responseJSON(completionHandler:{(response) -> Void in
            
            switch(response.result)
            {
                
            case .success:
                let RespomseModel = response.result
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print(RespomseModel)
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                success(response)
            case .failure (let error):
                
                
                var networkError = NetworkError()
                
                if error._code == NSURLErrorTimedOut {
                    networkError.status = Constant.NetworkErrorType.timout
                    networkError.message = Constant.NetworkErrorType.timoutError
                    
                    Falioure(networkError)
                } else if error._code == NSURLErrorNetworkConnectionLost {
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorNotConnectedToInternet{
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorCannotConnectToHost {
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorSecureConnectionFailed{
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                    
                }else{
                    
                    networkError.status = Constant.NetworkErrorType.generic
                    networkError.message = Constant.NetworkErrorType.genericError
                    
                    Falioure(networkError)
                }
                break
            }
            
        } )
        
    }
    
    
    class func DeleteRequest(url: String, parameters: Parameters?, success:@escaping (AFDataResponse<Any>)->Void ,Falioure: @escaping (NetworkError) -> Void )
    {
        let cookieStore = HTTPCookieStorage.shared
        for cookie in cookieStore.cookies ?? [] {
            cookieStore.deleteCookie(cookie)
        }
        let Manger = Alamofire.Session.default
        var Headers : HTTPHeaders
        
        
        if let userToken = ShareData.shareInfo.token {
            Headers = [
                "Accept": "application/json",
                "Authorization"  : "Bearer " + userToken   //"Authorization"
            ]
        } else {
            Headers = [
                "Accept": "application/json"
            ]
            
        }
        
        Manger.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: Headers).validate(statusCode: 200..<600).responseJSON{ (response)-> Void in
            
            switch(response.result)
            {
            case .success:
                let ModelRespons = response.result
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("api response",ModelRespons)
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                success(response)
                
                break
            case .failure (let error):
                
                var networkError = NetworkError()
                
                if error._code == NSURLErrorTimedOut {
                    networkError.status = Constant.NetworkErrorType.timout
                    networkError.message = Constant.NetworkErrorType.timoutError
                    
                    Falioure(networkError)
                } else if error._code == NSURLErrorNetworkConnectionLost{
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorNotConnectedToInternet{
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorCannotConnectToHost {
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorSecureConnectionFailed{
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                    
                }else{
                    
                    networkError.status = Constant.NetworkErrorType.generic
                    networkError.message = Constant.NetworkErrorType.genericError
                    
                    Falioure(networkError)
                }
                break
            }
            
            
        }
        
        
    }
    
    
    class func Multipart(url: String,filename:String, parameters: Parameters?,userimg: UIImage,Progress: @escaping (Int) ->Void, Success: @escaping (AFDataResponse<Any>)->Void, Falioure: @escaping (NetworkError) -> Void)
    {
        let cookieStore = HTTPCookieStorage.shared
        for cookie in cookieStore.cookies ?? [] {
            cookieStore.deleteCookie(cookie)
        }
        print(url)
        print(filename)
        print(userimg)
        
        var Headers : HTTPHeaders
        let Manger = Alamofire.Session.default
        if let userToken = ShareData.shareInfo.token {
            Headers = [
                "Accept": "application/json",
                "Authorization" : "Bearer " +  userToken,
                "Content-type": "multipart/form-data"
            ]
        }else
        {
            Headers = ["Accept": "application/json"]
        }
        
        
        let fileName = filename//"image"
        Manger.upload(multipartFormData: {(multipart) in
            
            if let data = userimg.jpegData(compressionQuality: 0.1)
            {
                print(data)
                multipart.append(data, withName: fileName, fileName: filename, mimeType: "any")
            }
        }, to: url, method: .post, headers: Headers) .responseJSON(completionHandler: { result in
            
            switch(result.result)
            {
                
            case .success:
                let resultValue = result.result
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print(resultValue)
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                Success(result)
                break
                
            case .failure (let error):
                
                
                var networkError = NetworkError()
                
                if error._code == NSURLErrorTimedOut {
                    networkError.status = Constant.NetworkErrorType.timout
                    networkError.message = Constant.NetworkErrorType.timoutError
                    
                    Falioure(networkError)
                } else if error._code == NSURLErrorNetworkConnectionLost {
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorNotConnectedToInternet{
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorCannotConnectToHost {
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorSecureConnectionFailed{
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                    
                }else{
                    
                    networkError.status = Constant.NetworkErrorType.generic
                    networkError.message = Constant.NetworkErrorType.genericError
                    
                    Falioure(networkError)
                }
                break
                
            }
            
        })
        
        
        
    }
    
    
    
    class func MultipartPut(url: String,filename:String, parameters: Parameters?,userimg: UIImage,Progress: @escaping (Int) ->Void, Success: @escaping (AFDataResponse<Any>)->Void, Falioure: @escaping (NetworkError) -> Void)
    {
        let cookieStore = HTTPCookieStorage.shared
        for cookie in cookieStore.cookies ?? [] {
            cookieStore.deleteCookie(cookie)
        }
        print(url)
        print(filename)
        print(userimg)
        
        var Headers : HTTPHeaders
        let Manger = Alamofire.Session.default
        if let userToken = ShareData.shareInfo.token {
            Headers = [
                "Accept": "application/json",
                "Authorization" : "Bearer " +  userToken,
                "Content-type": "multipart/form-data"
            ]
        }else
        {
            Headers = ["Accept": "application/json"]
        }
        
        
        let fileName = filename//"image"
        Manger.upload(multipartFormData: {(multipart) in
            
            if let data = userimg.jpegData(compressionQuality: 0.1)
            {
                print(data)
                multipart.append(data, withName: fileName, fileName: filename, mimeType: "any")
            }
            for(key, values ) in parameters ?? [:]
            {
                multipart.append((values as! String).data(using: String.Encoding.utf8)!, withName: key)
                print(values)
                print(values)
            }
        }, to: url, method: .put, headers: Headers) .responseJSON(completionHandler: { result in
            
            switch(result.result)
            {
                
            case .success:
                let resultValue = result.result
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print(resultValue)
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                Success(result)
                break
                
            case .failure (let error):
                
                
                var networkError = NetworkError()
                
                if error._code == NSURLErrorTimedOut {
                    networkError.status = Constant.NetworkErrorType.timout
                    networkError.message = Constant.NetworkErrorType.timoutError
                    
                    Falioure(networkError)
                } else if error._code == NSURLErrorNetworkConnectionLost {
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorNotConnectedToInternet{
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorCannotConnectToHost {
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorSecureConnectionFailed{
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                    
                }else{
                    
                    networkError.status = Constant.NetworkErrorType.generic
                    networkError.message = Constant.NetworkErrorType.genericError
                    
                    Falioure(networkError)
                }
                break
                
            }
            
        })
        
        
        
    }
    
    class func Uploadfile(url: String,fileUrl:URL,mimeType:String,filename:String,fileWithName:String, parameters: Parameters?,Progress: @escaping (Int) ->Void, Success: @escaping (AFDataResponse<Any>)->Void, Falioure: @escaping (NetworkError) -> Void)
    {
        
        print(url)
        print(filename)
        print(fileUrl)
        
        var Headers : HTTPHeaders
        let Manger = Alamofire.Session.default
        if let userToken = ShareData.shareInfo.token {
            Headers = [
                "Accept": "application/json",
                "Authorization" : "Bearer " +  userToken,
                "Content-type": "multipart/form-data"
            ]
        }else
        {
            Headers = ["Accept": "application/json",
                       "Content-type": "multipart/form-data"
            ]
            
        }
        
        
        let fileName = filename//"image"
        Manger.upload(multipartFormData: {(multipart) in
            
            
            do {
                let videoData = try Data(contentsOf: fileUrl)
                print(videoData)
                multipart.append(videoData, withName: filename, fileName: fileWithName, mimeType: mimeType)
            } catch {
                debugPrint("Couldn't get Data from URL: \(fileUrl): \(error)")
            }
            
            
            for(key, values ) in parameters ?? [:]
            {
                multipart.append((values as! String).data(using: String.Encoding.utf8)!, withName: key)
                print(values)
                print(values)
            }
        }, to: url, method: .put, headers: Headers) .responseJSON(completionHandler: { result in
            
            switch(result.result)
            {
                
            case .success:
                let resultValue = result.result
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print(resultValue)
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                print("///////////////////////////////////////////////////////////////////////////")
                Success(result)
                break
                
            case .failure (let error):
                
                
                var networkError = NetworkError()
                
                if error._code == NSURLErrorTimedOut {
                    networkError.status = Constant.NetworkErrorType.timout
                    networkError.message = Constant.NetworkErrorType.timoutError
                    
                    Falioure(networkError)
                } else if error._code == NSURLErrorNetworkConnectionLost {
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorNotConnectedToInternet{
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorCannotConnectToHost {
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorSecureConnectionFailed{
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                    
                }else{
                    
                    networkError.status = Constant.NetworkErrorType.generic
                    networkError.message = Constant.NetworkErrorType.genericError
                    
                    Falioure(networkError)
                }
                break
                
            }
            
        })
        
        
        
    }
}
struct NetworkError {
    var status: Int = Constant.NetworkErrorType.generic
    var message: String = Constant.NetworkErrorType.genericError
}

struct NetworkSuccess {
    var status: Int = Constant.NetworkErrorType.generic
    var message: String = Constant.NetworkErrorType.genericError
}
