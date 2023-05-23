//
//  TransportRequiredVC.swift
//  iEntry
//
//  Created by ZAFAR on 30/04/2022.
//

import UIKit

class TransportRequiredVC: BaseController,UITextViewDelegate {
    var param = eventDic()
    @IBOutlet weak var lblnotitle: UILabel!
    @IBOutlet weak var btncanceltitle: UIButton!
    var selectVehicle = [SelectedVehicleListData]()
    @IBOutlet weak var btncreatetitle: UIButton!
    @IBOutlet weak var lblvalidatecommentstitle: UILabel!
    @IBOutlet weak var lblyestitle: UILabel!
    @IBOutlet weak var btnswitch: UISwitch!
    @IBOutlet weak var txtvalidationmsg: UITextView!
    var istraficRequired = false
    var eventid = ""
    var startDate = 0
    @IBOutlet weak var lbltransportrequiredtitle: UILabel!
    var endDate = 0
    @IBOutlet weak var lblcreatetitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btncanceltitle.setTitle("ANTERIOR".localized, for: .normal)
        self.btncreatetitle.setTitle("CREAR".localized, for: .normal)
        self.lblcreatetitle.text = "CREAR EVENTO".localized
        startDate = param.dic["startDate"]  as? Int ?? 0
        endDate = param.dic["endDate"] as? Int ?? 0
        
