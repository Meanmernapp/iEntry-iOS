//
//  ContarctVC.swift
//  iEntry
//
//  Created by ZAFAR on 01/09/2021.
//

import UIKit
import XLPagerTabStrip
class ContractVC: ButtonBarPagerTabStripViewController {
    
    
    //MARK:- here are the iboutlet
    var contractdata : GetContractorByUserIdModelData?
    var contractoEmplyeeData:GetContractorEmployeeByUserIDModelData?
    @IBOutlet weak var bottomView: UIView!
    
    
    override func viewDidLoad() {
        
        self.navigationController!.navigationBar.isTranslucent = false
        self.settings.style.selectedBarHeight = 2
        self.settings.style.selectedBarBackgroundColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        settings.style.selectedBarVerticalAlignment = .bottom
        settings.style.buttonBarMinimumInteritemSpacing = 0
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray
            oldCell?.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            oldCell?.label.font = UIFont.init(name: "Montserrat-Bold", size: 14)
            newCell?.label.textColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
            newCell?.contentView.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            newCell?.label.font = UIFont.init(name: "Montserrat-Bold", size: 14)
            
        }
        
        
        super.viewDidLoad()
        if ShareData.shareInfo.userRole == .contractor {
            self.getcontractorApi()
        }
        self.navigationItem.hidesBackButton = true
        self.view.bringSubviewToFront(bottomView)
       
        navigationController?.navigationBar.isTranslucent = false
           
           let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
           titleLabel.text = "C O N T R A C T O S"
           titleLabel.textColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
        titleLabel.font = UIFont(name: "Montserrat-Bold", size: 20)
           navigationItem.titleView = titleLabel
        
        
        let appearance = UINavigationBarAppearance()

        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.white

        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        
    }
    
    //ContractHistoryVC
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBarHidShow(isTrue: false)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //MARK:- tab's function to intialize the controller
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child_1 = UIStoryboard(name: StoryBoards.Contract.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ContractsListVC") as? ContractsListVC
        
        let child_2 = UIStoryboard(name: StoryBoards.Contract.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ContractHistoryVC")  as? ContractHistoryVC
        
//        let child_3 = UIStoryboard(name: StoryBoards.Home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "QRCodeVC")  as? QRCodeVC
//            child_3?.isfromContract = true
//
//        let child_4 = UIStoryboard(name: StoryBoards.Home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompanyVerificationCodeVC")  as? CompanyVerificationCodeVC
        
        if ShareData.shareInfo.userRole == .contractoremplyee {
//            return [child_1!, child_2!,child_3!]
            return [child_1!, child_2!]
        } else {
//            return [child_1!, child_2!,child_3!,child_4!]
            return [child_1!, child_2!]
        }
        
        
    }
    
    //MARK: - here getting current index 
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
            print(toIndex)
        
        if toIndex == 0 || toIndex == 1 {
            bottomView.isHidden = false
        } else {
            bottomView.isHidden = true
        }
        
        }
    @IBAction func menuAction(_ sender: UIButton) {
       let manager = ZSideMenuManager(isRTL: false)
                    manager.openSideMenu(vc: self)

    }
    
    
    @IBAction func filteAction(_ sender: UIButton) {
        
            let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"FilterVC") as? FilterVC
            self.present(vc!, animated: true, completion: nil)
    }
    
    func getcontractorApi(){
        userhandler.getContractorByUserIDs(userid: ShareData.shareInfo.obj?.id ?? "", Success: { response in
            if response?.success == true {
                self.contractdata = response?.data
                ShareData.shareInfo.saveContractorListGetByUserid(contractor: (response?.data)!)
            } else {
                
            }
        }, Failure: {error in
            
        })
    }
    
//    func getcontractorEmployeeApi(){
//        userhandler.getContractorEmployeeByUserIDs(userid: ShareData.shareInfo.obj?.id ?? "", Success: { response in
//            if response?.success == true {
//                self.contractoEmplyeeData = response?.data
//                ShareData.shareInfo.saveContractorEmployeeGetByUserid(contractoremployee: (response?.data)!)
//            } else {
//                
//            }
//        }, Failure: {error in
//            
//        })
//    }
    
    
}

