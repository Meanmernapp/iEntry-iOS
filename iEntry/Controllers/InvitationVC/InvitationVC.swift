//
//  InvitationVC.swift
//  iEntry
//
//  Created by ZAFAR on 23/08/2021.
//

import UIKit
import HMSegmentedControl
class InvitationVC: UIViewController {
    
    //MARK: - here are iboutlet
    
    
    @IBOutlet weak var twoContainer: UIView!
    @IBOutlet weak var inerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var tabsView: UIView!
    @IBOutlet weak var oneContainer: UIView!
    
    //MARK: - Variables
    
    let segmentedControl = HMSegmentedControl(sectionTitles: [
        "MIS INVITACIONES".localized,
        "HISTORIAL".localized,
        
    ])
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 43 })) != nil  {
            
        } else {
            if let index = segmentedControl.sectionTitles?.firstIndex(of: "MIS INVITACIONES".localized) {
                segmentedControl.sectionTitles?.remove(at: index)
            }
            
        }
        if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 44 })) != nil {
            
        } else {
            if let index = segmentedControl.sectionTitles?.firstIndex(of: "HISTORIAL".localized) {
                segmentedControl.sectionTitles?.remove(at: index)
            }
            
        }
        if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 43 })) != nil {
            segmentedControl.selectedSegmentIndex = 0
            twoContainer.alpha = 1
            oneContainer.alpha = 0
            
        } else {
            oneContainer.alpha = 0
        }
        
        if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 44 })) != nil {
            segmentedControl.selectedSegmentIndex = 1
            twoContainer.alpha = 0
            oneContainer.alpha = 1
            
        } else {
            twoContainer.alpha = 0
        }
        
        
        
        self.buttonView.roundViiew()
        self.inerView.roundViiew()
        self.navigationBarHidShow(isTrue: true)
        segmentedControl.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.tabsView.frame.height)
        
        segmentedControl.selectionIndicatorLocation = .bottom
        segmentedControl.selectionIndicatorHeight = 1.5
        segmentedControl.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name:"Montserrat-Bold", size: 13)!,NSAttributedString.Key.foregroundColor: UIColor.black]
        
        segmentedControl.selectionIndicatorColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        self.tabsView.addSubview(segmentedControl)
        
        
        if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 23 })) != nil {
            buttonView.isHidden = false 
        } else {
            buttonView.isHidden = true
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 42 })) != nil {
            buttonView.isHidden = false
        } else {
            buttonView.isHidden = true
        }
        
        
    }
    
    @IBAction func addnumberAction(_ sender: UIButton) {
        if Network.isAvailable  {
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"InvitarVC") as? InvitarVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else {
            AppUtility.showInfoMessage(message: "lb_info_can_not_create_invitation".localized)
        }

        
    }
    
    @IBAction func menuAction(_ sender: UIButton) {
       let manager = ZSideMenuManager(isRTL: false)
                    manager.openSideMenu(vc: self)

    }
    //MARK:- segmeneted funtion to appeare tabs
    @objc func segmentedControlChangedValue(segmentedControl: HMSegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 43 })) != nil {
                segmentedControl.selectedSegmentIndex = 0
                twoContainer.alpha = 1
                oneContainer.alpha = 0
                
            }
        case 1:
            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 44 })) != nil {
                segmentedControl.selectedSegmentIndex = 1
                twoContainer.alpha = 0
                oneContainer.alpha = 1
                
            }
        default:
            break
        
        }
        
        
        
    }
    
    
    @IBAction func Sigmnet(_ sender: UISegmentedControl) {
    }
    
}