        txtvalidationmsg.delegate = self
        txtvalidationmsg.text = "COMENTARIOS PARA VALIDATION.".localized
        txtvalidationmsg.textColor = .gray
        self.lblvalidatecommentstitle.text = "OPCIONES DE VALIDACIÓN".localized
        self.lbltransportrequiredtitle.text = "TRANSPORTE REQUERIDO".localized
        self.lblnotitle.text = "NO".localized
        self.lblyestitle.text = "SÍ".localized
    }
    

    func textViewDidBeginEditing(_ textView: UITextView) {

        if textView.text == "COMENTARIOS PARA VALIDATION.".localized {
            textView.text = nil
        }
        else {
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text.isEmpty {
            DispatchQueue.main.async {
                textView.text = "COMENTARIOS PARA VALIDATION.".localized
                textView.textColor = .gray
            }
        }
        else {
            textView.textColor = .black
            
        }
    }

    @IBAction func switchAction(_ sender: UISwitch) {
        if sender.isOn == true {
            self.istraficRequired = true
        } else {
            self.istraficRequired = false
        }
    
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func checkData() -> Bool {
        if txtvalidationmsg.text == "" {
            AppUtility.showErrorMessage(message: "Please Enter Validation Comment")
            return false
        }
        return true
    }
    
    
    @IBAction func CeateAction(_ sender: UIButton) {
        
        if checkData() {
            
            
            
            
            let storyBoard = UIStoryboard.init(name: "ONUEvent", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"ONUConfirmEventVC") as? ONUConfirmEventVC
            vc?.name = param.dic["name"] as? String ?? ""
            vc?.secondName = param.dic["secondName"] as? String ?? ""
            vc?.secondLasTName = param.dic["secondLastName"] as? String ?? ""
            vc?.startDate = startDate//param.dic["startDate"]  as? String ?? ""
            vc?.endDate = endDate//param.dic["endDate"] as? String ?? ""
            vc?.reservationName = param.dic["zonid"] as? String ?? ""
            
            vc?.duration = param.dic["duration"] as? String ?? ""
            
            vc?.visitPurpose = param.dic["visitPurpose"] as? String ?? ""
            vc?.accompanied = param.dic["accompanied"] as? String ?? ""
            vc?.unitSection = param.dic["unitSection"] as? String ?? ""
            vc?.requiredTransportation = istraficRequired
            vc?.validationComment = txtvalidationmsg.text ?? ""
            vc?.reservationName = param.dic["reservationname"] as? String ?? ""
            vc?.usercount = "\(param.checkRegisterUser.count)"
            vc?.vehiclcount = "\(self.selectVehicle.count)"
            vc?.modalPresentationStyle = .overFullScreen
            
            vc?.callBack = {
                vc?.dismiss(animated: true, completion: nil)
                self.createEventApi()
            }
            self.present(vc!, animated: false, completion: nil)
            
            
            
            
        }
        
    }
    
    
    
    func createEventApi(){
        self.showLoader()
        
        let userDic = ["id":ShareData.shareInfo.obj?.id ?? ""]
        let hostDic = ["id":ShareData.shareInfo.obj?.id ?? ""]
        
        
        let reservation = ["zone":["id":param.dic["zonid"] as? String]]
        let dic : [String:Any] = ["name":param.dic["name"] ?? "","lastName":param.dic["secondName"] ?? "","secondLastName":param.dic["secondLastName"] ?? "" ,"reservation":reservation,"user":userDic,"host":hostDic,"description":"","startDate":param.dic["startDate"] ?? "","endDate":param.dic["endDate"] ?? "","duration":param.dic["duration"] ?? "","visitPurpose":param.dic["visitPurpose"] ?? "","accompanied":param.dic["accompanied"] ?? "","unitSection":param.dic["unitSection"] ?? "","requiredTransportation":istraficRequired,"validationComment":txtvalidationmsg.text ?? ""]
        
        userhandler.createEvent(params: dic, Success: {response in
            self.hidLoader()
            if response?.success == true {
               self.eventid = response?.data?.id ?? ""
                //self.dismiss(animated: true, completion: nil)
               // AppUtility.showErrorMessage(message: response?.message ?? "")
                //self.dismiss(animated: false, completion: {
                 //self.callBack!(true, self.eventid)
                //})
                
                self.InvitationUsers()
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }

    /*{
     "eventId": "9a0de660-2c4b-4c3e-951a-6e16f7fed559",
     "userInvitations":
     [
         {
             "guest": {
                 "id": "f201f8d5-6fd2-4bd6-8f12-ec1571e4531e"
             },
             "guestNumber": 4,
             "sharePdf": true, // Extra data ONU //
             "organization": "IBL/UNITAD", // Extra data ONU //
             "placeToPickUp": "Neer from my house", // Extra data ONU //
             "gzBadge": false // Extra data ONU //
         },
         {
             "guest": {
                 "id": "ad79ab15-dc23-4d1a-8ed6-0cde9c735b17"
             },
             "guestNumber": 1,
             "sharePdf": false, // Extra data ONU //
             "organization": "UNAMI", // Extra data ONU //
             "placeToPickUp": "None.", // Extra data ONU //
             "gzBadge": true // Extra data ONU //
         }
     ]
 }*/
    
    func InvitationUsers() {
        self.showLoader()
        
        //self.usersIDsarr.removeAll()
        var mainArr = [[String:Any]]()
        for item in param.checkRegisterUser {
            if item.isregister == true {
                mainArr.append(["guest":["id":item.guestid],"guestNumber": param.invitationDic["guestNumber"] as? String as Any, "sharePdf": param.invitationDic["sharePdf"] as?String as Any, "organization": param.invitationDic["organization"] as? String as Any, "placeToPickUp":param.invitationDic["placeToPickUp"] as? String as Any, "gzBadge":param.invitationDic["gzBadge"] as? String as Any])
                //usersIDsarr.append("\(item.guestid)")
            }
        }
        
        
        
        let dic : [String:Any] = ["eventId":eventid,"userInvitations":mainArr]
        //
        //usersIds
        userhandler.sendInvitation(params: dic, Success: {response in
            self.hidLoader()
            
            if response?.success == true {
                
                
                if self.selectVehicle.count == 0 {
                    self.dismiss(animated: true, completion: nil)
                    self.navigationController?.popToViewController(ofClass: HomeVC.self)
                    AppUtility.showSuccessMessage(message: response?.message ?? "")
                } else {
                    self.sendVehicleInvitationApi()
                }
//                self.dismiss(animated: true, completion: nil)
//
//                self.dismiss(animated: false, completion: {
//
//                })
                //self.navigationController?.popToViewController(ofClass: HomeVC.self)
                //AppUtility.showErrorMessage(message: response?.message ?? "")
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    
    func sendVehicleInvitationApi(){
        
        var idsArr = [String]()
        
        for item in self.selectVehicle {
            idsArr.append(item.id!)
        }
        
        
        
        let dic:[String:Any] = ["eventId":self.eventid, "vehiclesIds":idsArr]
        
        
        userhandler.sendvehicleInvitation(params: dic, Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popToViewController(ofClass: HomeVC.self)
                AppUtility.showSuccessMessage(message: response?.message ?? "")
            } else {
                
            }
        }, Failure: {error in
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    
    
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
