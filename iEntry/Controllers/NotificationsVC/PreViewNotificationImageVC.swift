//
//  PreViewNotificationImageVC.swift
//  iEntry
//
//  Created by ZAFAR on 21/06/2022.
//

import UIKit

class PreViewNotificationImageVC: BaseController {
  var notificationimg = UIImage()
    var notificationid  = ""
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        downloadImageNotificationApi()
    }
    
   
    func downloadImageNotificationApi(){
        userhandler.downloadNotificationimage(notificationid: notificationid, option: "notification_image", Success: {response in
            if response?.success == true  {
                self.img.image =  self.convierteImagen(base64String: response?.data ?? "") ?? UIImage()
                
            } else {
                
            }
        }, Failure: {error in
            print("image download error")
        })
    }
    
    
    
    @IBAction func crossAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
