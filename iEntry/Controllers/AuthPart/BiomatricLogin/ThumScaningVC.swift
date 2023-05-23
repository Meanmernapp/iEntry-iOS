//
//  ThumScaningVC.swift
//  iEntry
//
//  Created by ZAFAR on 07/08/2021.
//

import UIKit
import LocalAuthentication
class ThumScaningVC: UIViewController {
    @IBOutlet weak var btnpasswordapp: UIButton!
    
    @IBOutlet weak var lbldetail: UILabel!
    @IBOutlet weak var lblbiomatrictitle: UILabel!
    @IBOutlet weak var mainBottomView: UIView!
    @IBOutlet weak var imageBtn: UIImageView!
    var callBack : ((_ isOk :Bool) -> Void)? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainBottomView.roundCorners([.topLeft,.topRight], radius: 20)
        lblbiomatrictitle.text = "Biometric credentials".localized
        self.lbldetail.text = "Log in using yout biometric credential".localized
        self.btnpasswordapp.setTitle("Use password App".localized, for: .normal)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageBtn.isUserInteractionEnabled = true
        imageBtn.addGestureRecognizer(tapGestureRecognizer)
        authenticationWithTouchID()
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let _ = tapGestureRecognizer.view as! UIImageView
        authenticationWithTouchID()
    }
    
    
    
    @IBAction func passwordAction(_ sender: Any) {
        self.callBack?(false)
        self.dismiss(animated: true, completion: nil)
    }
    
    func authenticationWithTouchID() {
        DispatchQueue.main.async() {
        
            let localAuthenticationContext = LAContext()
            localAuthenticationContext.localizedFallbackTitle = "Please use your Passcode"

            var authorizationError: NSError?
            let reason = "Authentication required to access the secure data"

            if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authorizationError) {
                
                localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluateError in
                    
                    if success {
                        DispatchQueue.main.async() {
                            self.dismiss(animated: true, completion: nil)
                            self.callBack?(true)
                        }
                        
                    } else {
                        DispatchQueue.main.async() {
                            self.dismiss(animated: true, completion: nil)
                            self.callBack?(false)
                        }
                        guard let error = evaluateError else {
                            return
                        }
                        print(error)
                        
                    }
                }
            } else {
                
                guard let error = authorizationError else {
                    return
                }
                print(error)
            }
        }
        }
    

}
