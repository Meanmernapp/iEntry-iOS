//
//  AddEmployeeVC.swift
//  iEntry
//
//  Created by ZAFAR on 17/08/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import DropDown
class AddEmployeeVC: BaseController {
    //MARK:- here are iboutlet
    @IBOutlet weak var lblupdatetitle: UILabel!
    @IBOutlet weak var stripView: UIView!
    @IBOutlet weak var txtstatus: MDCOutlinedTextField!
    @IBOutlet weak var txtgender: MDCOutlinedTextField!
    @IBOutlet weak var txtpassword: MDCOutlinedTextField!
    @IBOutlet weak var txtmobile: MDCOutlinedTextField!
    @IBOutlet weak var txtemail: MDCOutlinedTextField!
    @IBOutlet weak var txtname: MDCOutlinedTextField!
    @IBOutlet weak var btnaddimg: UIButton!
    @IBOutlet weak var emplyeeImg: UIImageView!
    var MainDrowpDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        setMDCTxtFieldDesign(txtfiled: txtname, Placeholder: "NOMBRE".localized, imageIcon:UIImage())
        setMDCTxtFieldDesign(txtfiled: txtemail, Placeholder: "CORREO".localized, imageIcon:UIImage(named: "ic-invitation")!)
        setMDCTxtFieldDesign(txtfiled: txtmobile, Placeholder: "CELULAR".localized, imageIcon:UIImage(named: "ic-arrow-down")!)
        setMDCTxtFieldDesign(txtfiled: txtpassword, Placeholder: "CONTRASEÑA".localized, imageIcon:UIImage(named: "eye-regular")!)
        setMDCTxtFieldDesign(txtfiled: txtgender, Placeholder: "GÉNERO".localized, imageIcon:UIImage())
        setMDCTxtFieldDesign(txtfiled: txtstatus, Placeholder: "STATUS".localized, imageIcon:UIImage(named: "ic-arrow-down")!)
       
        self.lblupdatetitle.text = "ACTUALIZAR".localized
        
        navigationBarHidShow(isTrue: true)
        emplyeeImg.roundViiew()
        stripView.roundViiew()
        btnaddimg.roundButton()
    }
    
    
    func configUiView() {
        
        
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addimageAcgtion(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ImagePoPUP") as? ImagePoPUP
        vc?.modalPresentationStyle = .overFullScreen
        vc?.callBack = { [self] img in
            self.dismiss(animated: true, completion: nil)
            emplyeeImg.image = img
        }
        self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func EditAction(_ sender: UIButton) {
    }
    
    //MARK:- general dropdown funtion to apper dropdown
    func dropDownConfig(txtField : UITextField, data:[String]) {
        MainDrowpDown.anchorView = txtField
        MainDrowpDown.backgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        MainDrowpDown.selectionBackgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        MainDrowpDown.dataSource =  data
        DropDown.appearance().textColor = #colorLiteral(red: 0.5527616143, green: 0.5568413734, blue: 0.5609211326, alpha: 1)
        DropDown.appearance().selectedTextColor = UIColor.red
        //DropDown.appearance().textFont = UIFont(name: "JosefinSans-Regular", size: 18)!
        self.MainDrowpDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            
            cell.optionLabel.textAlignment = .left
            
        }
        
        MainDrowpDown.bottomOffset = CGPoint(x: 0, y: txtField.bounds.height)
        MainDrowpDown.selectionAction = { [self](index: Int, item: String) in
            print(item)
//            self.txtselcted.text = item
//            self.question?.selectedAns = index
//            self.question?.answerText = item
//            self.delegate?.myclaimdropdown(cell:self, ind: index, Section: self.mysection  )
            
//            if self.txtchoose ==  txtField {
//                txtchoose.text = item
//            } else if txtgraphics == txtField {
//                txtgraphics.text = item
//            } else {
//                txtEnter.text = item
//            }
            
        }
        MainDrowpDown.show()
    }
}
