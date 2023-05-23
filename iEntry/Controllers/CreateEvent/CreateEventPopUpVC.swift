//
//  CreateEventPopUpVC.swift
//  iEntry
//
//  Created by ZAFAR on 18/04/2022.
//

import UIKit

class CreateEventPopUpVC: UIViewController {
    var callBack: ((_ isTrue:Bool) -> Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancellAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createEventAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        callBack?(true)
    }
    
    
    @IBAction func onuEventAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        callBack?(false)
    }
    
    
}
