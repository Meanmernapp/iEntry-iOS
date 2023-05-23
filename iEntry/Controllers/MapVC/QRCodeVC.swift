//
//  QRCodeVC.swift
//  iEntry
//
//  Created by ZAFAR on 13/08/2021.
//

import UIKit
import XLPagerTabStrip
import ObjectMapper

class QRCodeVC: BaseController, IndicatorInfoProvider {
    
    @IBOutlet weak var bottomView: UIView!
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "CÓDIGO QR".localized)
    }
    
    @IBOutlet weak var btnscantitle: UIButton!
    var contractdata : GetContractorByUserIdModelData?
    
    @IBOutlet weak var lblprofessional: UILabel!
    var isfromContract = false
    @IBOutlet weak var lblusername: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var qrimg: UIImageView!
    @IBOutlet weak var userimg: UIImageView!
    
    @IBOutlet weak var curvView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUi()
        self.bottomView.isHidden = true
        if ShareData.shareInfo.userRole == .employees {
            if (ShareData.shareInfo.RoleDataV2V2Obj?.data??.first(where: { $0.id == 5 })) != nil {
                self.btnscantitle.isHidden = false
            } else {
                self.btnscantitle.isHidden = true
            }
        }
        
        userimg.roundViiew()
        
        
        navigationBarHidShow(isTrue: true)
        var ID = ShareData.shareInfo.obj?.id ?? ""
        let SECRET = "287e0a036577b497"
        let IV = "0011223344556677"
        let FILLED_CHAR = "\u{0001}"
        let size = 16
        let x = ID.count % size
        let padLength = size - x;
        for _ in 1..<padLength {
            ID.append(contentsOf: FILLED_CHAR)
        }
        
        let encryption = AES(key: SECRET, iv: IV)
        let daaata = encryption?.encrypt(string: ID)
        
        var str = daaata?.base64EncodedString()
        str = str?.replacingOccurrences(of: "+", with: "-")
        str = str?.replacingOccurrences(of: "/", with: "_")
        str = str?.replacingOccurrences(of: "=", with: "")
        if let encryptedID = str {
            let dictionary : [String:Any] = ["createdAt":0,"createdBy":encryptedID,"type":1,"visitor":encryptedID,"v":"2.0","expiredAt":0]
            if let theJSONData = try?  JSONSerialization.data(
                withJSONObject: dictionary,
                options: .prettyPrinted
            ),
               let theJSONText = String(data: theJSONData,
                                        encoding: String.Encoding.ascii) {
                print("JSON string = \n\(theJSONText)")
                qrimg.image = generateQRCode(from: theJSONText )
                
            }
        }
        self.lblusername.text = ShareData.shareInfo.obj?.name
        self.lbltime.text = self.getCurrentTime()
        self.lbldate.text = self.getCurrentDate()
        
        if ShareData.shareInfo.obj?.userType?.name == "EMPLOYEE" {
            if myDefaultLanguage == .en {
                self.lblprofessional.text = "EMPLOYEE"
            } else {
                self.lblprofessional.text = "EMPLEADO"
            }
        } else if ShareData.shareInfo.obj?.userType?.name == "GUEST"  {
            if myDefaultLanguage == .en {
                self.lblprofessional.text = "GUEST"
            } else {
                self.lblprofessional.text = "INVITADO"
            }
        }else if ShareData.shareInfo.obj?.userType?.name == "CONTRACTOR_IN_CHARGE"  {
            if myDefaultLanguage == .en {
                self.lblprofessional.text = "CONTRACTOR IN CHARGE"
            } else {
                self.lblprofessional.text = "CONTRATISTA A CARGO"
            }
        }
        else if ShareData.shareInfo.obj?.userType?.name == "CONTRACTORS_EMPLOYEE"  {
            if myDefaultLanguage == .en {
                self.lblprofessional.text = "CONTRACTORS EMPLOYEE"
            } else {
                self.lblprofessional.text = "EMPLEADO DE CONTRATISTA"
            }
        }
        else if ShareData.shareInfo.obj?.userType?.name == "PROVIDER_IN_CHARGE"  {
            if myDefaultLanguage == .en {
                self.lblprofessional.text = "PROVIDER IN CHARGE"
            } else {
                self.lblprofessional.text = "PROVEEDOR A CARGO"
            }
        }
        else if ShareData.shareInfo.obj?.userType?.name == "PROVIDER_EMPLOYEE"  {
            if myDefaultLanguage == .en {
                self.lblprofessional.text = "PROVIDER EMPLOYEE"
            } else {
                self.lblprofessional.text = "EMPLEADO DE PROVEEDOR"
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let attributed = NSAttributedString(string: "ESCANEAR CÓDIGO QR".localized, attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.thick.rawValue,NSAttributedString.Key.foregroundColor : UIColor(hexString: "909090")])
        self.btnscantitle.setAttributedTitle(attributed, for: .normal)
        DispatchQueue.main.async {
            if let image = Global.shared.selfiImage {
                self.userimg.image = image
            }
            else {
                self.userimg.image = UIImage(named: "user-png")!
            }
            
            
        }
    }
    func configUi() {
        mainView.layer.cornerRadius = 36
        //        curvView.layer.cornerRadius = 36
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        mainView.layer.masksToBounds = true
        
        //        curvView.layer.maskedCorners = [.layerMinXMaxYCorner]
        //        curvView.layer.masksToBounds = true
    }
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    @IBAction func menuAction(_ sender: UIButton) {
        let manager = ZSideMenuManager(isRTL: false)
        manager.openSideMenu(vc: self)
        
    }
    
    @IBAction func scanAction(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QRScanVC") as? QRScanVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func backAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController
        self.navigationController?.setViewControllers([vc!], animated: true)
    }
    
    
}
