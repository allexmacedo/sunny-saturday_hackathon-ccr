//
//  AppColors.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 12/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import UIKit

extension UIColor {
    
    enum AppColors {
        
        static var green: UIColor {
            return UIColor(named: "Green") ?? .green
        }
        
        static var cardColor: UIColor {
            
            if #available(iOS 13.0, *) {
                return .tertiarySystemFill
                
            } else {
                // Fallback on earlier versions
                return .lightGray
            }
        }
        
        static var label: UIColor {
            if #available(iOS 13.0, *) {
                return .label
            } else {
                // Fallback on earlier versions
                return .darkText
            }
        }
        
        static var secondaryLabel: UIColor {
            if #available(iOS 13.0, *) {
                return .secondaryLabel
            } else {
                // Fallback on earlier versions
                return .darkGray
            }
        }
    }
}
