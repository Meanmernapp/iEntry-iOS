//
//  NVSideMenuManager.swift
//  HomeMadeSuppliers
//
//  Created by apple on 1/22/20.
//  Copyright © 2020 mytechnology. All rights reserved.
//

import UIKit
import SideMenu

class ZSideMenuManager {
    
    private var isRTL: Bool
    
    init(isRTL: Bool) {
        self.isRTL = isRTL
    }
    

     func openSideMenu(vc: UIViewController) {
        showMenu(vc)
    }
}


 //MARK:-  sidemenu implementation
extension ZSideMenuManager {
    
    private func showMenu(_ viewController: UIViewController)  {
        let s = UIStoryboard(name: "Home", bundle: nil)
        let vc = s.instantiateViewController(withIdentifier: "LeftMenuNavigationVC") as? SideMenuNavigationController
        SideMenuManager.default.leftMenuNavigationController = vc
        updateMenus()
        vc?.leftSide = isRTL == true ? false: true
        viewController.present(vc!, animated: true, completion: nil)
    }
    
    
    private func updateMenus() {
        let settings = makeSettings()
        SideMenuManager.default.leftMenuNavigationController?.settings = settings
        // SideMenuManager.default.rightMenuNavigationController?.settings = settings
    }
    
    
    private func selectedPresentationStyle() -> SideMenuPresentationStyle {
        //        let modes: [SideMenuPresentationStyle] = [.menuSlideIn, .viewSlideOut, .viewSlideOutMenuIn, .menuDissolveIn]
        return  .viewSlideOut //menuSlideIn
    }
    
    private func makeSettings() -> SideMenuSettings {
        let presentationStyle = selectedPresentationStyle()
        presentationStyle.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2479666096)
        // presentationStyle.menuStartAlpha = 0.5
        // presentationStyle.menuStartAlpha = CGFloat(menuAlphaSlider.value)
     
        presentationStyle.onTopShadowRadius = 12
        presentationStyle.onTopShadowOpacity = 1
        presentationStyle.onTopShadowColor = .black
        presentationStyle.onTopShadowOffset = CGSize(width: 4, height: 4)
    
       
       presentationStyle.presentingEndAlpha = 0.2 //CG
        // presentationStyle.presentingScaleFactor = CGFloat(presentingScaleFactorSlider.value)
        
        var settings = SideMenuSettings()
        settings.presentationStyle = presentationStyle
        settings.menuWidth = UIScreen.main.bounds.width - 70
        
//        settings.menuWidth = AppSettings.screenWidth - 0.25
        //   let styles:[UIBlurEffect.Style?] = [nil, .dark, .light, .extraLight]
        // settings.blurEffectStyle = styles[blurSegmentControl.selectedSegmentIndex]
        //  settings.statusBarEndAlpha = blackOutStatusBar.isOn ? 1 : 0
        
        return settings
    }
    
}
