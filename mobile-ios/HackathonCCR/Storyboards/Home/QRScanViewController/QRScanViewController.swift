//
//  QRScanViewController.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import UIKit

class QRScanViewController: UIViewController, QRCodeViewDelegate {
    
    @IBOutlet weak var qrCodeView: QRCodeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        qrCodeView.delegate = self
        qrCodeView.adjustCornerRadius()

        // Do any additional setup after loading the view.
        qrCodeView.configurePreviewSession()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        qrCodeView.startScanning()
    }
    
    func scanningDidFail() {
        
    }
    
    func scanningSucceeded(withCode string: String) {
        self.presentInformativeAlert(title: "QR Code Lido!", withMessage: string)
    }
    
    func scanningDidStop() {
        
    }
    
    @IBAction func handleCancel(_ sender: UIBarButtonItem) {
        qrCodeView.stopScanning()
        self.dismiss(animated: true, completion: nil)
    }
}
