//
//  GeneralQRCodeVC.swift
//  iEntry
//
//  Created by ZAFAR on 15/09/2021.
//

import UIKit

class GeneralQRCodeVC: BaseController {

    //@IBOutlet weak var btntimercounter: UIButton!
    @IBOutlet weak var lbloptiontitle: UILabel!
    @IBOutlet weak var btnScan: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var qrimg: UIImageView!
    @IBOutlet weak var userimg: UIImageView!
    
    //@IBOutlet weak var btnregenrateQRAction: UIButton!
    var invitationData : EventInvitationsModelsData?
    var name = ""
    var date = ""
    var time = ""
    var eventname = ""
    var eventid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbloptiontitle.text = "O P C I O N E S".localized
        self.btnScan.setTitle("ESCANEAR CÓDIGO QR".localized, for: .normal)
        //self.btntimercounter.setTitle("Valido por los siguientes 30 segundos.".localized, for: .normal)
       // self.btnregenrateQRAction.setTitle("VOLVER A GENERAR".localized, for: .normal)
//        name = invitationData?.guest?.name ?? ""
//        date = getMilisecondstoDate(seconds: "\(invitationData?.startDate ?? 0)", formatter: "")
//        time = getMilisecondstoTime(seconds: "\(invitationData?.startDate ?? 0)", formatter: "")
//        eventid = invitationData?.event?.id ?? ""
//        eventname = invitationData?.event?.name ?? ""
        
        self.lbltime.text = time
        self.lbldate.text =  date
        self.lblname.text =  name
        mainView.shadowAndRoundcorner(cornerRadius: 5, shadowColor: #colorLiteral(red: 0.8626509309, green: 0.8627994061, blue: 0.8626416326, alpha: 1), shadowRadius: 2.0, shadowOpacity: 1)
        
        userimg.roundViiew()
        DispatchQueue.main.async {
            if let image = Global.shared.selfiImage {
                self.userimg.image = image
            }
            else {
                self.userimg.image = UIImage(named: "user-png")!
            }
            
            
        }
        //btnregenrateQRAction.roundButtonWithCustomRadius(radius: 5)
        navigationBarHidShow(isTrue: true)
        qrimg.image = generateQRCode(from: "\(name),\(date),\(eventname),\(eventid)")
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

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func scanAction(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QRScanVC") as? QRScanVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
}
