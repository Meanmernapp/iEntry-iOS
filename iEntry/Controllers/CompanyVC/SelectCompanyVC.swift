//
//  SelectCompanyVC.swift
//  iEntry
//
//  Created by ZAFAR on 16/10/2021.
//

import UIKit

class SelectCompanyVC:BaseController {
    
    //MARK:- here are iboutlet
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tblview: UITableView!
    
    var companyregisterVM = CompanyregisterModelView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.roundViewWithCustomRadius(radius: 10)
        self.tblview.register(UINib.init(nibName: "SelectCompanyCell", bundle: nil), forCellReuseIdentifier: "SelectCompanyCell")
        getcompanyApi()
    }
    
    //MARK:- get company list funtion
    func getcompanyApi() {
        self.showLoader()
        companyregisterVM.getCompanyByID(ID: "4", Success: {response in
            self.hidLoader()
            print(response)
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }

}
//MARK:- tableview delegates 
extension SelectCompanyVC:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "SelectCompanyCell") as? SelectCompanyCell
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.moveOnhome()
    }
    func moveOnhome() {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController //HomeVC///EnterEmailVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
