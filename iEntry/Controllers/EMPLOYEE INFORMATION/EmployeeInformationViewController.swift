//
//  EmployeeInformationViewController.swift
//  iEntry
//
//  Created by HaiDer's Macbook Pro on 10/11/2022.
//

import UIKit

class EmployeeInformationViewController: BaseController {
    //MARK: - IBOutlet
    
    @IBOutlet weak var buttomBtn: UIButton!
    @IBOutlet weak var segmentBtn: UIButton!
    @IBOutlet weak var onBoardingButton: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var collectionView: SelfSizingCollectionView!
    
    
    //MARK: - Variables
    
    var roleID = String()
    var currectIndex : IndexPath?
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = "ONBOARDING".localized
        onBoardingButton.setTitle("OMITIR ONBOARDING".localized, for: .normal)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.segmentBtn.setImage(UIImage(named: "segment1"), for: .normal)
        self.onBoardingButton.isHidden = true
        self.buttomBtn.isHidden = true
        self.setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.layer.cornerRadius = 36
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        mainView.layer.masksToBounds = true
    }
    
    func setupData() {
        self.collectionView.reloadData()
        self.hidLoader()
        fetchDoneProcessesData()
        fetchData()
    }
    
    @IBAction func segmentBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func onBoardingAction(_ sender: Any) {
        self.showLoader()
        userhandler.hideOnboarding { success in
            self.hidLoader()
            if success?.success ?? true {
                
                AppUtility.showSuccessMessage(message: "lb_success_complete_onboarding".localized)
            }
            else {
                AppUtility.showErrorMessage(message: "lb_error_skipping_onboarding".localized)
            }
        } Failure: { fail in
            self.hidLoader()
        }
        
        let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController //SelectCompanyVC//CompanyVC //HomeVC///EnterEmailVC
        vc?.isFirst = true
        self.navigationController?.setViewControllers([vc!], animated: true)
    }
    
    @IBAction func buttomAction(_ sender: Any) {
        self.showLoader()
        if let idsArray = globalThirdOnboarding?.idsArray {
            userhandler.sendUserProcessess(parms:idsArray) { createdList in
                self.hidLoader()
                AppUtility.showSuccessMessage(message: "lb_success_complete_onboarding" ?? "Onboarding Skiped")
                let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController //SelectCompanyVC//CompanyVC //HomeVC///EnterEmailVC
                vc?.isFirst = true
                self.navigationController?.setViewControllers([vc!], animated: true)
                
                if let message = createdList?.message {
                    AppUtility.showSuccessMessage(message: message)
                }
            } Failure: { error in
                
                self.hidLoader()
            }
        }
        
    }
    
    func fetchData() {
        self.showLoader()
        print(self.roleID)
        
        userhandler.getOnboardingInformation(roleId: roleID) { onBoarding in
            self.hidLoader()
            
            if onBoarding?.data == nil {
                let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController
                vc?.isFirst = true
                //SelectCompanyVC//CompanyVC //HomeVC///EnterEmailVC
                self.navigationController?.setViewControllers([vc!], animated: true)
            }
            else {
                self.hidLoader()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    globalThirdOnboarding?.tableView.reloadData()
                }
                ShareData.shareInfo.saveOnboarding(ONBOARDING: onBoarding)
            }
            
        } Failure: { error in
            let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController //SelectCompanyVC//CompanyVC //HomeVC///EnterEmailVC
            vc?.isFirst = true
            self.navigationController?.setViewControllers([vc!], animated: true)
            self.hidLoader()
        }
        
    }
    func fetchDoneProcessesData() {
        userhandler.getOnboardingDone(userID: ShareData.shareInfo.userData?.id ?? "") { DoneList in
            ShareData.shareInfo.doneProcess = DoneList
            self.collectionView.reloadData()
        } Failure: { error in
            print("Error")
        }
        
    }
}

extension EmployeeInformationViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            
            let cell = collectionView.register(OnboardingOneCollectionViewCell.self, indexPath: indexPath)
            cell.config()
            return cell
        }
        else if indexPath.item == 1 {
            let cell = collectionView.register(OnboardingOnePlusCollectionViewCell.self, indexPath: indexPath)
            cell.config()
            return cell
        }
        else if indexPath.item == 2 {
            let cell = collectionView.register(OnBoardingTwoCollectionViewCell.self, indexPath: indexPath)
            return cell
        }
        else {
            let cell = UICollectionViewCell()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width), height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let indexPath = collectionView.visibleCurrentCellIndexPath {
            if indexPath.item == 0 {
                self.onBoardingButton.isHidden = true
                self.buttomBtn.isHidden = true
                self.segmentBtn.setImage(UIImage(named: "segment1"), for: .normal)
            }
            else if indexPath.item == 1 {
                self.onBoardingButton.isHidden = true
                self.buttomBtn.isHidden = true
                self.segmentBtn.setImage(UIImage(named: "segment2"), for: .normal)
            }
            else {
                self.onBoardingButton.isHidden = false
                self.buttomBtn.isHidden = false
                self.segmentBtn.setImage(UIImage(named: "segment3"), for: .normal)
            }
            self.currectIndex = indexPath
            print(indexPath)
        }
    }
    
}


class SelfSizingCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        isScrollEnabled = true
    }
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
