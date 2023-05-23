//
//  AddProfileDataVC.swift
//  iEntry
//
//  Created by ZAFAR on 16/08/2021.
//

import UIKit
import GoogleMaps
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class AddProfileDataVC: BaseController {
    //MARK:- here are iboutlet
    @IBOutlet weak var lblupdatetitle: UILabel!
    @IBOutlet weak var lblBIOCTitle: UILabel!
    @IBOutlet weak var lbleventtitl: UILabel!
    @IBOutlet weak var lbladditionalinfotitle: UILabel!
    @IBOutlet weak var lblrestrictiontitle: UILabel!
    @IBOutlet weak var lblinformationtitle: UILabel!
    @IBOutlet weak var btnadditionalinfo: UIButton!
    @IBOutlet weak var btnBioCrown: UIButton!
    @IBOutlet weak var txtcompany: MDCOutlinedTextField!
    @IBOutlet weak var btnValidate: UIButton!
    @IBOutlet weak var txtaddress: MDCOutlinedTextField!
    @IBOutlet weak var stripView: UIView!
    
    @IBOutlet weak var txtacronmy: MDCOutlinedTextField!
    @IBOutlet weak var BioCRView: UIView!
    
    @IBOutlet weak var validateView: UIView!
    @IBOutlet weak var additionalView: UIView!
    //@IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var userimg: UIImageView!
    //@IBOutlet weak var btnadd: UIButton!
    var company : Company? = nil
    var companyregisterVM = CompanyregisterModelView()
    var companyData:CompanyRegisterModel?
    var getCompanydata :CompanyRistrictionData? //CompanyRegisterData?
    var isAdditional = true
    var isvalide = true
    var isBioAcronmy = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.lblinformationtitle.text = "I N F O R M A C I Ó N".localized
        self.lblrestrictiontitle.text = "R E S T R I C C I O N E S".localized
        self.lbladditionalinfotitle.text = "Aditional information employee".localized
        self.lbleventtitl.text = "Event Approval".localized
        self.lblBIOCTitle.text = "BIOCR Validation".localized
        self.lblupdatetitle.text = "TO UPDATE".localized
        
        setData()
        getCompanyRistrictionbyID()
        
    }
    
    
    func setData() {
        
        setMDCTxtFieldDesign(txtfiled: txtcompany, Placeholder: "COMPAÑIA".localized, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtaddress, Placeholder: "ADDRESS".localized, imageIcon: UIImage())
        
        setMDCTxtFieldDesign(txtfiled: txtacronmy, Placeholder: "ACRONYM".localized, imageIcon: UIImage())
        userimg.roundViiew()
        
        stripView.roundViiew()
       
        additionalView.shadowAndRoundcorner(cornerRadius: 6, shadowColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), shadowRadius: 3, shadowOpacity: 1)
       navigationBarHidShow(isTrue: true)
        validateView.shadowAndRoundcorner(cornerRadius: 6, shadowColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), shadowRadius: 3, shadowOpacity: 1)
        
        BioCRView.shadowAndRoundcorner(cornerRadius: 6, shadowColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), shadowRadius: 3, shadowOpacity: 1)
    }

    
    @IBAction func additionalInfoAction(_ sender: UIButton) {
        if isAdditional == true {
            btnadditionalinfo.setImage(UIImage(named: "ic-check-2"), for: .normal)
        } else {
            btnadditionalinfo.setImage(UIImage(named: "checkbox-outline"), for: .normal)
        }
        isAdditional = !isAdditional
    }
    
    @IBAction func validationAction(_ sender: UIButton) {
        
        if isvalide == true {
            btnValidate.setImage(UIImage(named: "ic-check-2"), for: .normal)
        } else {
            btnValidate.setImage(UIImage(named: "checkbox-outline"), for: .normal)
        }
        isvalide = !isvalide
    }
    
    @IBAction func bioCrownAction(_ sender: UIButton) {
        if isBioAcronmy == true {
            btnBioCrown.setImage(UIImage(named: "ic-check-2"), for: .normal)
        } else {
            btnBioCrown.setImage(UIImage(named: "checkbox-outline"), for: .normal)
        }
        isBioAcronmy = !isBioAcronmy
    }
    
    
    //MARK:- Get Company By id
    func getCompanyRistrictionbyID(){
            self.showLoader()
        //ShareData.shareInfo.obj?.company?.id ?? ""
        userhandler.getCompanyristrictionByID(id: company?.id ?? "", Success: {response  in
                self.hidLoader()
                if response?.success == true {
                    self.getCompanydata = response?.data
                    
                    self.txtaddress.text = self.getCompanydata?.company?.address
                    self.txtacronmy.text = self.getCompanydata?.company?.acronym
                    self.txtcompany.text = self.getCompanydata?.company?.name
                    
                    if self.getCompanydata?.extraDataEmployee == false {
                        self.isAdditional = false
                        self.additionalInfoAction(UIButton())
                       
                    } else {
                        self.isAdditional = true
                        self.additionalInfoAction(UIButton())
                       
                    }
                    
                    
                    if self.getCompanydata?.eventApproval == false {
                        self.isvalide = false
                        self.validationAction(UIButton())
                        
                    } else {
                        self.isvalide = true
                        self.validationAction(UIButton())
                        
                    }
                    
                    if self.getCompanydata?.biocrValidation == false{
                         self.isBioAcronmy = false
                        self.bioCrownAction(UIButton())
                        
                    } else {
                        self.isBioAcronmy = true
                        self.bioCrownAction(UIButton())
                       
                    }
                    
                    
                } else {
                    AppUtility.showErrorMessage(message: response?.message ?? "")
                }
            }, Failure: {error in
                self.hidLoader()
                AppUtility.showErrorMessage(message: error.message)
            })
        }
    //MARK:- register compnay function
    func registerCompanyApi() {
        self.showLoader()
        
        let dic = ["name":txtcompany.text!,"acronym":txtacronmy.text!,"address":txtaddress.text!,"latitude":31.4545,"longitude":72.556454] as [String : Any]
        companyregisterVM.companyRegisterApiCall(params: dic, Success: {response , trycatch in
            self.hidLoader()
            if response?.success ?? true {
                self.companyData = response
                //ShareData.shareInfo.compData(data: response!)
//                self.navigationController?.popViewController(animated: true)
                //self.updateCompanyristriction()
            } else {
                self.hidLoader()
                AppUtility.showErrorMessage(message: trycatch ?? "Somthing is Wrong")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
//    @IBAction func showHidMapAction(_ sender: UIButton) {
//        self.mapView.isHidden = !self.mapView.isHidden
//    }
    
    
    func updateCompanyristriction() {
        
        let companydic:[String:Any] = ["id":company?.id ?? ""]
        let dic : [String:Any] = ["id":self.getCompanydata?.id ?? "", "company":companydic,"sentEmail":true,"eventApproval":!isvalide,"extraDataEvent":false,"extraDataEmployee":!isAdditional,"biocrValidation":!isBioAcronmy]
        
        userhandler.updateCompanyristrictionByID(param:dic,Success: {responce in
            self.hidLoader()
            if responce?.success == true {
                AppUtility.showSuccessMessage(message: responce?.message ?? "")
                self.navigationController?.popViewController(animated: true)
                
               
            } else {
                
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
        
        
    }
    
    
    func checkData() -> Bool {
        if txtaddress.text == "" {
            AppUtility.showErrorMessage(message: "Please Enter Address")
            return false
        }
        
        if txtcompany.text == "" {
            AppUtility.showErrorMessage(message: "Please Enter Company Name")
            return false
        }
        
        if txtacronmy.text == "" {
            AppUtility.showErrorMessage(message: "Please Enter ACRONMY")
            return false
        }
        return true
    }
    @IBAction func toUpdateACtion(_ sender: UIButton) {
        if checkData() {
            self.updateCompanyristriction()
            //self.registerCompanyApi()
        }
    }
    
//    @IBAction func addAction(_ sender: UIButton) {
//        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier:"ImagePoPUP") as? ImagePoPUP
//        vc?.modalPresentationStyle = .overFullScreen
//        vc?.callBack = { [self] img in
//            self.dismiss(animated: true, completion: nil)
//            userimg.image = img
//        }
//        self.present(vc!, animated: false, completion: nil)
//    }
    
    @IBAction func backAcrtion(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
