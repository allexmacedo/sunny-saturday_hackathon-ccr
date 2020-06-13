//
//  UITextField+Padding.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 12/06/20.
//  Copyright (c) 2020 Equipe261. All rights reserved.

import UIKit

extension UITextField {
    
    func setPadding(withValue value: CGFloat) {
        
        let paddingSize = CGSize(width: value, height: self.frame.height)
        
        let paddingFrame = CGRect(origin: .zero, size: paddingSize)
        
        leftView = UIView(frame: paddingFrame)
        leftViewMode = .always
    }
}
