//
//  OnBoardingTwoCollectionViewCell.swift
//  iEntry
//
//  Created by HaiDer's Macbook Pro on 09/11/2022.
//

import UIKit
var globalThirdOnboarding : OnBoardingTwoCollectionViewCell?
class OnBoardingTwoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var hiddenViewTitle: UILabel!
    
    @IBOutlet weak var hiddenViewNewTitle: UILabel!
    var idsArray : [String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        topLbl.text = "Da click en cada paso una vez realizado".localized
        self.hiddenViewNewTitle.text = "!SIN TAREAAS¡".localized
        self.hiddenViewTitle.text = "En estos momentos no cuentas con tareas a segulr".localized
        globalThirdOnboarding = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    func hide() {
        if ShareData.shareInfo.onBoardingData?.data?.onboardingProcesses?.count ?? 0 != 0 {
            self.hiddenView.isHidden = true
            self.topLbl.isHidden = false
            self.tableView.isHidden = false
        }
        else {
            self.topLbl.isHidden = true
            self.tableView.isHidden = true
            self.hiddenView.isHidden = false
        }
    }
}
extension OnBoardingTwoCollectionViewCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.hide()
        return ShareData.shareInfo.onBoardingData?.data?.onboardingProcesses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.register(CheckBoxesTableViewCell.self, indexPath: indexPath)
        cell.selectionStyle = .none
        if let alreadyDone = ShareData.shareInfo.doneProcess?.data {
            if let currentProcess = ShareData.shareInfo.onBoardingData?.data?.onboardingProcesses?[indexPath.row].id {
                if alreadyDone.contains(where: {$0.id == currentProcess}) {

                    cell.mainView.alpha = 0.5
                    cell.checkBtn.isEnabled = false
                }
                else {
                    cell.checkBtn.isEnabled = true
                    cell.mainView.alpha = 1
                    cell.checkBtn.tag = indexPath.row
                    cell.callBack = { checked , tag in
                        if checked {
                            self.idsArray.append(ShareData.shareInfo.onBoardingData?.data?.onboardingProcesses?[tag].id ?? "")
                        }
                        else {
                            self.idsArray.removeAll { $0 == ShareData.shareInfo.onBoardingData?.data?.onboardingProcesses?[tag].id ?? "" }
                        }
                        print(checked,tag , self.idsArray)
                    }
                }
            }
            
        }
        cell.config(index: indexPath.row)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}



