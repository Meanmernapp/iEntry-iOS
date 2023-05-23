//
//  OrdersVC.swift
//  iEntry
//
//  Created by ZAFAR on 15/11/2021.
//

import UIKit
import XLPagerTabStrip
class OrdersVC: ButtonBarPagerTabStripViewController {
    
    
    //MARK: - here are the iboutlet
    var contractdata : GetContractorByUserIdModelData?
    var providerdata : ProviderUserByIdModelData?
    
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
        self.navigationItem.hidesBackButton = true
        self.view.bringSubviewToFront(bottomView)
        
        //navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "O R D E N E S".localized
        titleLabel.textColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
        titleLabel.font = UIFont(name: "Montserrat-Bold", size: 20)
        navigationItem.titleView = titleLabel
        
        
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.white
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        
        
        
        if ShareData.shareInfo.userRole == .provider {
            getProviderApi()
        } else {
            getProvideremployeeApi()
        }
        
    }
    
    //ContractHistoryVC
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBarHidShow(isTrue: false )
        
    }
    
    //MARK:- tabs funtion to intialize the controller
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child_1 = UIStoryboard(name: StoryBoards.Contract.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CurrentOrderVC") as? CurrentOrderVC
        
        let child_2 = UIStoryboard(name: StoryBoards.Contract.rawValue, bundle: nil).instantiateViewController(withIdentifier: "OrderHistoryVC")  as? OrderHistoryVC
        
//        let child_3 = UIStoryboard(name: StoryBoards.Home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "QRCodeVC")  as? QRCodeVC
//        child_3?.isfromContract = true
//        let child_4 = UIStoryboard(name: StoryBoards.Home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompanyVerificationCodeVC")  as? CompanyVerificationCodeVC
        
        if ShareData.shareInfo.userRole == .provideremployee {
//            return [child_1!, child_2!,child_3!]
            return [child_1!, child_2!]
        } else {
//            return [child_1!, child_2!,child_3!,child_4!]
            return [child_1!, child_2!]
        }
        
    }
    //MARK:- getting here current index of tab
//    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
//        print(toIndex)
//        
//        if toIndex == 0 || toIndex == 1 {
//            bottomView.isHidden = false
//        } else {
//            bottomView.isHidden = true
//        }
//        self.view.layoutIfNeeded()
//
//    }
    @IBAction func menuAction(_ sender: UIButton) {
        let manager = ZSideMenuManager(isRTL: false)
        manager.openSideMenu(vc: self)
        
    }
    
    
    @IBAction func filteAction(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"FilterVC") as? FilterVC
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    func getProviderApi(){
        userhandler.getProviderByUserIDs(userid: ShareData.shareInfo.obj?.id ?? "", Success: { response in
            if response?.success == true {
                self.contractdata = response?.data
                ShareData.shareInfo.saveContractorListGetByUserid(contractor: (response?.data)!)
            } else {
                
            }
        }, Failure: {error in
            
        })
    }
    func getProvideremployeeApi(){
        userhandler.getProviderEmployeeByUserIDs(userid: ShareData.shareInfo.obj?.id ?? "", Success: { response in
            if response?.success == true {
                self.providerdata = response?.data
                ShareData.shareInfo.saveproviderEmployeeGetByUserid(provideremployee: (response?.data)!)
//                print(ShareData.shareInfo.providerEmployeedataValueGetByUserid)
            } else {
                
            }
        }, Failure: {error in
            
        })
    }
}

