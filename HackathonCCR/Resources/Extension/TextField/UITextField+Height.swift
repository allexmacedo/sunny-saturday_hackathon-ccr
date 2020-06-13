//
//  UITextField+FontSize.swift
//  AppDemias
//
//  Created by Lucas Antevere Santana on 14/05/20.
//  Copyright (c) 2020 Mascarados. All rights reserved.

import UIKit

extension UITextField {
    
    func getHeightForFont() -> CGFloat {
        return (self.font?.fontDescriptor.pointSize ?? self.frame.height) + 30
    }
}
