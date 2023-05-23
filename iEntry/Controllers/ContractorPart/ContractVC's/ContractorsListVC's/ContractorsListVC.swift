//
//  ContractorsListVC.swift
//  iEntry
//
//  Created by ZAFAR on 01/09/2021.
//

import UIKit
import XLPagerTabStrip
class ContractorsListVC: UIViewController, IndicatorInfoProvider {
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var txtseacrh: UITextField!
    @IBOutlet weak var btnaddbuttontitle: UIButton!
    //MARK:- tab delegate
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "CONTRATISTA".localized)
    }
    //MARK:- here are the iboutlet
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var innerSearch: UIView!
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.register(UINib.init(nibName: "ContractorsListCell", bundle: nil), forCellReuseIdentifier: "ContractorsListCell")
        searchView.shadowAndRoundcorner(cornerRadius: Float(searchView.layer.frame.height) / 2, shadowColor: #colorLiteral(red: 0.8430451751, green: 0.843190372, blue: 0.843035996, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1)
        innerSearch.roundCorners([.topRight,.bottomRight], radius: 25)
        self.btnaddbuttontitle.setTitle("AGREGAR CONTRATISTA +".localized, for: .normal)
        self.txtseacrh.placeholder = "Escribe no celular / email para invitar".localized
    }
    
    @IBAction func addContractors(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Contract.rawValue, bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"AddContractorVC") as? AddContractorVC
                self.navigationController?.pushViewController(vc!, animated: true)
    }
     
}
//MARK:- tableview delegate 
extension ContractorsListVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContractorsListCell") as? ContractorsListCell
        
        
        cell?.callBack = { Istrue in
            if Istrue {
                let storyBoard = UIStoryboard.init(name: StoryBoards.Contract.rawValue, bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"ContractorDetailVC") as? ContractorDetailVC
            self.navigationController?.pushViewController(vc!, animated: true)
            }

        
        }
        return cell!
    }
    
    
}
