//
//  PayRollDetailVC.swift
//  iEntry
//
//  Created by ZAFAR on 03/09/2021.
//

import UIKit

class PayRollDetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBarHidShow(isTrue: true)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
   
}
