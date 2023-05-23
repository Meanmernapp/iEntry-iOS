//
//  SendEmailVC.swift
//  iEntry
//
//  Created by ZAFAR on 05/08/2021.
//

import UIKit

class SendEmailVC: UIViewController,UITextFieldDelegate {
    
    //MARK:- are iboutlet
    @IBOutlet weak var btnBottom: UIButton!
    
    @IBOutlet weak var lbldetail: UILabel!
    @IBOutlet weak var lblrecoverpassword: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var oneView: UIView!
    @IBOutlet weak var twoView: UIView!
    @IBOutlet weak var threeView: UIView!
    @IBOutlet weak var fiveView: UIView!
    
    @IBOutlet weak var lblerrormsg: UILabel!
    @IBOutlet weak var sixView: UIView!
    @IBOutlet weak var fourView: UIView!
    
    
    @IBOutlet weak var txtone: UITextField!
    @IBOutlet weak var txttwo: UITextField!
    @IBOutlet weak var txtthree: UITextField!
    
    @IBOutlet weak var txtfour: UITextField!
    
    @IBOutlet weak var txtsix: UITextField!
    @IBOutlet weak var txtfive: UITextField!
    
    var otpTex = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        congFigUI()
    }
    //MARK:- this funtion use to set Ui
    func congFigUI() {
        let yourAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Montserrat-Regular", size: 12)!,
                                                             .foregroundColor:#colorLiteral(red: 0.7175678015, green: 0.7176927924, blue: 0.7175598741, alpha: 1),
                                                             .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        let attributeString = NSMutableAttributedString(
            string: "The message never came, send another message",
            attributes: yourAttributes
        )
        btnBottom.setAttributedTitle(attributeString, for: .normal)
        
        
        self.oneView.VerificationcodeViews()
        self.twoView.VerificationcodeViews()
        self.threeView.VerificationcodeViews()
        self.fourView.VerificationcodeViews()
        self.fiveView.VerificationcodeViews()
        self.sixView.VerificationcodeViews()
        self.mainView.roundViewWithCustomRadius(radius: 10)
        
        
        txtone.delegate = self
        txttwo.delegate = self
        txtthree.delegate = self
        txtfour.delegate = self
        txtfive.delegate = self
        txtsix.delegate = self
        
        
        txtone.textContentType = .oneTimeCode
        txttwo.textContentType = .oneTimeCode
        txtthree.textContentType = .oneTimeCode
        txtfour.textContentType = .oneTimeCode
        txtfive.textContentType = .oneTimeCode
        txtsix.textContentType = .oneTimeCode
        
        txtone.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txttwo.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txtthree.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txtfour.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txtfive.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txtsix.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txtone.becomeFirstResponder()
        
        self.lblrecoverpassword.text = "RECUPERACIÓN DE CONTRASEÑA".localized
        self.lbldetail.text = "RECUPERACIÓN DE CONTRASEÑA verifica en tu correo registrado, debió de haberte llegado un mensaje con un código, por favor introducelo, sino lo encuentras en tu bandeja de entrada verifica en la sección de SPAM".localized
        self.lblerrormsg.text = "Time alive for this message:".localized
        
        self.btnBottom.setTitle("The message never came, send another message".localized, for: .normal)
        
        
    }
    //MARK:- this funtion use to enter otp automaticaly
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        
        if (text?.utf16.count)! >= 1{
            switch textField{
                
            case txtone:
                txttwo.becomeFirstResponder()
            case txttwo:
                txtthree.becomeFirstResponder()
            case txtthree:
                txtfour.becomeFirstResponder()
            case txtfour:
                txtfive.becomeFirstResponder()
            case txtfive:
                txtsix.becomeFirstResponder()
            case txtsix :
                txtsix.resignFirstResponder()
                self.dismissKeyboard()
            default:
                break
            }
        }
        
        
        if  text?.count == 0 {
            switch textField{
            case txtone:
                txtone.becomeFirstResponder()
            case txttwo:
                txtone.becomeFirstResponder()
            case txtthree:
                txttwo.becomeFirstResponder()
            case txtfour:
                txtthree.becomeFirstResponder()
            case txtfive:
                txtfour.becomeFirstResponder()
            case txtsix:
                txtfive.becomeFirstResponder()
            default:
                break
            }
        }
    }
    
    
    
    func dismissKeyboard(){
        
        self.otpTex = "\(self.txtone.text ?? "")\(self.txttwo.text ?? "")\(self.txtthree.text ?? "")\(self.txtfour.text ?? "")\(self.txtfive.text ?? "")\(self.txtsix.text ?? "")"
        
        print(self.otpTex)
        self.view.endEditing(true)
        
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.count == 6 {
            //let f = string[string.index(string.startIndex, offsetBy: 3)]//String.Index.init(utf16Offset: 0, in: string)
            txtone.text = "\(string[string.index(string.startIndex, offsetBy: 0)])"
            txttwo.text = "\(string[string.index(string.startIndex, offsetBy: 1)])"
            txtthree.text = "\(string[string.index(string.startIndex, offsetBy: 2)])"
            txtfour.text = "\(string[string.index(string.startIndex, offsetBy: 3)])"
            txtfive.text = "\(string[string.index(string.startIndex, offsetBy: 4)])"
            txtsix.text = "\(string[string.index(string.startIndex, offsetBy: 5)])"
            
            DispatchQueue.main.async {
                self.dismissKeyboard()
                //self.validCode()
            }
        }
        
        if string.count == 1 {
            if (txtone.text?.count ?? 0) == 1 && txtone.tag == 0{
                if (txttwo.text?.count ?? 0) == 1{
                    if (txtthree.text?.count ?? 0) == 1{
                        if (txtfour.text?.count ?? 0) == 1{
                            if (txtfive.text?.count ?? 0) == 1{
                                txtsix.text = string
                                DispatchQueue.main.async {
                                    self.dismissKeyboard()
                                    //self.validCode()
                                }
                                return false
                            }else{
                                txtfive.text = string
                                return false
                            }
                        }else{
                            txtfour.text = string
                            return false
                        }
                    }else{
                        txtthree.text = string
                        return false
                    }
                }else{
                    txttwo.text = string
                    return false
                }
            }
        }
        
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        
        
        if count == 1{
            if textField.tag == 0{
                DispatchQueue.main.async {
                    self.txttwo.becomeFirstResponder()
                }
                
            }else if textField.tag == 1{
                DispatchQueue.main.async {
                    self.txttwo.becomeFirstResponder()
                }
                
            }else if textField.tag == 2{
                DispatchQueue.main.async {
                    self.txtfour.becomeFirstResponder()
                }
                
            }else if textField.tag == 3{
                DispatchQueue.main.async {
                    self.txtfive.becomeFirstResponder()
                }
                
            }else if textField.tag == 4{
                DispatchQueue.main.async {
                    self.txtsix.becomeFirstResponder()
                }
                
            }else {
                DispatchQueue.main.async {
                    self.dismissKeyboard()
                    //                    self.validCode()
                }
            }
        }
        
        return count <= 1
        
        
    }
    
    @IBAction func enterEmailAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"NewPasswordVC") as? NewPasswordVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
