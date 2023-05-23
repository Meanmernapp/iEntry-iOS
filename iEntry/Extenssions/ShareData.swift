//
//  ShareData.swift
//  Tanzeem
//
//  Created by Zafar Najmi on 03/08/2020.
//  Copyright © 2020 Zafar Najmi. All rights reserved.
//

import Foundation
import KRProgressHUD
class ShareData {
    static let shareInfo = ShareData()
    private init (){}
    
    var onBoardingData :OnboardingModel?
    var headersData :HeadersData?
    var doneProcess : OnboardingDoneModel?
    func saveOnboarding(ONBOARDING:OnboardingModel?){
        onBoardingData = ONBOARDING
        setonBoardingData(data: onBoardingData ?? nil )
    }
    
    
    func setonBoardingData(data:OnboardingModel?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            UserDefaults.resetStandardUserDefaults()
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "OnboardingModel")
            
        }
        
    }
    
    var holidayDataOffline: HolidayModelData? {
        get {
            return UserDefaults.standard.retrieve(object: HolidayModelData.self, fromKey: "HolidayModel")
        }
        set {
            
            UserDefaults.standard.save(customObject: newValue, inKey: "HolidayModel")
            
        }
    }
    
    var getOnBoardingData: OnboardingModel? {
        get {
            return UserDefaults.standard.retrieve(object: OnboardingModel.self, fromKey: "OnboardingModel")
        }
        set {
            
            UserDefaults.standard.save(customObject: companyRistriction, inKey: "OnboardingModel")
            
        }
    }
    
    
    var companyRistriction :CompanyRistrictionData?
    
    func savecompanyRistriction(company:CompanyRistrictionData?){
        companyRistriction = company
        setcompanyStriction(user: companyRistriction ?? nil )
    }
    
    
    func setcompanyStriction(user:CompanyRistrictionData?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.resetStandardUserDefaults()
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "companyStriction")
            
        }
        
    }
    
    var companyRistrictiondata: CompanyRistrictionData? {
        get {
            return UserDefaults.standard.retrieve(object: CompanyRistrictionData.self, fromKey: "companyStriction")
        }
        set {
            
            UserDefaults.standard.save(customObject: companyRistriction, inKey: "companyStriction")
            
        }
    }
    
    
    var providerEmployeeGetByUserid : ProviderUserByIdModelData?
    
    func saveproviderEmployeeGetByUserid(provideremployee:ProviderUserByIdModelData?){
        providerEmployeeGetByUserid = provideremployee
        setproviderEmployeeGetByUserid(user: providerEmployeeGetByUserid!)
    }
    
    
    func setproviderEmployeeGetByUserid(user:ProviderUserByIdModelData?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.resetStandardUserDefaults()
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "providerEmployeeData")
            
        }
        
    }
    
    var providerEmployeedataValueGetByUserid: ProviderUserByIdModelData? {
        get {
            return UserDefaults.standard.retrieve(object: ProviderUserByIdModelData.self, fromKey: "providerEmployeeData")
        }
        set {
            
            UserDefaults.standard.save(customObject: providerEmployeeGetByUserid, inKey: "providerEmployeeData")
            
        }
    }
    
    
    
    var contractorEmployeeGetByUserid : GetContractorEmployeeByUserIDModelData?
    
    func saveContractorEmployeeGetByUserid(contractoremployee:GetContractorEmployeeByUserIDModelData?){
        contractorEmployeeGetByUserid = contractoremployee
        setContractorEmployeeGetByUserid(user: contractorEmployeeGetByUserid!)
    }
    
    
    func setContractorEmployeeGetByUserid(user:GetContractorEmployeeByUserIDModelData?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.resetStandardUserDefaults()
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "contractorEmployeeData")
            
        }
        
    }
    
    var contractorEmployeedataValueGetByUserid: GetContractorEmployeeByUserIDModelData? {
        get {
            return UserDefaults.standard.retrieve(object: GetContractorEmployeeByUserIDModelData.self, fromKey: "contractorEmployeeData")
        }
        set {
            
            UserDefaults.standard.save(customObject: contractorEmployeeGetByUserid, inKey: "contractorEmployeeData")
            
        }
    }
    
    var contractorListDataGetByUserid : GetContractorByUserIdModelData?
    
    func saveContractorListGetByUserid(contractor:GetContractorByUserIdModelData){
        contractorListDataGetByUserid = contractor
        setContractorListvalueGetByUserid(user: contractorListDataGetByUserid!)
    }
    
    
    func setContractorListvalueGetByUserid(user:GetContractorByUserIdModelData) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.resetStandardUserDefaults()
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "contractorData")
            
        }
        
    }
    
    var contractorListdataValueGetByUserid: GetContractorByUserIdModelData? {
        get {
            return UserDefaults.standard.retrieve(object: GetContractorByUserIdModelData.self, fromKey: "contractorData")
        }
        set {
            
            UserDefaults.standard.save(customObject: contractorListDataGetByUserid, inKey: "contractorData")
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    var contractListData = [IncomingContractListModelData]()
    
    func saveContractList(contract:[IncomingContractListModelData]){
        contractListData = contract
        setContractListvalue(user: contractListData)
    }
    
    
    func setContractListvalue(user:[IncomingContractListModelData]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.resetStandardUserDefaults()
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "contractList")
            
        }
        
    }
    
    var contractListdataValue: [IncomingContractListModelData] {
        get {
            return UserDefaults.standard.retrieve(object: [IncomingContractListModelData].self, fromKey: "contractList") ?? []
        }
        set {
            
            UserDefaults.standard.save(customObject: contractListData, inKey: "contractList")
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    var notificationlist = [CreatedNotification]()
    
    func saveNotification(qualification:String, message:String, notificationkind: String, Notificationtime:String, Notificationdate:String, notificationType:String, username:String,createdAt:String,type:String,dateMeeting:String,path:String,driveId:String,file:String,image:String,id:String,notificationId:Int,email:String){
        do {
            
            // retrieving a value for a key
            if let data = UserDefaults.standard.data(forKey: "notification"),
               let myPeopleList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [CreatedNotification] {
                myPeopleList.forEach({print($0.type, $0.username)})  // Joe 10
                notificationlist = myPeopleList
            }
            
            // setting a value for a key
            let newPerson = CreatedNotification(qualification: qualification, message: message, notificationkind: notificationkind, Notificationtime: Notificationtime, Notificationdate: Notificationdate, notificationType: notificationType, username: username, createdAt: createdAt, type: type,dateMeeting:dateMeeting,path:path,driveId:driveId,file:file,image:image,id:id, notificationID: notificationId, email: email)
            
            
            
            
            
            notificationlist.append(newPerson)
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: notificationlist, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedData, forKey: "notification")
            
        } catch {
            print("There is Error:",error)
        }
    }
    
    func getBacNotificationsSaved() -> [CreatedNotification]{
        do {
            if let data = UserDefaults.standard.data(forKey: "notification"),
               let myPeopleList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [CreatedNotification] {
                notificationlist = myPeopleList
                myPeopleList.forEach({print($0.type, $0.username)})  // Joe 10
            }
            
            
        } catch {
            print(error)
        }
        return notificationlist
    }
    
    
    
    
    
    
    
    
    
    
    
    
    var contractData:GetContractByUserModelData?
    
    func saveContract(contract:GetContractByUserModelData?){
        contractData = contract
        setContractvalue(user: contractData)
    }
    
    
    func setContractvalue(user:GetContractByUserModelData?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.resetStandardUserDefaults()
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "UserContractWithCompany")
            
        }
        
    }
    
    var invitationdataOffline: [GetallInvitationModelData]? {
        get {
            return UserDefaults.standard.retrieve(object: [GetallInvitationModelData].self, fromKey: "invitationdataOffline")
        }
        set {
            
            UserDefaults.standard.save(customObject: newValue, inKey: "invitationdataOffline")
            
        }
    }
    
    var eventData: [EventModuleData]? {
        get {
            return UserDefaults.standard.retrieve(object: [EventModuleData].self, fromKey: "EventModuleData")
        }
        set {
            
            UserDefaults.standard.save(customObject: newValue, inKey: "EventModuleData")
            
        }
    }
    var myInvitationData: [EventModuleData]? {
        get {
            return UserDefaults.standard.retrieve(object: [EventModuleData].self, fromKey: "myInvitationData")
        }
        set {
            
            UserDefaults.standard.save(customObject: newValue, inKey: "myInvitationData")
            
        }
    }
    
    //MARK: - Events
    
    var schedualEventData: [EventModuleData]? {
        get {
            return UserDefaults.standard.retrieve(object: [EventModuleData].self, fromKey: "schedualEventData")
        }
        set {
            
            UserDefaults.standard.save(customObject: newValue, inKey: "schedualEventData")
            
        }
    }
    var inValidationEventData: [EventModuleData]? {
        get {
            return UserDefaults.standard.retrieve(object: [EventModuleData].self, fromKey: "inValidationEventData")
        }
        set {
            
            UserDefaults.standard.save(customObject: newValue, inKey: "inValidationEventData")
            
        }
    }
    var recordsEventData: [EventModuleData]? {
        get {
            return UserDefaults.standard.retrieve(object: [EventModuleData].self, fromKey: "recordsEventData")
        }
        set {
            
            UserDefaults.standard.save(customObject: newValue, inKey: "recordsEventData")
            
        }
    }
    
    var currentOrderData: [ProviderModelsData]? {
        get {
            return UserDefaults.standard.retrieve(object: [ProviderModelsData].self, fromKey: "currentOrderData")
        }
        set {
            
            UserDefaults.standard.save(customObject: newValue, inKey: "currentOrderData")
            
        }
    }
    var currentOrderHistoryData: [ProviderModelsData]? {
        get {
            return UserDefaults.standard.retrieve(object: [ProviderModelsData].self, fromKey: "currentOrderHistoryData")
        }
        set {
            
            UserDefaults.standard.save(customObject: newValue, inKey: "currentOrderHistoryData")
            
        }
    }
    var contractListDataVC: [IncomingContractListModelData]? {
        get {
            return UserDefaults.standard.retrieve(object: [IncomingContractListModelData].self, fromKey: "contractListDataVC")
        }
        set {
            
            UserDefaults.standard.save(customObject: newValue, inKey: "contractListDataVC")
            
        }
    }
    
    var contractHistoryDataVC: [IncomingContractListModelData]? {
        get {
            return UserDefaults.standard.retrieve(object: [IncomingContractListModelData].self, fromKey: "contractHistoryDataVC")
        }
        set {
            
            UserDefaults.standard.save(customObject: newValue, inKey: "contractHistoryDataVC")
            
        }
    }
    var employeeeDataVC: [EmployeeUserDetailsData]? {
        get {
            return UserDefaults.standard.retrieve(object: [EmployeeUserDetailsData].self, fromKey: "employeeeDataVC")
        }
        set {
            
            UserDefaults.standard.save(customObject: newValue, inKey: "employeeeDataVC")
            
        }
    }
    var vehicleeDataVC: [VehicalModelData]? {
        get {
            return UserDefaults.standard.retrieve(object: [VehicalModelData].self, fromKey: "vehicleeDataVC")
        }
        set {
            
            UserDefaults.standard.save(customObject: newValue, inKey: "vehicleeDataVC")
            
        }
    }
    
    var eventdata : [EventModuleData]? = nil
    
    var conractWithCompany: GetContractByUserModelData? {
        get {
            return UserDefaults.standard.retrieve(object: GetContractByUserModelData.self, fromKey: "UserContractWithCompany")
        }
        set {
            
            UserDefaults.standard.save(customObject: newValue, inKey: "UserContractWithCompany")
            
        }
    }
    
    var notificationsListOffline: [NotificationModelData]? {
        get {
            return UserDefaults.standard.retrieve(object: [NotificationModelData].self, fromKey: "NotificationsListOffline")
        }
        set {
            
            UserDefaults.standard.save(customObject: newValue, inKey: "NotificationsListOffline")
            
        }
    }
    
    
    
    
    
    var userData:LoginDataModel?
    
    func saveUser(user:LoginDataModel?){
        userData = user
        obj = user
        setvalue(user:user)
    }
    
    
    func setvalue(user:LoginDataModel?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "user")
            defaults.set(encoded, forKey: "login")
        }
        
    }
    
    var obj: LoginDataModel? {
        get {
            return UserDefaults.standard.retrieve(object: LoginDataModel.self, fromKey: "user")
        }
        set {
            
            UserDefaults.standard.save(customObject: userData, inKey: "user")
            
        }
    }
    
    
    
    var userCompanyRestrictionData : userCompanyRestrictionModelData?
    
    func saveUserCompanyRestriction(user:userCompanyRestrictionModelData?){
        userCompanyRestrictionData = user
        setvalueCompanyRestriction(user:user)
    }
    
    
    func setvalueCompanyRestriction(user:userCompanyRestrictionModelData?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "userRestriction")
            
        }
        
    }
    
    var userRestrictionObj: userCompanyRestrictionModelData? {
        get {
            return UserDefaults.standard.retrieve(object: userCompanyRestrictionModelData.self, fromKey: "userRestriction")
        }
        set {
            
            UserDefaults.standard.save(customObject: userCompanyRestrictionData, inKey: "userRestriction")
            
        }
    }
    
    var contractDataV2 : CompanyDataV2?
    
    func savecontractDataV2(user:CompanyDataV2?){
        contractDataV2 = user
        setContractDataV2(user:user)
    }
    
    
    func setContractDataV2(user:CompanyDataV2?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "contractDataV2")
            
        }
        
    }
    
    var ContractDataV2Obj: CompanyDataV2? {
        get {
            return UserDefaults.standard.retrieve(object: CompanyDataV2.self, fromKey: "contractDataV2")
        }
        set {
            
            UserDefaults.standard.save(customObject: userCompanyRestrictionData, inKey: "contractDataV2")
            
        }
    }
    
    
    var userRoleV2 : BaseModelCompanyRoleV2?
    
    func saveRoleDataV2(user:BaseModelCompanyRoleV2?){
        userRoleV2 = user
        setRoleDataV2(user:user)
    }
    
    
    func setRoleDataV2(user:BaseModelCompanyRoleV2?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "userRoleV2")
            
        }
        
    }
    
    var RoleDataV2V2Obj: BaseModelCompanyRoleV2? {
        get {
            return UserDefaults.standard.retrieve(object: BaseModelCompanyRoleV2.self, fromKey: "userRoleV2")
        }
        set {
            
            UserDefaults.standard.save(customObject: userCompanyRestrictionData, inKey: "userRoleV2")
            
        }
    }
    
    
    var existuser:getUserIsExistModelData?
    func saveExistUser(existuser:getUserIsExistModelData) {
        setValueOrExistUser(existuser:existuser)
    }
    
    func setValueOrExistUser(existuser:getUserIsExistModelData){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(existuser) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "checkuserExist")
        }
    }
    
    var checkUserExist: getUserIsExistModelData? {
        get {
            return UserDefaults.standard.retrieve(object: getUserIsExistModelData.self, fromKey: "checkuserExist")
        }
        set {
            
            UserDefaults.standard.save(customObject: existuser, inKey: "checkuserExist")
            
        }
    }
    
    
    // var checkUserExist = UserDefaults.standard.retrieve(object:getUserIsExistModelData.self, fromKey:"checkuserExist")
    
    
    var userRole : UserRole = .employees
    var Loging : LoginModel?
    
    func LoginData(data: LoginModel){
        Loging = data
    }
    
    
    var companyData:CompanyRegisterModel?
    
    func compData(data: CompanyRegisterModel){
        companyData = data
    }
    //     var invitationlist : [InvitationsHistoryModel]?
    //     func invitationlistData(data: [InvitationsHistoryModel]){
    //        invitationlist = data
    //     }
    
    
    var invitationlist = [InvitationsHistoryModel]()
    
    func invitatiosdataSaved(name: String, phone:String, date:String,guestid:String,id:String){
        do {
            
            // retrieving a value for a key
            if let data = UserDefaults.standard.data(forKey: "invitation"),
               let myPeopleList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [InvitationsHistoryModel] {
                myPeopleList.forEach({print($0.name, $0.guestid)})  // Joe 10
                invitationlist = myPeopleList
            }
            
            // setting a value for a key
            let newPerson = InvitationsHistoryModel(name:name, phone:phone, date:date, guestid: guestid, id: id)
            
            invitationlist.append(newPerson)
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: invitationlist, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedData, forKey: "invitation")
        } catch {
            print("There is Error:",error)
        }
    }
    
    func getBackinvitatiosdataSaved() -> [InvitationsHistoryModel]{
        do {
            if let data = UserDefaults.standard.data(forKey: "invitation"),
               let myPeopleList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [InvitationsHistoryModel] {
                invitationlist = myPeopleList
                myPeopleList.forEach({print($0.name, $0.name)})  // Joe 10
            }
            
            
        } catch {
            print(error)
        }
        print(invitationlist)
        return invitationlist
    }
    func removeinvitatiosdataSaved(index:Int) -> [InvitationsHistoryModel] {
        do {
            if let data = UserDefaults.standard.data(forKey: "invitation"),
               var myPeopleList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [InvitationsHistoryModel] {
                myPeopleList.remove(at: index)
                invitationlist = myPeopleList
                myPeopleList.forEach({print($0.name, $0.guestid)})  // Joe 10
                let encodedData = try NSKeyedArchiver.archivedData(withRootObject: invitationlist, requiringSecureCoding: false)
                UserDefaults.standard.set(encodedData, forKey: "invitation")
            }
        } catch {
            print(error)
        }
        return invitationlist
    }
    
    var checkRegisterUser = [checkUserExistModel]()
    func contactListSaved(isregister: Bool, name: String, phoneemail: String, guestid: String,registertype:Int,email:String){
        do {
            // setting a value for a key
            let newPerson = checkUserExistModel(name: name, phone: phoneemail, isregister: isregister, guestid: guestid, registertype: registertype, email:email )
            
            checkRegisterUser.append(newPerson)
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: checkRegisterUser, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedData, forKey: "contactList")
            
        } catch {
            print("There is Error:",error)
        }
    }
    
    
    func getBackcontactListSaved() -> [checkUserExistModel]{
        do {
            
            if let data = UserDefaults.standard.data(forKey: "contactList"),
               let myPeopleList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [checkUserExistModel] {
                
                checkRegisterUser = myPeopleList
                myPeopleList.forEach({print($0.name, $0.name)})  // Joe 10
            }
            
        } catch {
            print(error)
        }
        return checkRegisterUser
    }
    
    
    
    
    var userID: Int? {
        get {
            return UserDefaults.standard.integer(forKey: "userID")
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "userID")
            
        }
    }
    
    var password: String? {
        get {
            return UserDefaults.standard.string(forKey: "password")
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "password")
            
        }
    }
    
    
    var fcmToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "fcmToken")
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "fcmToken")
            
        }
    }
    
    var RoleId: String? {
        get {
            return UserDefaults.standard.string(forKey: "RoleId")
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "RoleId")
            
        }
    }
    var isOnuEvent: Bool? {
        get {
            return UserDefaults.standard.bool(forKey: "isOnuEvent")
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "isOnuEvent")
            
        }
    }
    
    var LoginCode: String? {
        get {
            return UserDefaults.standard.string(forKey: "LoginCode")
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "LoginCode")
            
        }
    }
    
    var vericode: String? {
        get {
            return UserDefaults.standard.string(forKey: "vericode")
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "vericode")
            
        }
    }
    
    var FName: String? {
        get {
            return UserDefaults.standard.string(forKey: "FName")
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "FName")
            
        }
    }
    
    
    var LName: String? {
        get {
            return UserDefaults.standard.string(forKey: "LName")
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "LName")
            
        }
    }
    
    
    
    var Phone: String? {
        get {
            return UserDefaults.standard.string(forKey: "Phone")
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "Phone")
            
        }
    }
    
    var Email: String? {
        get {
            return UserDefaults.standard.string(forKey: "Email")
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "Email")
            
        }
    }
    
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: "token")
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "token")
            
        }
    }
    
    
    var lat: String? {
        get {
            return UserDefaults.standard.string(forKey: "lat")
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "lat")
            
        }
    }
    
    var long: String? {
        get {
            return UserDefaults.standard.string(forKey: "long")
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "long")
            
        }
    }
    
    var isStartShift : Bool? {
        get {
            return UserDefaults.standard.bool(forKey: "isStartShift")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "isStartShift")        }
    }
    
    
    
    var isBiomatric : Bool? {
        get {
            return UserDefaults.standard.bool(forKey: "isBiomatric")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "isBiomatric")        }
    }
    
    var isLiveSession : Bool? {
        get {
            return UserDefaults.standard.bool(forKey: "isLiveSession")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "isLiveSession")        }
    }
    
    
    
    var isBeakStart : Bool? {
        get {
            return UserDefaults.standard.bool(forKey: "isBeakStart")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "isBeakStart")        }
    }
    
    var BreakTime: String? {
        get {
            return UserDefaults.standard.string(forKey: "BreakTime")
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "BreakTime")
            
        }
    }
    /*let id : Int?
     let first_name : String?
     let last_name : String?
     let image : String?
     let phone : String?
     let email : String?
     let is_verified : Bool?
     let is_active : Int?
     let role_id : String?
     let gender : String?
     let date_of_birth : String?
     let verification_code : String*/
    
    
    
    var DOB: String? {
        get {
            return UserDefaults.standard.string(forKey: "DOB")
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "DOB")
            
        }
    }
    
    
    var Gender: String? {
        get {
            return UserDefaults.standard.string(forKey: "Gender")
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "Gender")
            
        }
    }
    
    
    var image: String? {
        get {
            return UserDefaults.standard.string(forKey: "image")
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "image")
            
        }
    }
    
    var  isLogin: String? {
        get{
            return UserDefaults.standard.string(forKey: "isLogin")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isLogin")
        }
    }
    
    var  companyid : String? {
        get{
            return UserDefaults.standard.string(forKey: "companyid")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "companyid")
        }
    }
    
    
    var saveLanguage:String?{
        set{
            UserDefaults.standard.set(newValue , forKey: "saveLanguage")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey:  "saveLanguage")
        }
    }
    
    
    class func showProgress() {
        
        
        KRProgressHUD.show()
    }
    
    class func hideProgress() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            KRProgressHUD.dismiss()
        }
    }
    
}
