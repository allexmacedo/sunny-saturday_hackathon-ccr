//
//  ButtonCell.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import UIKit

class ButtonCell: UICollectionViewCell {

    @IBOutlet weak var contentBackground: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    func configure(title: String?, width: CGFloat) {
        self.titleLabel.text = title
        self.titleLabel.font = UIFont.AppFonts.boldAppFont(withTextStyle: .body)
        self.contentBackground.adjustCornerRadius()
        self.widthConstraint.constant = width
    }

}
