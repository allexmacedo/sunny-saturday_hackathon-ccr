//
//  AppFonts.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/05/20.
//  Copyright © 2020 Mascarados. All rights reserved.
//

import UIKit

extension UIFont {
    
    /// App standard font styles
    enum AppFonts {
        
        static func boldAppFont(withTextStyle textStyle: UIFont.TextStyle, withMaximumSize maximumSize: CGFloat? = nil) -> UIFont {
            
            let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
            
            let font = UIFont.boldSystemFont(ofSize: descriptor.pointSize)
            
            if let maximumSize = maximumSize {
                return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font, maximumPointSize: maximumSize)
            }
            
            return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
        }
        
        static func appFont(withTextStyle textStyle: UIFont.TextStyle, withMaximumSize maximumSize: CGFloat? = nil) -> UIFont {
            
            let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
            
            let font = UIFont.systemFont(ofSize: descriptor.pointSize)
            
            if let maximumSize = maximumSize {
                return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font, maximumPointSize: maximumSize)
            }
            
            return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
        }
    }
}
