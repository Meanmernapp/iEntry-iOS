//
//  AddVehicleVC.swift
//  iEntry
//
//  Created by ZAFAR on 17/08/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class AddVehicleVC: BaseController {
    @IBOutlet weak var lbluptodatetitle: UILabel!
    //MARK:- here are iboutlet
    @IBOutlet weak var stripView: UIView!
    @IBOutlet weak var txtstatus: MDCOutlinedTextField!
    @IBOutlet weak var txtDriver: MDCOutlinedTextField!
    @IBOutlet weak var txtvehicleType: MDCOutlinedTextField!
    @IBOutlet weak var txtplates: MDCOutlinedTextField!
    @IBOutlet weak var txtmodel: MDCOutlinedTextField!
    @IBOutlet weak var txtcolor: MDCOutlinedTextField!
    @IBOutlet weak var btnaddimg: UIButton!
    @IBOutlet weak var vehichleimg: UIImageView!
    
    @IBOutlet weak var txtsubBrand: MDCOutlinedTextField!
    @IBOutlet weak var txtbrand: MDCOutlinedTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setMDCTxtFieldDesign(txtfiled: txtbrand, Placeholder: "BRAND".localized, imageIcon:UIImage())
        setMDCTxtFieldDesign(txtfiled: txtsubBrand, Placeholder: "SUB-BRAND".localized, imageIcon:UIImage())
        setMDCTxtFieldDesign(txtfiled: txtcolor, Placeholder: "COLOR".localized, imageIcon:UIImage())
        setMDCTxtFieldDesign(txtfiled: txtmodel, Placeholder: "MODEL".localized, imageIcon:UIImage())
        setMDCTxtFieldDesign(txtfiled: txtplates, Placeholder: "PLATES".localized, imageIcon:UIImage())
        setMDCTxtFieldDesign(txtfiled: txtvehicleType, Placeholder: "VEHICLE TYPE".localized, imageIcon:UIImage(named: "ic-arrow-down")!)
        setMDCTxtFieldDesign(txtfiled: txtDriver, Placeholder: "DRIVER".localized, imageIcon:UIImage(named: "ic-arrow-down")!)
        setMDCTxtFieldDesign(txtfiled: txtstatus, Placeholder: "STATUS".localized, imageIcon:UIImage(named: "ic-arrow-down")!)
       
        self.lbluptodatetitle.text = "ACTUALIZAR".localized
        
        navigationBarHidShow(isTrue: true)
        vehichleimg.roundViiew()
        stripView.roundViiew()
        btnaddimg.roundButton()
        
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        vehichleimg.roundViiew()
    }
    //MARK:- this actin will appear impage picker 
    @IBAction func addimageAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ImagePoPUP") as? ImagePoPUP
        vc?.modalPresentationStyle = .overFullScreen
        vc?.callBack = { [self] img in
            self.dismiss(animated: true, completion: nil)
            vehichleimg.image = img
        }
        self.present(vc!, animated: false, completion: nil)
    }
    

}
