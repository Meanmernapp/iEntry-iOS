//
//  CheckBoxesTableViewCell.swift
//  iEntry
//
//  Created by HaiDer's Macbook Pro on 09/11/2022.
//

import UIKit

class CheckBoxesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    var callBack: ((_ done: Bool,_ tagNo: Int ) -> (Void))? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func checkButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            callBack?(true,sender.tag)
        }
        else {
            callBack?(false,sender.tag)
        }
        
    }
    func config(index:Int) {
        self.titleLbl.text = ShareData.shareInfo.onBoardingData?.data?.onboardingProcesses?[index].process
    }
    
}
