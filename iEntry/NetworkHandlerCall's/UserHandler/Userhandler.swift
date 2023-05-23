//
//  Userhandler.swift
//  CarInsurance
//
//  Created by Apple on 7/3/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

import Alamofire


class userhandler {
    
    //MARK: - Holiday
    class func getHolidaysByID(userid:String,Success: @escaping (HolidayModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url = Constant.MainUrl + Constant.URLs.getHoliday + userid
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(HolidayModel.self, from: successResponse.data!)
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
    
    class func cancelHoliday(holidayID:String,Success: @escaping (OpenDoorModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.cancelHoliday + "\(holidayID)"
        print("CancelHliday url",url)
        Networkhandler.DeleteRequest(url: url, parameters: nil) { (successResponse) in
            do {
                //print(successResponse)
                let responseModel = try JSONDecoder().decode(OpenDoorModel.self, from: successResponse.data!)
                Success(responseModel)
            }
            catch {
                print("Response Error")
            }
        } Falioure: { (Error) in
            Failure(Error)
        }
     }
    
    class func createHoliday(params:[String:Any],Success: @escaping (CreateUserContractModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.createHoliday
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateUserContractModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK: - Others
    
   class func getGender(id:Int,Success: @escaping (GetGenderModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
    let url = Constant.MainUrl + Constant.URLs.getGender + "\(id)"
       
        Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

            do {
                //print(successResponse)
                let responseModel = try JSONDecoder().decode(GetGenderModel.self, from: successResponse.data!)
                Success(responseModel)
            }
            catch {
                print("Response Error")
            }


        } , Falioure: {(Error) in
            Failure(Error)
        })
    }
    
    
    class func getAllGender(Success: @escaping (GetAllGenderModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getAllgender
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetAllGenderModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }

    
    
    
    class func createUserEmployeeContract(params:[String:Any],Success: @escaping (CreateUserContractModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.createUserCompanyContract
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateUserContractModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    
    class func updateUserEmployeeContract(params:[String:Any],Success: @escaping (CreateUserContractModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.updateUserCompanyContract
        
         Networkhandler.PutRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateUserContractModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    
    class func getZoneByID(Success: @escaping (GetZoneModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getZonebyId
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetZoneModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }

    
    class func createZone(params:[String:Any],Success: @escaping (CreateZoneModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.createZone
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateZoneModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- Get All Zones
    
    class func getAllZone(params:[String:Any],Success: @escaping (GetAllZonesModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getAllZone
        print("All Zone URl", url, params)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetAllZonesModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    class func createExtradatauser(params:[String:Any],Success: @escaping (CreateExtraUserDataModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.CreateExtraDataUser
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateExtraUserDataModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    class func updateExtradatauser(params:[String:Any],id:String,Success: @escaping (CreateExtraUserDataModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.updateExtraDataUser + id
        print("url",url)
         Networkhandler.PutRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateExtraUserDataModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
   
    //[8:39 pm] Luis Enrique Cornejo Arreola
    //corporate-user-pre-prod-v1/authentication-service/set-firebase-id/{firebaseId}

   
    class func sendFCMToken(fcmtoken:String,Success: @escaping (FCMTokenModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url = Constant.MainUrl + "authentication-service/set-firebase-id/\(fcmtoken)"
        //"/user-id/\(ShareData.shareInfo.obj?.id ?? "")"
        print("firabse url ", url)
         Networkhandler.PutRequest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print("firebase save",successResponse)
                 let responseModel = try JSONDecoder().decode(FCMTokenModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    class func getSixDigitCode(Success: @escaping (SixDigitCodeModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url = Constant.MainUrl + Constant.URLs.getSixDigitCode //+ "\(ShareData.shareInfo.obj?.id! ?? "")"
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(SixDigitCodeModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    //FirstAccessSixDigitCodeModel
    
    
    class func getFirstAccessSixDigitCode(email:String,Success: @escaping (FirstAccessSixDigitCodeModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url = Constant.MainUrl + Constant.URLs.sendEmail + email
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(FirstAccessSixDigitCodeModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    class func getFirstAccessSendSMSSixDigitCode(email:String,Success: @escaping (FirstAccessSixDigitCodeModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url = Constant.MainUrl + Constant.URLs.sendFirstAccessSixDigitCode + email
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
//                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(FirstAccessSixDigitCodeModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
//    class func getUserImage(userid:String,Success: @escaping (DownloadNotificationImageModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
//        let url = Constant.MainUrl + Constant.URLs.getUserImage + userid
//
//         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in
//
//             do {
//                 //print(successResponse)
//                 let responseModel = try JSONDecoder().decode(DownloadNotificationImageModel.self, from: successResponse.data!)
//                 Success(responseModel)
//             }
//             catch {
//                 print("Response Error")
//                 Success(nil)
//             }
//
//
//         } , Falioure: {(Error) in
//             Failure(Error)
//         })
//     }
    
    
    class func getCheckUserSelfiImage(userid:String,Success: @escaping (DownloadNotificationImageModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url = Constant.MainUrl + Constant.URLs.checkUserSelfiimage + userid
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(DownloadNotificationImageModel.self, from: successResponse.data!)
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
    
    
    
    
    class func downloadNotificationimage(notificationid:String,option:String,Success: @escaping (DownloadNotificationImageModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url = Constant.MainUrl + Constant.URLs.downloadNotificationImage + notificationid + "/option/\(option)"
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(DownloadNotificationImageModel.self, from: successResponse.data!)
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
    
    
    //MARK: - Get User Image By ID
    
    class func GetUserImageByID(userid:String,Success: @escaping (UserProfileImageModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url = Constant.MainUrl + Constant.URLs.getUserImageById + userid
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(UserProfileImageModel.self, from: successResponse.data!)
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
    
    
    
    class func downloadNotificationFile(notificationid:String,Success: @escaping (DownloadNotificationImageModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url = Constant.MainUrl + Constant.URLs.downloadNotificationImage + notificationid + "/option/notification_file"
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(DownloadNotificationImageModel.self, from: successResponse.data!)
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
    
    
    
    class func downloadEventFile(eventid:String,Success: @escaping (DownloadNotificationImageModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url = Constant.MainUrl + Constant.URLs.downloadEventFile + eventid 
        print("Event file ",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(DownloadNotificationImageModel.self, from: successResponse.data!)
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
    
    
///check-verification-code/{code}/by-username/{username}
    
    class func verifySixDigitCode(Success: @escaping (VerifySixDigitCodeModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url = Constant.MainUrl +  "authentication-service/check-verification-code/\(ShareData.shareInfo.obj?.id! ?? "")/by-username/\(ShareData.shareInfo.obj?.email! ?? "")"
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(VerifySixDigitCodeModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- Get Contract By USer ID
    
    class func getContractByUserID(id:String,Success: @escaping (GetContractByUserModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.userContractcompanyservice + id
        print("contract url company", url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print("contract data:",successResponse)
                 let responseModel = try JSONDecoder().decode(GetContractByUserModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    class func getRoleTasks(Success: @escaping (BaseModelCompanyRoleV2?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl2 + Constant.URLs.getRoleTask
        print("contract url company", url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print("contract data:",successResponse)
                 let responseModel = try JSONDecoder().decode(BaseModelCompanyRoleV2.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    

    class func getContractDataV2(Success: @escaping (BaseModelCompanyDataV2?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl2 + Constant.URLs.userContractcompanyservice2
        print("contract url company", url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print("contract data:",successResponse)
                 let responseModel = try JSONDecoder().decode(BaseModelCompanyDataV2.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    //MARK:- Link Device
    
    class func LinkUserDevice(deviceID:String,Success: @escaping (LoginModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.linkDevice + deviceID
        print("url Link Device", url)
         Networkhandler.PutRequest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(LoginModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    //MARK:- unLink Device
    
    class func unLinkUserDevice(userID:String,Success: @escaping (OpenDoorModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.unlinkUserDevice + userID
        print("url unlink device", url)
         Networkhandler.PutRequest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(OpenDoorModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    //MARK:- Get getCompany Ristrictions
    
    class func getCompanyristrictionByID(id:String,Success: @escaping (CompanyRistriction?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getcompanyRistriction + id
        print("url company", url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print("company resitriction:",successResponse)
                 let responseModel = try JSONDecoder().decode(CompanyRistriction.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    //MARK:- Get Update Company Ristrictions
    
    class func updateCompanyristrictionByID(param:[String:Any],Success: @escaping (CompanyRistriction?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.updateCompanyRidtriction
        print("url company", url)
         Networkhandler.PutRequest(url: url, parameters: param,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(CompanyRistriction.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- Get All Invitations By USer ID
    
    class func getInvitationsByUserID(id:String,Success: @escaping (GetallInvitationModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getAllInvitationByUserID + id
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetallInvitationModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- Pre Registrarion
    
    class func preRegisteration(params:[String:Any],Success: @escaping (getUserIsExistModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl2 + Constant.URLs.preRegister
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(getUserIsExistModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- check user Existience
    
    class func checkUserExist(phone:String,isphone:Bool,Success: @escaping (getUserIsExistModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     var url = ""
        
        
        if isphone == true  {
            url = Constant.MainUrl + Constant.URLs.searchUserbyPhone + phone
        } else {
            url = Constant.MainUrl + Constant.URLs.searchUserByEmail + phone
        }
        
        print("check user url", url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(getUserIsExistModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    //MARK:- Create Invitation
    
    class func createInvitation(params:[String:Any],Success: @escaping (CreateInvitationModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.createInvitation
         print("Create Invitation:", url)
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateInvitationModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 Success(nil)
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- getEvent by user id after Date
    
    class func getEventsAfterDate(afterdate:Int,Success: @escaping (EventModule?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl2 + Constant.URLs.getEventafterDate + "/\(afterdate)"
        print("EventsUrl:",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(EventModule.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error, Parsing Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- getEvent by user id Before Date
    
    class func getEventsBeforeDate(beforedate:Int,Success: @escaping (EventModule?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getBeforeDateEvent + "/\(beforedate)"
        print("belfore Date Url :", url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 
                 let responseModel = try JSONDecoder().decode(EventModule.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    //MARK:- getCommen Areas
    
    class func getallCommenAreas(params:[String:Any],Success: @escaping (CommenAreasModels?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getcommenAreas
          print("Commen area url:",url)
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(CommenAreasModels.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    
    //MARK:- getInvitations by user id after Date
    
    //EventInvitationsModels
    class func getEventsinvitatinsAftereDate(miliseconds:Int,Success: @escaping (EventModule?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl2 + Constant.URLs.getEventInvitationAfterDate + "/\(miliseconds)/to-validate"
        print("UrleventInvitation", url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(EventModule.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    class func getOnuEvent(Success: @escaping (OnuEvent?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl2 + Constant.URLs.onuEvent
        print("Onu Event", url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(OnuEvent.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    //MARK:- Create Event
    
    class func createEvent(params:[String:Any],Success: @escaping (CreateEventModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl2 + Constant.URLs.createEvent
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateEventModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- getEvent Detail
    
    class func getEventDetail(id:String,Success: @escaping (EventDetailModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getEventDetailById + id
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(EventDetailModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- getAll invitations Against Event
    
    class func getInvitationsAgainstEvent(id:String,Success: @escaping (getAllInvitationsAgainstEventModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getAllInvitationAgainstEvent + id
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(getAllInvitationsAgainstEventModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    //MARK:- send Invitation
    
    class func sendInvitation(params:[String:Any],Success: @escaping (EventUpdateInvitationModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.sendInvitation
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(EventUpdateInvitationModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- Cancel Invitation
    
    class func CancelInvitation(id:String,Success: @escaping (CancelEventModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.cancelEvent + "\(id)"
        
         Networkhandler.PutRequest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(CancelEventModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- get Notification After Date
    
    class func getNotificationAfterDate(afterdate:Int,Success: @escaping (NotificationModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.notification + "/\(afterdate)"
        print("Notification url",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(NotificationModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK: - Delete notification
    
    class func deleteNotification(ID:String,Success: @escaping (OpenDoorModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.deleteNotification + "/\(ID)"
        print("Delete Notification url",url)
        Networkhandler.DeleteRequest(url: url, parameters: nil) { (successResponse) in
            do {
                //print(successResponse)
                let responseModel = try JSONDecoder().decode(OpenDoorModel.self, from: successResponse.data!)
                Success(responseModel)
            }
            catch {
                print("Response Error")
            }
        } Falioure: { (Error) in
            Failure(Error)
        }
     }
    class func deleteInvitation(ID:String,Success: @escaping (OpenDoorModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.deleteInvitation + "/\(ID)"
        print("Delete Notification url",url)
        Networkhandler.DeleteRequest(url: url, parameters: nil) { (successResponse) in
            do {
                //print(successResponse)
                let responseModel = try JSONDecoder().decode(OpenDoorModel.self, from: successResponse.data!)
                Success(responseModel)
            }
            catch {
                print("Response Error")
            }
        } Falioure: { (Error) in
            Failure(Error)
        }
     }
    
    class func getUserCompanyRistrictionData(Success: @escaping (userCompanyRestrictionModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.userCompanyRestriction
        print("user company rsitriction url",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(userCompanyRestrictionModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- Create Notification
    
    class func createNotification(params:[String:Any],Success: @escaping (CreateNotificationModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.createNotification
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateNotificationModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK: Get Extra Data
    class func getExtraData(id:String,Success: @escaping (ExtradataModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getExtraData + id
          print("extra data url",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(ExtradataModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    class func getExtraDataHeaders(Success: @escaping (HeadersModel?) -> Void, Failure: @escaping(NetworkError) -> Void) {
     let url = Constant.MainUrl + Constant.URLs.getExtraDataHeaders
          print("extra data url",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(HeadersModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- Update Extra Data
    class func updateExtraData(id:String,Success: @escaping (ExtradataModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.updateExtraData
        
         Networkhandler.PutRequest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(ExtradataModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    //MARK:- Update event
    class func updateEvent(param:[String:Any],Success: @escaping (CreateEventModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.updateEvent
        
         Networkhandler.PutRequest(url: url, parameters: param,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateEventModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    //MARK: Get User
    class func getUser(id:String,Success: @escaping (LoginModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl2 + Constant.URLs.getUserbyID + id
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(LoginModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    //MARK:- Update user
    class func updateuser(companyid:String,param:[String:Any],Success: @escaping (LoginModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl2 + Constant.URLs.updateUser //+ companyid
          print("User Info Update",url)
         Networkhandler.PutRequest(url: url, parameters: param,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(LoginModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    //GetAllNotificationTypesModel
    
    //MARK: Get Notifications Type
    class func getAllNotificationTypes(Success: @escaping (GetAllNotificationTypesModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getNotificationTypes
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetAllNotificationTypesModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    //MARK: Get all users
    class func getAllusers(companyid:String,Success: @escaping (GetAllUsersListModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getAllUsersList  //+ companyid
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetAllUsersListModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    
    //MARK:- Create Notification With Users List
    
    class func createNotificationWithUsers(params:[String:Any],Success: @escaping (CreateNotificationWithUsersListModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.createNotificationWithUsers
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateNotificationWithUsersListModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    
    //MARK:- Delete Invitation User
    
    class func deleteInvitation(invitationid:String,Success: @escaping (InvitationUserDeleteModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.deleteInvitation + invitationid
        
        Networkhandler.DeleteRequest(url: url, parameters: nil,success: {(successResponse)   in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(InvitationUserDeleteModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    class func deleteInvitation2(invitationid:String,Success: @escaping (InvitationUserDeleteModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.deleteInvitation2 + invitationid
        
        Networkhandler.DeleteRequest(url: url, parameters: nil,success: {(successResponse)   in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(InvitationUserDeleteModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    //MARK:- get All ContractLists
    
    class func getAllIncomingContractList(milisecond:Int,newurl:String,Success: @escaping (IncomingContractListModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
        var url = ""
        
            url = newurl + "\(milisecond)" //Constant.MainUrl + Constant.URLs.incomingContractList
       
         //url = Constant.MainUrl + Constant.URLs.contractHirotyList
        
        print("page url :", url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(IncomingContractListModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    
    
    //MARK: Get Contractor By user ID
    class func getContractorByUserIDs(userid:String,Success: @escaping (GetContractorByUserIdModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getContractorByUserId + userid
          print("contractorEmplye Url :", url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetContractorByUserIdModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    
    //MARK: Get Contractor Employee By user ID
    class func getContractorEmployeeByUserIDs(userid:String,Success: @escaping (GetContractorEmployeeByUserIDModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getContractorEmployeeByUserID + userid
        print("ContractorEmp:",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetContractorEmployeeByUserIDModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    class func getOnboardingInformation(roleId:String,Success: @escaping (OnboardingModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.onBoardingServices + roleId
        print("Onboarding:",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(OnboardingModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    class func getOnboardingDone(userID:String,Success: @escaping (OnboardingDoneModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.onBoardingDoneServices + userID
        print("Onboarding:",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(OnboardingDoneModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    class func hideOnboarding(Success: @escaping (HideOnBoarding?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.hideOnboarding
        
         Networkhandler.PutRequest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(HideOnBoarding.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    class func sendUserProcessess(parms:[String],Success: @escaping (HideOnBoarding?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.createOnboardingList
        print(url,parms)
         Networkhandler.PostArrayRequest(url: url, parameters: parms,success: {(successResponse)  in

             do {
                 let responseModel = try JSONDecoder().decode(HideOnBoarding.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    
    //MARK: Get Provider By user ID
    class func getProviderByUserIDs(userid:String,Success: @escaping (GetContractorByUserIdModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl2 + Constant.URLs.getproviderbyuserid + userid
        print("page url",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetContractorByUserIdModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    class func getProviderVehiclesByUserIDs(userid:String,Success: @escaping (GetVehicalByUserIdModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl2 + Constant.URLs.getprovidervehicleuserid + userid
        print("page url",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetVehicalByUserIdModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    class func getContractorVehiclesByUserIDs(userid:String,Success: @escaping (GetVehicalByUserIdModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getcontractorvehicleuserid + userid
        print("page url",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetVehicalByUserIdModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    class func getContractorEmployeeData(userid:String,Success: @escaping (GetEmployeeByUserIdModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl2 + Constant.URLs.getcontractorEmployeeuserid + userid
        print("page url",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetEmployeeByUserIdModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    class func getProviderEmployeeData(userid:String,Success: @escaping (GetEmployeeByUserIdModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl2 + Constant.URLs.getproviderEmployeeuserid + userid
        print("page url",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetEmployeeByUserIdModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    //MARK: Get Provider employee By user ID
    
    class func getProviderEmployeeByUserIDs(userid:String,Success: @escaping (ProviderUserByIdModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getprovideremployeebyuserid + userid
        print("page url",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(ProviderUserByIdModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    //MARK: Get Provider order record By user ID
    class func getBeforeDateProviderOrdersByUserIDs(userid:String,datevalue:String,isproviderEmployee:Bool,Success: @escaping (ProviderModels?) -> Void, Failure: @escaping(NetworkError) -> Void){
     var url = ""
        if isproviderEmployee == false {
        url = Constant.MainUrl2 + Constant.URLs.getorderrecordbyuserid + userid + "/by-before-date/\(datevalue)"
        } else {
            url = Constant.MainUrl2 + Constant.URLs.providerEmployeeOrder + userid + "/by-before-date/\(datevalue)"
        }
        print("page url : ",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in
             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(ProviderModels.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    // MARK: 
    
    // MARK: Get Provider After Date order record By user ID
    class func getAfterDateProviderOrdersByUserIDs(userid:String,datevalue:String,isproviderEmployee:Bool,Success: @escaping (ProviderModels?) -> Void, Failure: @escaping(NetworkError) -> Void){
     var url = ""
        if isproviderEmployee == false {
        url = Constant.MainUrl2 + Constant.URLs.getorderrecordbyuserid + userid + "/by-after-date/\(datevalue)"
        } else {
            url = Constant.MainUrl2 + Constant.URLs.providerEmployeeOrder + userid + "/by-after-date/\(datevalue)"
        }
        print("page url : ",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in
             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(ProviderModels.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    //Update invitation
    class func updateInvitation(id:String,option:Int,Success: @escaping (UpdateInvitationModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.updateInvitation + "\(id)/option/\(option)"
        
         Networkhandler.PutRequest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(UpdateInvitationModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    //MARK:- token
    class func getToken(parms:[String:Any],Success: @escaping (tokenModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.token
        print("token",url,parms)
         Networkhandler.PostRequest2(url: url, parameters: parms,success: {(successResponse)  in

             do {
                 print("token response ",successResponse)
                 let responseModel = try JSONDecoder().decode(tokenModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    //MARK: Get Contractor Employee By user ID
    class func getVehicleListByCompanyID(Success: @escaping (GetVehicleListModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getVehicleList
        print("ContractorEmp:",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetVehicleListModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    //MARK:- Create Vehicle
    class func createVehicle(parms:[String:Any],Success: @escaping (CreateVehicleModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.createVehicle
        print("token",url,parms)
         Networkhandler.PostRequest(url: url, parameters: parms,success: {(successResponse)  in

             do {
                 print("token response ",successResponse)
                 let responseModel = try JSONDecoder().decode(CreateVehicleModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 Success(nil)
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    
    
    //MARK:- Vehicle Invitation
    
    class func sendvehicleInvitation(params:[String:Any],Success: @escaping (VehicleInvitationModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.vehicleInvitation
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(VehicleInvitationModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    class func uploadImage(param:[String:Any],img:UIImage?,file:String,Success: @escaping (UploadFileImageModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.uploadimage
        print("url company", url)
        Networkhandler.MultipartPut(url: url, filename: file, parameters: param, userimg: img!, Progress: {progress in
            
        }, Success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(UploadFileImageModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    class func uploadUserFile(fileName:String = "file",param:[String:Any],fileurl:URL,Success: @escaping (UploadFileImageModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.uploadimage
        print("url company", url)
        Networkhandler.Uploadfile(url: url, fileUrl: fileurl, mimeType: "any", filename: "file", fileWithName: fileName, parameters: param, Progress: {progress in
            
        }, Success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(UploadFileImageModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    
    class func openTheEmplyeeDoor(param:[String:Any],Success: @escaping (OpenDoorModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.openTheDoorLink//updateUserCompanyContract
        
         Networkhandler.PutRequest(url: url,isfromQR: true, parameters: param,success: {(successResponse)  in

             do {
                 //print(successResponse)
                 let responseModel = try JSONDecoder().decode(OpenDoorModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
}






struct APIResponse<T: Decodable>: Decodable {
    var data: T?
    var code: Int
    var success: Bool
    var http_response: Int
}

func decode<T: Decodable>(data: Data, ofType: T.Type) -> T? {
    do {
        let decoder = JSONDecoder()
        let res = try decoder.decode(APIResponse<T>.self, from: data)
        return res.data
    } catch let parsingError {
        print("Error", parsingError)
    }
    return nil
}
