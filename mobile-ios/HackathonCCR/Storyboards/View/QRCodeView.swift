//
//  QRCodeView.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 13/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import UIKit
import AVFoundation

@objc protocol QRCodeViewDelegate: AnyObject {
    func scanningDidFail()
    func scanningSucceeded(withCode string: String)
    func scanningDidStop()
}

class QRCodeView: UIView {

    @IBOutlet weak var delegate: QRCodeViewDelegate?
    
    fileprivate var captureSession: AVCaptureSession?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInitialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInitialize()
    }
    
    private func commonInitialize() {
        clipsToBounds = true
    }
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
}

extension QRCodeView {
    
    var isRunning: Bool {
        return captureSession?.isRunning ?? false
    }
    
    func startScanning() {
        captureSession?.startRunning()
    }
    
    func stopScanning() {
        captureSession?.stopRunning()
        delegate?.scanningDidStop()
    }
    
    fileprivate func scanningDidFail() {
        delegate?.scanningDidFail()
        captureSession = nil
    }
    
    fileprivate func found(code: String) {
        delegate?.scanningSucceeded(withCode: code)
    }
    
    func configurePreviewSession() {
        
        guard let captureLayer = self.layer as? AVCaptureVideoPreviewLayer else {
            return
        }
        
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            
        } catch {
            print("Unsolved error at \(self): \(error)")
            scanningDidFail()
            return
        }
        
        if let canAddInput = captureSession?.canAddInput, canAddInput(videoInput) {
            captureSession?.addInput(videoInput)
            
        } else {
            scanningDidFail()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if let candAddOutput = captureSession?.canAddOutput, candAddOutput(metadataOutput) {
            captureSession?.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: .main)
            metadataOutput.metadataObjectTypes = [.qr, .ean8, .ean13, .pdf417]
            
        } else {
            scanningDidFail()
            return
        }
        
        captureLayer.session = captureSession
        captureLayer.videoGravity = .resizeAspectFill
    }
}

extension QRCodeView: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else {return}
            guard let stringValue = readableObject.stringValue else {return}
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
    }
}
