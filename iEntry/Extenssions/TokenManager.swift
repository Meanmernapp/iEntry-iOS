//
//  TokenManager.swift
//  iEntry
//
//  Created by ZAFAR on 19/04/2022.
//

import Foundation
import Alamofire
class TokenManager {
    static let shareToken = TokenManager()
    private init(){}
    var tokenModeldata : tokenModel?
    func parsingToken()-> Bool{
        
            let jwt = ShareData.shareInfo.token

            // get the payload part of it
        var payload64 = jwt?.components(separatedBy: ".")[1]

            // need to pad the string with = to make it divisible by 4,
            // otherwise Data won't be able to decode it
        while payload64!.count % 4 != 0 {
            payload64! += "="
            }

            print("base64 encoded payload: \(payload64)")
        let payloadData = Data(base64Encoded: payload64!,
                                   options:.ignoreUnknownCharacters)!
            let payload = String(data: payloadData, encoding: .utf8)!
            print(payload)
        
        
        let json = try! JSONSerialization.jsonObject(with: payloadData, options: []) as! [String:Any]
        let exp = json["exp"] as! Int
        let expDate = Date(timeIntervalSince1970: TimeInterval(exp))
        let isValid = expDate.compare(Date()) == .orderedDescending
        return isValid
    }
    
    
    
    func token(email:String,password:String, token:@escaping (String)->Void){
        let dic: [String:Any] =  ["email":email,"password":password]
           print(dic)
        var Headers : HTTPHeaders

        Headers = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "Content-type": "multipart/form-data",
                   "Content-Type" :"application/x-www-form-urlencoded"
               ]

        let Manger = Alamofire.Session.default
        print(Constant.MainUrl + "token")
        Manger.request(Constant.MainUrl + "token", method: .post, parameters: dic, encoding: URLEncoding.default,headers:Headers).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    print("token response ",response)
                    let responseModel = try JSONDecoder().decode(tokenModel.self, from: response.data!)
                    self.tokenModeldata = responseModel
                    print(responseModel)
                    ShareData.shareInfo.token = self.tokenModeldata?.access_token
                    token(self.tokenModeldata?.access_token ?? "")
                }
                catch {
                    token("")
                    print("Response Error")
                }

            case .failure(let error):
                token("")
                print("error :",error)
            }
        }
        

            
    
    }
}
