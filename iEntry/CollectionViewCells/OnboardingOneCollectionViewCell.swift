//
//  OnboardingOneCollectionViewCell.swift
//  iEntry
//
//  Created by HaiDer's Macbook Pro on 09/11/2022.
//

import UIKit

class OnboardingOneCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var missionTitle: UILabel!
    @IBOutlet weak var visionTitle: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var firstDescription: UILabel!
    @IBOutlet weak var missionLbl: UILabel!
    @IBOutlet weak var visionLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLbl.text = "¡BIENVENIDO A IBL!".localized
        missionTitle.text = "MISIÓN".localized
        visionTitle.text = "VISIÓN".localized
    }
    
    func config() {
        self.firstDescription.text = ShareData.shareInfo.contractData?.company?.introduction
        self.missionLbl.text = ShareData.shareInfo.contractData?.company?.mision
        self.visionLbl.text = ShareData.shareInfo.contractData?.company?.vision
        self.nameLbl.text = "\(ShareData.shareInfo.obj?.name ?? "") \(ShareData.shareInfo.obj?.lastName ?? "") \(ShareData.shareInfo.obj?.secondLastName ?? "")"
    }

}
