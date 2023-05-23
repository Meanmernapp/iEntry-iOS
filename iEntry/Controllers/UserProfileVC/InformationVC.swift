//
//  InformationVC.swift
//  iEntry
//
//  Created by ZAFAR on 08/11/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class InformationVC: BaseController {
    var extraData : ExtraData?
    
    @IBOutlet weak var lblupdattitle: UILabel!
    @IBOutlet weak var lblinfotitle: UILabel!
    //MARK: - here are the iboutlet
    
    
    @IBOutlet weak var btnupdate: UIButton!
    
    //MARK: - HeaderLbl
    
    
    @IBOutlet weak var header1Lbl: MDCOutlinedTextField!
    
    @IBOutlet weak var header2Lbl: MDCOutlinedTextField!
    
    @IBOutlet weak var header3Lbl: MDCOutlinedTextField!
    
    @IBOutlet weak var header4Lbl: MDCOutlinedTextField!
    
    @IBOutlet weak var header5Lbl: MDCOutlinedTextField!
    
    @IBOutlet weak var header6Lbl: MDCOutlinedTextField!
    @IBOutlet weak var header7Lbl: MDCOutlinedTextField!
    
    @IBOutlet weak var header8Lbl: MDCOutlinedTextField!
    
    @IBOutlet weak var header9Lbl: MDCOutlinedTextField!
    
    @IBOutlet weak var header10Lbl: MDCOutlinedTextField!
    
    @IBOutlet weak var header11Lbl: MDCOutlinedTextField!
    
    @IBOutlet weak var header12Lbl: MDCOutlinedTextField!
    
    @IBOutlet weak var header13Lbl: MDCOutlinedTextField!
    @IBOutlet weak var header14Lbl: MDCOutlinedTextField!
    
    @IBOutlet weak var header15Lbl: MDCOutlinedTextField!
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblupdattitle.text = "ACTUALIZAR DATOS".localized
        self.lblinfotitle.font = UIFont(name: "Montserrat-Bold", size: 20)
        self.lblinfotitle.text = "I N F O R M A T I Ó N".localized
        setMDCTxtFieldDesign(txtfiled: header1Lbl, Placeholder: ShareData.shareInfo.headersData!.header1, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: header2Lbl, Placeholder: ShareData.shareInfo.headersData!.header2, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: header3Lbl, Placeholder: ShareData.shareInfo.headersData!.header3, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: header4Lbl, Placeholder: ShareData.shareInfo.headersData!.header4, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: header5Lbl, Placeholder: ShareData.shareInfo.headersData!.header5, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: header6Lbl, Placeholder: ShareData.shareInfo.headersData!.header6, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: header7Lbl, Placeholder: ShareData.shareInfo.headersData!.header7, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: header8Lbl, Placeholder: ShareData.shareInfo.headersData!.header8, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: header9Lbl, Placeholder: ShareData.shareInfo.headersData!.header9, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: header10Lbl, Placeholder: ShareData.shareInfo.headersData!.header10, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: header11Lbl, Placeholder: ShareData.shareInfo.headersData!.header11, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: header12Lbl, Placeholder: ShareData.shareInfo.headersData!.header12, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: header13Lbl, Placeholder: ShareData.shareInfo.headersData!.header13, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: header14Lbl, Placeholder: ShareData.shareInfo.headersData!.header14, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: header15Lbl, Placeholder: ShareData.shareInfo.headersData!.header15, imageIcon: UIImage())
        
        if ShareData.shareInfo.userRole == .contractoremplyee || ShareData.shareInfo.userRole == .provideremployee {
            self.header1Lbl.isUserInteractionEnabled = false
            self.header2Lbl.isUserInteractionEnabled = false
            self.header3Lbl.isUserInteractionEnabled = false
            self.header4Lbl.isUserInteractionEnabled = false
            self.header5Lbl.isUserInteractionEnabled = false
            self.header6Lbl.isUserInteractionEnabled = false
            self.header7Lbl.isUserInteractionEnabled = false
            self.header8Lbl.isUserInteractionEnabled = false
            self.header9Lbl.isUserInteractionEnabled = false
            self.header10Lbl.isUserInteractionEnabled = false
            self.header11Lbl.isUserInteractionEnabled = false
            self.header12Lbl.isUserInteractionEnabled = false
            self.header13Lbl.isUserInteractionEnabled = false
            self.header14Lbl.isUserInteractionEnabled = false
            self.header15Lbl.isUserInteractionEnabled = false
            self.btnupdate.isUserInteractionEnabled = false
        } else {
            self.header1Lbl.isUserInteractionEnabled = true
            self.header2Lbl.isUserInteractionEnabled = true
            self.header3Lbl.isUserInteractionEnabled = true
            self.header4Lbl.isUserInteractionEnabled = true
            self.header5Lbl.isUserInteractionEnabled = true
            self.header6Lbl.isUserInteractionEnabled = true
            self.header7Lbl.isUserInteractionEnabled = true
            self.header8Lbl.isUserInteractionEnabled = true
            self.header9Lbl.isUserInteractionEnabled = true
            self.header10Lbl.isUserInteractionEnabled = true
            self.header11Lbl.isUserInteractionEnabled = true
            self.header12Lbl.isUserInteractionEnabled = true
            self.header13Lbl.isUserInteractionEnabled = true
            self.header14Lbl.isUserInteractionEnabled = true
            self.header15Lbl.isUserInteractionEnabled = true
            self.btnupdate.isUserInteractionEnabled = true
        }
        if Network.isAvailable {
            if ShareData.shareInfo.obj?.extraData == nil {
                getExtraDataApi()
            }
            else {
                self.extraData = ShareData.shareInfo.obj?.extraData
                self.offlineSetup()
            }
        } else {
            AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
        }
    }
    
    func offlineSetup() {
        self.header1Lbl.text = ShareData.shareInfo.obj?.extraData?.field1
        self.header2Lbl.text = ShareData.shareInfo.obj?.extraData?.field2
        self.header3Lbl.text = ShareData.shareInfo.obj?.extraData?.field3
        self.header4Lbl.text = ShareData.shareInfo.obj?.extraData?.field4
        self.header5Lbl.text = ShareData.shareInfo.obj?.extraData?.field5
        self.header6Lbl.text = ShareData.shareInfo.obj?.extraData?.field6
        self.header7Lbl.text = ShareData.shareInfo.obj?.extraData?.field7
        self.header8Lbl.text = ShareData.shareInfo.obj?.extraData?.field8
        self.header9Lbl.text = ShareData.shareInfo.obj?.extraData?.field9
        self.header10Lbl.text = ShareData.shareInfo.obj?.extraData?.field10
        self.header11Lbl.text = ShareData.shareInfo.obj?.extraData?.field11
        self.header12Lbl.text = ShareData.shareInfo.obj?.extraData?.field12
        self.header13Lbl.text = ShareData.shareInfo.obj?.extraData?.field13
        self.header14Lbl.text = ShareData.shareInfo.obj?.extraData?.field14
        self.header15Lbl.text = ShareData.shareInfo.obj?.extraData?.field15
    }
    
    func getExtraDataApi() {
        self.showLoader()
        userhandler.getExtraData(id: ShareData.shareInfo.obj?.id ?? "", Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.extraData =  response?.data
                self.header1Lbl.text = self.extraData?.field1
                self.header2Lbl.text = self.extraData?.field2
                self.header3Lbl.text = self.extraData?.field3
                self.header4Lbl.text = self.extraData?.field4
                self.header5Lbl.text = self.extraData?.field5
                self.header6Lbl.text = self.extraData?.field6
                self.header7Lbl.text = self.extraData?.field7
                self.header8Lbl.text = self.extraData?.field8
                self.header9Lbl.text = self.extraData?.field9
                self.header10Lbl.text = self.extraData?.field10
                self.header11Lbl.text = self.extraData?.field11
                self.header12Lbl.text = self.extraData?.field12
                self.header13Lbl.text = self.extraData?.field13
                self.header14Lbl.text = self.extraData?.field14
                self.header15Lbl.text = self.extraData?.field15
                
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    
    @IBAction func saveDataAction(_ sender: UIButton) {
        if Network.isAvailable {
            let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationDownloadImageAlertVC") as? NotificationDownloadImageAlertVC
            vc?.titlofDialog = "Guardar cambios".localized
            vc?.detailofDialog = "Para aplicar los datos de usuario,confirma la acción en este dialogo.".localized
            vc?.acceptbuttontitle = "ACEPTAR".localized
            vc?.modalPresentationStyle = .overFullScreen
            vc?.callBack = { isok in
                print("Internet connection OK")
                vc?.dismiss(animated: true, completion: nil)
                self.updateExtraDataApi()
            }
            self.present(vc!, animated: false, completion: nil)
        }
        
        else {
            print("Internet connection FAILED")
            AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
            
        }
    }
    
    
    func updateExtraDataApi(){
        showLoader()
        let dic : [String:Any] = ["id":ShareData.shareInfo.obj?.extraData?.id ?? "","field1":header1Lbl.text!,"field2":header2Lbl.text!,"field3":header3Lbl.text!,"field4":header4Lbl.text!,"field5":header5Lbl.text!,"field6":header6Lbl.text!,"field7":header7Lbl.text!,"field8":header8Lbl.text!,"field9":header9Lbl.text!,"field10":header10Lbl.text!,"field11":header11Lbl.text!,"field12":header12Lbl.text!,"field13":header13Lbl.text!,"field14":header14Lbl.text!,"field15":header15Lbl.text!]
        userhandler.updateExtradatauser(params: dic,id:ShareData.shareInfo.obj?.id ?? "", Success: {response in
            self.hidLoader()
            if response?.success == true {
                
                self.navigationController?.popViewController(animated: true)
                AppUtility.showSuccessMessage(message: response?.message ?? "")
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    @IBAction func backAction(_ sender: UIButton) {
        if checkDataChanges() {
            let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationDownloadImageAlertVC") as? NotificationDownloadImageAlertVC
            vc?.titlofDialog = "CAMBIOS EN EL PERFIL".localized
            vc?.detailofDialog = "Si sales sin guardar los cambios, todo lo registrado se perderá y tendrás nuevamente que volver a hacer los cambios. ¿Estás seguro que quieres descartar los cambios?".localized
            vc?.acceptbuttontitle = "ACEPTAR".localized
            vc?.modalPresentationStyle = .overFullScreen
            vc?.callBack = { isok in
                if Network.isAvailable {
                    print("Internet connection OK")
                    self.updateExtraDataApi()
                }
                else {
                    print("Internet connection FAILED")
                    AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
            self.present(vc!, animated: false, completion: nil)
            
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    
    //MARK: - Functions
    
    func checkDataChanges() -> Bool {
        if self.header1Lbl.text == self.extraData?.field1 && self.header2Lbl.text == self.extraData?.field2 && self.header3Lbl.text == self.extraData?.field3 && self.header4Lbl.text == self.extraData?.field4 && self.header5Lbl.text == self.extraData?.field5 && self.header6Lbl.text == self.extraData?.field6 && self.header7Lbl.text == self.extraData?.field7 && self.header8Lbl.text == self.extraData?.field8 && self.header9Lbl.text == self.extraData?.field9 && self.header10Lbl.text == self.extraData?.field10 && self.header11Lbl.text == self.extraData?.field11 && self.header12Lbl.text == self.extraData?.field12 && self.header13Lbl.text == self.extraData?.field13 && self.header14Lbl.text == self.extraData?.field14 && self.header15Lbl.text == self.extraData?.field15 {
            AppUtility.showInfoMessage(message: "lb_message_no_changes".localized)
            return false
        }
        
        else {
            return true
        }
    }
    
    
}
