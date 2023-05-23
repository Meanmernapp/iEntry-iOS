//
//  constant.swift
//  CarInsurance
//
//  Created by Apple on 7/3/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

class Constant {
    
    static var MainUrl : String { return "http://38.65.139.14:8081/corporate-user-pre-prod-v2/"
        //"http://38.65.139.14:8081/corporate-user-pre-prod-v2" // FOR V2
    }
    static var MainUrl2 : String { return "http://38.65.139.14:8081/corporate-user-pre-prod-v2/"
        //"" // FOR V2
    }
    struct activitySize {
        static let size =  CGSize(width: 40, height: 40)
    }
    
    enum loaderMessages : String {
        case loadingMessage = "Loading..."
    }
    
    //AuthPArt
    struct URLs {
        
        //MARK: - Holidays
        
        static let cancelHoliday = "holiday-service/holiday/cancel/"
        static let createHoliday = "holiday-service/holiday/create"
        static let getHoliday = "holiday-service/holiday/get/by-user-id/"
        
        //MARK: - Others
        
        static let deleteNotification = "notification-service/delete-by-id"
        static let preRegister = "authentication-service/pre-register-user"
        static let Login = "authentication-service/log-in-mobile-app"
        static let checkuser = "authentication/checknewuser/"
        static let sendEmail = "authentication-service/send-email/reset-password/"
        static let updatepassword = "authentication-service/update-password-user-id/"
        static let sendFirstAccessSixDigitCode = "authentication-service/send-sms/reset-password/"
        static let generateToken = "otp/generate/"
        static let RegisterCompany = "company-service/create"
        static let Getcompany = "companies/company/get-by-id/"
        static let getUserImage = "user-service/user-image/get-selfie/by-user-id/"
        static let checkUserSelfiimage = "user-service/user-image/check-selfie/by-user-id/"
        static let getUserImageById = "user-service/user-image/get-by-id/"
        static let linkDevice = "user-service/link-device/device-id/"
        static let unlinkUserDevice = "user-service/unlink-device/by-id/"
        static let openTheDoorLink = "device-service/open-the-door"
        static let getuserbyemail = "user-service/get-by-email/"
        
        static let getcompanybyid = "company-service/get-by-id/"
        static let getallCompanies = "company-service/get-all"
        static let getGender = "gender-service/get-by-id/"
        static let getAllgender = "gender-service/get-all"
        static let createUserCompanyContract = "employee-service/create-contract-employee"//"user-company-service/create-contract-employee"
        static let updateUserCompanyContract = "employee-service/update-contract-employee"//"user-company-service/update-contract-employee"
        
        static let getcompanyRistriction = "company-service/company-restriction/get-by-company-id/"
        
        static let updateCompanyRidtriction = "company-service/company-restriction/update"
        static let onuEvent = "event-service/restriction/get"
        
        static let getZonebyId = "zone-service/get-by-id/"
        static let createZone  = "zone-service/create"
        static let getAllZone = "work-shift-service/get-all/allowed-zones"//"zone-service/get-all/allowed-zones"
        static let onBoardingServices =  "onboarding-service/get-by-role-id/"
        static let onBoardingDoneServices = "onboarding-service/process/user/done/"
        static let hideOnboarding = "user-service/dismiss-onboarding"
        static let createOnboardingList = "onboarding-service/process/user/create-list"
        
        static let CreateExtraDataUser = "extra-data-service/create"
        static let updateExtraDataUser = "extra-data-service/update-by-user-id/"///"extra-data-service/update"
        static let getSixDigitCode = "authentication-service/get-verification-code"
        //"authentication-service/get-verification-code/by-user-id" ///"authentication-service/get-verification-code/by-user-id/"
        
        
        static let userContractcompanyservice = "employee-service/get-by-user-id/"
        static let getRoleTask = "role-service/v1/app/task/get-all/"
        static let userContractcompanyservice2 = "employee-service/v1/app/get-by-user-id/"
        //"user-company-service/get-by-user-id/"
        static  let getAllInvitationByUserID = "invitation-service/get-all/by-guest-id/"
        static let createInvitation = "invitation-service/create"
        static let deleteInvitation2 = "invitation-service/delete-by-id/"
        static let searchUserByEmail = "user-service/get-by-email/"
        static let searchUserbyPhone = "user-service/get-by-phone-number/"
        //"user-service/user/get-by-phone-number/"
        
        static let getEventafterDate = "event-service/get-all/by-host-id/after-date" //"event-service/get-all/by-user-id/after-date"
        
        static let getBeforeDateEvent = "event-service/get-all/by-host-id/before-date" //"event-service/get-all/by-user-id/before-date"
        
        
        static let getcommenAreas = "work-shift-service/v1/app/reservation/get-all-free-common-areas-by-dates"//"event-service/reservation/get-all-free-common-areas-by-dates"
        
        static let getEventInvitationAfterDate = "event-service/get-all/by-host-id/after-date"//"event-service/get-all/by-host-id/before-date" //"event-service/get-all-invitations/by-user-id/after-date"
        //    http://38.65.139.14:8081/corporate-user-pre-prod-v2/order-service/v1/app/supplier/get-all/by-supplier-id/%7BsupplierId%7D/by-after-date/
        
