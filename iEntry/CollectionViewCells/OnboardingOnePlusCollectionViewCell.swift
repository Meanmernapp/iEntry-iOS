//
//  OnboardingOnePlusCollectionViewCell.swift
//  iEntry
//
//  Created by HaiDer's Macbook Pro on 10/11/2022.
//

import UIKit

class OnboardingOnePlusCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bossTitle: UILabel!
    @IBOutlet weak var zoneTitle: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var introDuction: UILabel!
    @IBOutlet weak var zoneLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailTxt: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bossTitle.text = "JEFE INMEDIATO".localized
        zoneTitle.text = "WORK ZONE".localized
    }
    
    func config() {
        self.nameLbl.text = "\(ShareData.shareInfo.onBoardingData?.data?.user?.name ?? "") \(ShareData.shareInfo.onBoardingData?.data?.user?.lastName ?? "") \(ShareData.shareInfo.onBoardingData?.data?.user?.secondLastName ?? "")"
        self.introDuction.text = ShareData.shareInfo.onBoardingData?.data?.introduction
        self.zoneLbl.text = ShareData.shareInfo.onBoardingData?.data?.zone?.name
        self.emailTxt.text =  ShareData.shareInfo.onBoardingData?.data?.user?.email ?? ""
        self.phoneNumberLbl.text =  ShareData.shareInfo.onBoardingData?.data?.user?.phoneNumber ?? ""
    }

}
