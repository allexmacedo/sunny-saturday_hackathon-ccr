//
//  UIViewController+presentAlert.swift
//  AppDemias
//
//  Created by Lucas Antevere Santana on 29/04/20.
//  Copyright (c) 2020 Mascarados. All rights reserved.

import UIKit

extension UIViewController {
    
    func presentInformativeAlert(title: String?, withMessage message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
}