        static let createEvent = "event-service/create"
        static let getEventDetailById = "event-service/get-by-id/"
        static let getAllInvitationAgainstEvent = "event-service/get-all-user-invitations/by-event-id/"
        //get-all-user-invitations/by-event-id
        static let sendInvitation = "event-service/create-user-invitations"
        //create-invitations"
        
        static let cancelEvent = "event-service/cancel-event/"
        static let notification = "notification-service/get-all/by-user-id/by-company-id/after-date-created" //"notification-service/get-all/by-user-id/by-company-id/after-date-created"
        static let createNotification = "notification-service/create"
        static let getExtraData = "extra-data-service/get-by-user-id/"
        static let getExtraDataHeaders = "extra-data-service/header/get"
        static let updateExtraData = "extra-data-service/update"
        
        static let updateEvent = "event-service/update"
        static let getUserbyID = "user-service/get-by-id/"
        static let updateUser = "user-service/update"
        ///by-company-id/"
        ///http://38.65.139.14:8080/corporate-user-pre-prod-v1/swagger-ui/index.html?urls.primaryName=Invitation%20Module#/invitation-controller/deleteByIdUsingDELETE_2
        
        static let getNotificationTypes = "notification-service/notification-type/get-all"
        //corporate-user-pre-prod-v1/employee-service/get-all/only-user-data
        static let getAllUsersList = "employee-service/get-all/only-user-data" //"employee-service/get-all-only-user-data/by-company-id/" //"user-company-service/get-all-only-user-data/by-company-id/"
        static let createNotificationWithUsers = "notification-service/user-notification/create/by-employees-ids"
        static let deleteInvitation = "event-service/delete-invitation-by-invitation-id/"
        
        static let updateInvitation = "invitation-service/validate-invitation/"
        
        
        //MARK:- Contractor Endpoints
        
        static let incomingContractList = "contract-service/v1/app/contractor/get-all/incoming-active/"
        static let contractHirotyList = "contract-service/v1/app/contractor/get-all/records/"
        
        static let getContractorByUserId = "contractor-service/get-by-user-id/"
        static let getallIncomingContractorEmployee = "contract-service/v1/app/contractor-employee/get-all/incoming-active/"
        
        static let getallRecordContractorEmployee = "contract-service/v1/app/contractor-employee/get-all/records/"
        
        static let getContractorEmployeeByUserID = "contractor-employee-service/get-by-user-id/"
        
        ///contractor/get-all/incoming-active/
        //MARK:- Provider Endpoint
        
        static let getproviderbyuserid = "supplier-service/get-by-user-id/"
        
        //MARK: - Vehicle
        
        static let getprovidervehicleuserid = "supplier-vehicle-service/v1/app/get-all/by-supplier-id/"
        static let getcontractorvehicleuserid = "contractor-vehicle-service/v1/app/get-all/by-contractor-id/"
        
        //MARK: - Employee
        
        static let getproviderEmployeeuserid = "supplier-employee-service/v1/app/get-all/by-supplier-id/"
        static let getcontractorEmployeeuserid = "contractor-employee-service/v1/app/get-all/by-contractor-id/"
        static let getorderrecordbyuserid = "order-service/v1/app/supplier/get-all/by-supplier-id/"
        static let getorderbyuserid = "order-service/get-by-id/"
        static let providerEmployeeOrder = "order-service/v1/app/supplier-employee/get-all/by-supplier-employee-id/"
        static let getprovideremployeebyuserid = "supplier-employee-service/get-by-user-id/"
        static let token = "token"
        static let getVehicleList = "vehicle-company-service/get-all-by-company-id"
        static let createVehicle = "vehicle-service/create-for-company"
        static let vehicleInvitation = "event-service/create-vehicle-invitations"
        static let uploadimage = "image-service/upload"
        
        static let downloadNotificationImage = "image-service/full-response/download-by-id/" //"image-service/download-by-id/"
        static let downloadEventFile = "file-service/full-response/download-report-onu/"//"full-response/download-report-onu/"
        
        static let userCompanyRestriction = "company-service/company-restriction"
        
    }
    
    struct NetworkErrorType {
        static let timeOutInterval: TimeInterval = 20
        
        static let error = "Error"
        static let internetNotAvailable = "Internet Not Available. Please Try Again"
        static let pleaseTryAgain = "Please Try Again".localized
        
        static let generic = 4000
        static let genericError = "Please Try Again.".localized
        
        static let serverErrorCode = 5000
        static let serverNotAvailable = "Server Not Available"
        static let serverError = "Server Not Available, Please Try Later."
        
        static let timout = 4001
        static let timoutError = "Network Time Out, Please Try Again."
        
        static let login = 4003
        static let loginMessage = "Unable To Login"
        static let loginError = "Please Try Again.".localized
        
        static let internet = 4004
        static let internetError = "lb_info_no_internet_connection".localized
    }
    
    struct NetworkSuccess {
        static let statusOK = 200
    }
    
}

let NOTIFICATIONS_UPDATED = "NOTIFICATIONS_UPDATED"
