//
//  LoginViewModel.swift
//  iEntry
//
//  Created by ZAFAR on 17/09/2021.
//

import Foundation
import UIKit
class  LoginViewModel {
    
    var loginData : LoginModel?
    weak var loginvc : LoginVC?
    
     func loginApiCall(params:[String:Any],Success: @escaping (LoginModel?,String?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url = Constant.MainUrl + Constant.URLs.Login
        print("url :",url)
                Networkhandler.PostRequest(url: url, parameters: params, success: {(successResponse)  in
        
                    do {
                    print("Login MyResponse : ", successResponse)
                        let responseModel = try JSONDecoder().decode(LoginModel.self, from: successResponse.data!)
                        
                        Success(responseModel,nil)
        
                    }
                    catch {
                        Success(nil,"Somthing is wrong")
                    }
        
        
                } , Falioure: {(Error) in
                    Failure(Error)
                })
            }
    
    
    
    //MARK:- CheckUSer api Call

    func checkUser(email:String,Success: @escaping (CheckUserModel?,String?) -> Void, Failure: @escaping(NetworkError) -> Void){
       let url = Constant.MainUrl + Constant.URLs.checkuser + "\(email)"
       print(url)
               Networkhandler.GetRequiest(url: url, parameters: nil, success: {(successResponse)  in

                   do {
                   print("MyResponse : ", successResponse)
                       let responseModel = try JSONDecoder().decode(CheckUserModel.self, from: successResponse.data!)

                       Success(responseModel,nil)

                   }
                   catch {
                       Success(nil,"Somthing is wrong")
                   }


               } , Falioure: {(Error) in
                   Failure(Error)
               })
           }
    
    
    //MARK:- SendEmail api Call
    
    func sendEmail(email:String,Success: @escaping (SendEmailModel?,String?) -> Void, Failure: @escaping(NetworkError) -> Void){
       let url = Constant.MainUrl + Constant.URLs.sendEmail + "\(email)"
              
               Networkhandler.GetRequiest(url: url, parameters: nil, success: {(successResponse)  in

                   do {
                   print("MyResponse : ", successResponse)
                       let responseModel = try JSONDecoder().decode(SendEmailModel.self, from: successResponse.data!)

                       Success(responseModel,nil)

                   }
                   catch {
                       Success(nil,"Somthing is wrong")
                   }


               } , Falioure: {(Error) in
                   Failure(Error)
               })
           }
    func sendOTP(email:String,Success: @escaping (SendEmailModel?,String?) -> Void, Failure: @escaping(NetworkError) -> Void){
       let url = Constant.MainUrl + Constant.URLs.sendFirstAccessSixDigitCode + "\(email)"
              
               Networkhandler.GetRequiest(url: url, parameters: nil, success: {(successResponse)  in

                   do {
                   print("MyResponse : ", successResponse)
                       let responseModel = try JSONDecoder().decode(SendEmailModel.self, from: successResponse.data!)

                       Success(responseModel,nil)

                   }
                   catch {
                       Success(nil,"Somthing is wrong")
                   }


               } , Falioure: {(Error) in
                   Failure(Error)
               })
           }

    //MARK:- OTP Validate api Call

    func otpValidate(email:String, otp:String,Success: @escaping (CheckUserModel?,String?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url =  Constant.MainUrl + "authentication-service/check-verification-code/\(otp)/by-username/\(email)"

        print("url:",url)
        
               Networkhandler.GetRequiest(url: url, parameters: nil, success: {(successResponse)  in

                   do {
                   print("MyResponse : ", successResponse)
                       let responseModel = try JSONDecoder().decode(CheckUserModel.self, from: successResponse.data!)

                       Success(responseModel,nil)

                   }
                   catch {
                       Success(nil,"Somthing is wrong")
                   }


               } , Falioure: {(Error) in
                   Failure(Error)
               })
           }

    //MARK:- UpdatePassword Validate api Call

    func updatePAssword(userid:String,parms:[String:Any],Success: @escaping (CheckUserModel?,String?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url =  Constant.MainUrl + Constant.URLs.updatepassword + "\(userid)"

               Networkhandler.PutRequest(url: url, parameters: parms, success: {(successResponse)  in

                   do {
                   print("MyResponse : ", successResponse)
                       let responseModel = try JSONDecoder().decode(CheckUserModel.self, from: successResponse.data!)

                       Success(responseModel,nil)

                   }
                   catch {
                       Success(nil,"Somthing is wrong")
                   }


               } , Falioure: {(Error) in
                   Failure(Error)
               })
           }

    //MARK:- Generat token  api Call

    func generateToken(email:String,Success: @escaping (GenerateTokenModel?,String?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url =  Constant.MainUrl + Constant.URLs.generateToken + "\(email)"

               Networkhandler.PostRequest(url: url, parameters: nil, success: {(successResponse)  in

                   do {
                   print("MyResponse : ", successResponse)
                       let responseModel = try JSONDecoder().decode(GenerateTokenModel.self, from: successResponse.data!)

                       Success(responseModel,nil)

                   }
                   catch {
                       Success(nil,"Somthing is wrong")
                   }


               } , Falioure: {(Error) in
                   Failure(Error)
               })
           }
    
    //MARK:- Get User By Email

    func getUserByEmail(email:String,Success: @escaping (GetUserByEmailModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url =  Constant.MainUrl + Constant.URLs.getuserbyemail + "\(email)"
              print("GetUser URL:",url)
               Networkhandler.GetRequiest(url: url, parameters: nil, success: {(successResponse)  in

                   do {
                   print("MyResponse : ", successResponse)
                       let responseModel = try JSONDecoder().decode(GetUserByEmailModel.self, from: successResponse.data!)

                       Success(responseModel)

                   }
                   catch {
                       
                       print("Response Error")
                       Success(nil)
                   }


               } , Falioure: {(Error) in
                   Failure(Error)
               })
           }

}
    
    
