//
//  HomeVC.swift
//  iEntry
//
//  Created by ZAFAR on 10/08/2021.
//

import UIKit
import XLPagerTabStrip
class HomeVC: ButtonBarPagerTabStripViewController {

    
    //MARK:- here are the iboutlet
    @IBOutlet weak var inerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var buttonView: UIView!
    
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
        self.buttonView.roundViiew()
        self.inerView.roundViiew()
        navigationController?.navigationBar.isTranslucent = false
           
           let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "E V E N T O S".localized
           titleLabel.textColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
        titleLabel.font = UIFont(name: "Montserrat-Bold", size: 20)
           navigationItem.titleView = titleLabel
        
        
        let appearance = UINavigationBarAppearance()

        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.white

        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBarHidShow(isTrue: false)
        if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 33 })) != nil {
            buttonView.isHidden = false
        } else {
            buttonView.isHidden = true
        }
        
    }
    
    //MARK:- this funtion of tabbar for XLpager
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        pagerTabStripController.view.backgroundColor = .white
        let child_1 = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SchedualVC") as? SchedualVC
        let child_2 = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "EventInvitationVC") as? EventInvitationVC
        let child_3 = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "RecordVC")  as? RecordVC
       
        
        return [child_1!,child_2!, child_3!]
    }

    //MARK:- this funtion use to appear the menu
    @IBAction func menuAction(_ sender: UIButton) {
       let manager = ZSideMenuManager(isRTL: false)
                    manager.openSideMenu(vc: self)

    }
    @IBAction func addEventAction(_ sender: UIButton) {
        if Network.isAvailable {
            if ShareData.shareInfo.isOnuEvent == true {
                let storyBoard = UIStoryboard.init(name: "ONUEvent", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"CreateONUEventVC") as? CreateONUEventVC
                self.navigationController?.pushViewController(vc!, animated: true)
                
                
            } else {

                    let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier:"CreateEventVC") as? CreateEventVC
                    self.navigationController?.pushViewController(vc!, animated: true)

            }
        }
        else {
            AppUtility.showInfoMessage(message: "lb_info_can_not_create_event".localized)
        }

    }
    
    @IBAction func filteAction(_ sender: UIButton) {
        
            let storyBoard = UIStoryboard.init(name: "Popups", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"FilterVC") as? FilterVC
            self.present(vc!, animated: true, completion: nil)
    }
}

