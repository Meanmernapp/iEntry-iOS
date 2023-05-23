//
//  QRScanVC.swift
//  iEntry
//
//  Created by ZAFAR on 15/09/2021.
//

import UIKit
import AVFoundation
class QRScanVC:BaseController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var btncross: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    
    var qrCodeFrameView: UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubviewToFront(btncross)
        view.backgroundColor = #colorLiteral(red: 0.6940359473, green: 0.8323343992, blue: 0.8082216382, alpha: 1)
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr,.ean8, .ean13, .pdf417]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
        previewLayer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner]
        previewLayer.borderColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
        previewLayer.borderWidth = 2
        previewLayer.videoGravity = .resizeAspectFill
        mainView.layer.addSublayer(previewLayer)
        mainView.bringSubviewToFront(btncross)
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
        
    }
    
    func failed() {
        AppUtility.showErrorMessage(message: "lb_message_camera_error".localized,showTitle: false)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
                
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            if Network.isAvailable {
                found(code: stringValue)}
        }else {
            AppUtility.showErrorMessage(message: "lb_error_invalid_data_qr_code".localized)
        }
        
        dismiss(animated: true)
    }
    
    func found(code: String) {
        print(code)
        var rawCode = code
        rawCode = rawCode.replacingOccurrences(of: "\\n", with: "")
//        rawCode = rawCode.replacingOccurrences(of: "\\", with: "")
        print(rawCode)
        if rawCode.contains("visitor") {
            if rawCode.contains("createdBy") {
                if rawCode.contains("createdAt") {
                    captureSession.stopRunning()
                    
                    openthedoorAPi(param: ["body":rawCode])
                }
            }
        }
        else {
            AppUtility.showErrorMessage(message: "lb_error_invalid_data_qr_code".localized)
        }
        
    }
    
    
    
    func openthedoorAPi(param:[String:Any]){
        userhandler.openTheEmplyeeDoor(param:param,Success: {response in
            if response?.success == true  {
                AppUtility.showSuccessMessage(message: "lb_message_success_scan_qr_code".localized,showTitle: false)
                self.navigationController?.popViewController(animated: true)
            } else {
                
                self.navigationController?.popViewController(animated: true)
                AppUtility.showErrorMessage(message: "lb_error_invalid_data_qr_code".localized)
            }
        }, Failure: {error in
            
            self.navigationController?.popViewController(animated: true)
            AppUtility.showWarningMessage(message: "lb_info_no_internet_connection".localized)
        })
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

public struct ScreenSize
{
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

