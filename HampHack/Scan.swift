//
//  Scan.swift
//  HampHack
//
//  Created by Tapojit Debnath Tapu on 3/12/17.
//  Copyright © 2017 HampHack_Tapojit. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseDatabase

class Scan: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var topbar: UIView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var ref: FIRDatabaseReference?
    var handler: FIRDatabaseHandle?
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    let ticketsL=["Registration",
                  "Idea Jam (6:45pm)",
                  "Pitch your product idea (7:15pm)",
                  "Virtual Reality Games for beginners (7:15pm)",
                  "Quick and dirty prototype 101 (7:15pm)",
                  "Viacom workshop (7:45pm)",
                  "Design Thinking (7:45pm)",
                  "Introduction to 3D printing (7:45pm)",
                  "Intro to Docker, app making (8:15pm)",
                  "Introduction to 3D Scanning (8:15pm)",
                  "Controlling things using mind waves (8:15pm)"]
    
    let supportedCodeTypes = [AVMetadataObjectTypeUPCECode,
                              AVMetadataObjectTypeCode39Code,
                              AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeCode93Code,
                              AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypeEAN8Code,
                              AVMetadataObjectTypeEAN13Code,
                              AVMetadataObjectTypeAztecCode,
                              AVMetadataObjectTypePDF417Code,
                              AVMetadataObjectTypeQRCode]

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession?.startRunning()
            
            // Move the message label and top bar to the front
            view.bringSubview(toFront: messageLabel)
            view.bringSubview(toFront: topbar)
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            messageLabel.text = "No QR/barcode is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                ref=FIRDatabase.database().reference()
                let val=metadataObj.stringValue
                
                if val==ticketsL[1]
                {
                    messageLabel.text = "Workshop ticket has been verified!"
                }
                else if val==ticketsL[2]
                {
                    messageLabel.text = "Workshop ticket has been verified!"
                }
                else if val==ticketsL[3]
                {
                    messageLabel.text = "Workshop ticket has been verified!"
                }
                else if val==ticketsL[4]
                {
                    messageLabel.text = "Workshop ticket has been verified!"
                }
                else if val==ticketsL[5]
                {
                    messageLabel.text = "Workshop ticket has been verified!"
                }
                else if val==ticketsL[6]
                {
                    messageLabel.text = "Workshop ticket has been verified!"
                }
                
                else if val==ticketsL[7]
                {
                    messageLabel.text = "Workshop ticket has been verified!"
                }
                else if val==ticketsL[8]
                {
                    messageLabel.text = "Workshop ticket has been verified!"
                }
                else if val==ticketsL[9]
                {
                    messageLabel.text = "Workshop ticket has been verified!"
                }
                else if val==ticketsL[10]
                {
                    messageLabel.text = "Workshop ticket has been verified!"
                }
                else
                {
                 ref?.child("HampHack").child("QR").child("Registration").observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.hasChild(val!)
                    {
                        self.messageLabel.text="Registration verified!"
                        self.ref?.child("HampHack").child("QR").child("Registration").child(val!).setValue(true)
                    }
                    else
                    {
                        self.messageLabel.text="Invalid QR code!"
                    }
                 })
                }
            }
        }
    }


}
