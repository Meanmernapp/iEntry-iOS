//
//  PayRollVC.swift
//  iEntry
//
//  Created by ZAFAR on 03/09/2021.
//

import UIKit

class PayRollVC: UIViewController {
    //MARK:- here are the iboutlet
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBarHidShow(isTrue: true)
        self.tblView.register(UINib.init(nibName: "PayRollCell", bundle: nil), forCellReuseIdentifier: "PayRollCell")
    }
    
    @IBAction func menuAction(_ sender: UIButton) {
        let manager = ZSideMenuManager(isRTL: false)
                     manager.openSideMenu(vc: self)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
//MARK:- tableview delegate 
extension PayRollVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PayRollCell") as? PayRollCell
        cell?.callBack = { isOK in
            let storyBoard = UIStoryboard.init(name: StoryBoards.Contract.rawValue, bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"PayRollDetailVC") as? PayRollDetailVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }
           return cell!
        
    }
    
    
}
