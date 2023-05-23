//
//  CompanyRegisterModelView.swift
//  iEntry
//
//  Created by ZAFAR on 16/10/2021.
//

import Foundation
class CompanyregisterModelView{
    
    
    
    func companyRegisterApiCall(params:[String:Any],Success: @escaping (CompanyRegisterModel?,String?) -> Void, Failure: @escaping(NetworkError) -> Void){
          let url = Constant.MainUrl + Constant.URLs.RegisterCompany
          print(url)
               Networkhandler.PostRequest(url: url, parameters: params, success: {(successResponse)  in
       
                   do {
                   print("MyResponse : ", successResponse)
                       let responseModel = try JSONDecoder().decode(CompanyRegisterModel.self, from: successResponse.data!)
                       
                       Success(responseModel,nil)
       
                   }
                   catch {
                       Success(nil,"Somthing is wrong")
                   }
       
       
               } , Falioure: {(Error) in
                   Failure(Error)
               })
           }
    
    
    
    
    func getCompanyByID(ID:String,Success: @escaping (CompanyRegisterModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url = Constant.MainUrl + Constant.URLs.getcompanybyid + "\(ID)"
       print(url)
               Networkhandler.GetRequiest(url: url, parameters: nil, success: {(successResponse)  in
       
                   do {
                   print("MyResponse : ", successResponse)
                       let responseModel = try JSONDecoder().decode(CompanyRegisterModel.self, from: successResponse.data!)
                       
                       Success(responseModel)
       
                   }
                   catch {
                    print("Response not matching")
                       Success(nil)
                   }
       
       
               } , Falioure: {(Error) in
                   Failure(Error)
               })
           }
    
    
    func getAllCompanies(ID:String,Success: @escaping (GetAllCompaniesModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url = Constant.MainUrl + Constant.URLs.getallCompanies
       print(url)
               Networkhandler.GetRequiest(url: url, parameters: nil, success: {(successResponse)  in
       
                   do {
                   print("MyResponse : ", successResponse)
                       let responseModel = try JSONDecoder().decode(GetAllCompaniesModel.self, from: successResponse.data!)
                       
                       Success(responseModel)
       
                   }
                   catch {
                       Success(nil)
                   }
       
       
               } , Falioure: {(Error) in
                   Failure(Error)
               })
           }
}
