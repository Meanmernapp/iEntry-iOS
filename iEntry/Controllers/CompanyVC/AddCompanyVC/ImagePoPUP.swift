//
//  ImagePoPUP.swift
//  iEntry
//
//  Created by ZAFAR on 17/08/2021.
//

import UIKit
import Photos
class ImagePoPUP: UIViewController{
    //MARK:- here are iboutlet
    @IBOutlet weak var btnaccept: UIButton!
    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var lblselectGallerytitle: UILabel!
    @IBOutlet weak var lblselectCameraTitle: UILabel!
    @IBOutlet weak var lblcamerainformationtitle: UILabel!
    @IBOutlet weak var mainView: UIView!
    //MARK:- call back function
    var callBack : ((_ image:UIImage)-> Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblcamerainformationtitle.text = "C A M B I A R I M A G E".localized
        self.lblselectCameraTitle.text = "TOMAR FOTO".localized
        self.lblselectGallerytitle.text = "SELECCIONAR DE IMAGENES".localized
        self.btncancel.setTitle("CANCELAR".localized, for: .normal)
        self.btnaccept.setTitle("ACEPTAR".localized, for: .normal)
        
        navigationBarHidShow(isTrue: true)
        mainView.roundViewWithCustomRadius(radius: 8)
    }
    

    //MARK:- camera action to appear
    @IBAction func cameraCtion(_ sender: UIButton) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: // The user has previously granted access to the camera.
               
                self.setCamera()
            case .notDetermined: // The user has not yet been asked for camera access.
                AVCaptureDevice.requestAccess(for: .video) { [self] granted in
                    if granted {
                        
                        self.setCamera()
                    }
                }
            
            case .denied: // The user has previously denied access.
                return

            case .restricted: // The user can't grant access due to restrictions.
                return
        @unknown default:
            print("Not Access")
        }
    }
    
    
    
    
    
    //MARK:- gallery action to appear
    
    @IBAction func galleryAction(_ sender: UIButton) {
        
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: // The user has previously granted access to the camera.
               
                self.setGallery()
            case .notDetermined: // The user has not yet been asked for camera access.
                AVCaptureDevice.requestAccess(for: .video) { [self] granted in
                    if granted {
                        
                        self.setGallery()
                    }
                }
            
            case .denied: // The user has previously denied access.
                return

            case .restricted: // The user can't grant access due to restrictions.
                return
        @unknown default:
            print("Not Access")
        }
        
        
      
    }
    
    //MARK:- intializr gallery
    func setGallery() {
        
//        DispatchQueue.global(qos: .background).async {
//            print("Run on background thread")
//
//            DispatchQueue.main.async {
//                print("We finished that.")
//
//            }
//        }
       
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
            DispatchQueue.main.async {
                let vc = UIImagePickerController()
                vc.sourceType = .photoLibrary
                vc.allowsEditing = true
                vc.delegate = self
                //self.dismiss(animated: true, completion: nil)
                self.present(vc, animated: true)
            }
         
         }
    }
     
    //MARK:- intialize camera 
    
    func setCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            DispatchQueue.main.async {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        
        self.present(vc, animated: true)
        }
        }
    }
    
    
    
    
    @IBAction func acceptAction(_ sender: UIButton) {
    }
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func ccrossAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
//MARK:- imagepicker delegate
extension ImagePoPUP : UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let img =  (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
        
         callBack?(img)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
            picker.dismiss(animated: true, completion: nil)
    }
    //mediaPickerDidCancel
    
}
