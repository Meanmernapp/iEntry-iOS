//
//  VerificationOptionsVC.swift
//  iEntry
//
//  Created by ZAFAR on 14/09/2021.
//

import UIKit
import HMSegmentedControl
import IQKeyboardManagerSwift
class VerificationOptionsVC: UIViewController {
    //MARK:- here are iboutlet
    @IBOutlet weak var lbloptionsTitle: UILabel!
    @IBOutlet weak var oneContainer: UIView!
    @IBOutlet weak var twoContainer: UIView!
    
    @IBOutlet weak var tabsView: UIView!
//    @IBOutlet weak var sigmentedController: UISegmentedControl!
    let segmentedControl = HMSegmentedControl(sectionTitles: [
        "CÓDIGO QR".localized,
        "TOKEN".localized,
        
    ])
    
    //MARK:- here are tabs intializing
    
    lazy var tokenViewcontroller : CompanyVerificationCodeVC  = {
        let storyboard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        var vc = storyboard.instantiateViewController(withIdentifier:"CompanyVerificationCodeVC") as? CompanyVerificationCodeVC
        //self.addChildViewControllerWithView(vc!)
        //self.addchilfViewController(childvc: vc!)
        return vc!
    }()
    
    lazy var compnyqrcodeVC : QRCodeVC  = {
        let storyboard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        var vc = storyboard.instantiateViewController(withIdentifier:"QRCodeVC") as? QRCodeVC
        //self.addchilfViewController(childvc: vc!)
        //self.addChildViewControllerWithView(vc!)
        return vc!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.keyboardManagerVisible(false)
        self.lbloptionsTitle.text = "O P C I O N E S".localized
        self.navigationBarHidShow(isTrue: true)
        
        if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 3 })) != nil  {
            
        } else {
            if let index = segmentedControl.sectionTitles?.firstIndex(of: "CÓDIGO QR".localized) {
                segmentedControl.sectionTitles?.remove(at: index)
            }
            
        }
        if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 4 })) != nil {
            
        } else {
            if let index = segmentedControl.sectionTitles?.firstIndex(of: "TOKEN".localized) {
                segmentedControl.sectionTitles?.remove(at: index)
            }
            
        }
        segmentedControl.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.tabsView.frame.height)
        
        segmentedControl.selectionIndicatorLocation = .bottom
        segmentedControl.selectionIndicatorHeight = 1.5
        segmentedControl.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name:"Montserrat-Bold", size: 14)!,NSAttributedString.Key.foregroundColor: UIColor.black]
        segmentedControl.selectionIndicatorColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
        
       

        segmentedControl.selectedTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name:"Montserrat-Bold", size: 14)!,NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)]
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        self.tabsView.addSubview(segmentedControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addChildViewControllerWithView(compnyqrcodeVC,toView: oneContainer)
        addChildViewControllerWithView(tokenViewcontroller,toView: twoContainer)
//        if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 4 })) != nil {
//            segmentedControl.selectedSegmentIndex = 1
//            twoContainer.alpha = 0
//            oneContainer.alpha = 1
//
//
//
//        } else {
//            twoContainer.alpha = 0
//        }
//        if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 3 })) != nil {
//            segmentedControl.selectedSegmentIndex = 0
//            twoContainer.alpha = 1
//            oneContainer.alpha = 0
//
//        } else {
//            oneContainer.alpha = 0
//        }
        
        segmentedControl.selectedSegmentIndex = 0
        twoContainer.alpha = 0
        oneContainer.alpha = 1
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.keyboardManagerVisible(false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.keyboardManagerVisible(true)
    }
    
    //MARK:- this funtion use to change the tabs
    @objc func segmentedControlChangedValue(segmentedControl: HMSegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            twoContainer.alpha = 0
            oneContainer.alpha = 1
            segmentedControl.selectedSegmentIndex = 0
            
//            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 3 })) != nil {
//                segmentedControl.selectedSegmentIndex = 0
//                twoContainer.alpha = 1
//                oneContainer.alpha = 0
//
//            }
        case 1:
            twoContainer.alpha = 1
            oneContainer.alpha = 0
            segmentedControl.selectedSegmentIndex = 1
//
//            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 4 })) != nil {
//                segmentedControl.selectedSegmentIndex = 1
//                twoContainer.alpha = 0
//                oneContainer.alpha = 1
//
//            }
            
        default:
            break
        
        }}
    
    func addchilfViewController(childvc:UIViewController){
        addChild(childvc)
        view.addSubview(childvc.view)
        childvc.view.frame = view.bounds
        childvc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childvc.didMove(toParent: self)
        
    }
    func removeController(childVC:UIViewController) {
        
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    

}
extension VerificationOptionsVC {

  private func keyboardManagerVisible(_ state: Bool) {
    IQKeyboardManager.shared.enableAutoToolbar = state
      IQKeyboardManager.shared.enable = state
      IQKeyboardManager.shared.shouldResignOnTouchOutside = true
   
  }
}
