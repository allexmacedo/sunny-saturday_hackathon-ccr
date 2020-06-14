//
//  Label.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import UIKit

class LabelCell: UICollectionViewCell {
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var label: UILabel!
    
    func configure(headText: String? = nil, text: String, bold: Bool, alignment: NSTextAlignment, width: CGFloat) {
        
        self.widthConstraint.constant = width
        
        self.label.textAlignment = alignment
        
        let textStyle = UIFont.TextStyle.subheadline
        
        let font = bold ? UIFont.AppFonts.boldAppFont(withTextStyle: textStyle) : UIFont.AppFonts.appFont(withTextStyle: textStyle)
        
        self.label.font = font
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineHeightMultiple = 1.32
        paragraphStyle.alignment = alignment
        
        var text = NSMutableAttributedString(string: text,
                                             attributes: [NSAttributedString.Key.kern: -0.41,
                                                          NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        if let headText = headText {
            let newText = NSMutableAttributedString(string: headText + ": ",
                                                    attributes: [NSAttributedString.Key.font: UIFont.AppFonts.boldAppFont(withTextStyle: textStyle),
                                                                 NSAttributedString.Key.kern: -0.41,
                                                                 NSAttributedString.Key.paragraphStyle: paragraphStyle])
            newText.append(text)
            
            text = newText
        }
        
        self.label.attributedText = text
    }
}
