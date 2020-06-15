//
//  CategoryCollectionCell.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {

    @IBOutlet weak var contentBackground: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(title: String) {
        contentBackground.adjustCornerRadius()
        self.titleLabel.text = title
        self.titleLabel.font = UIFont.AppFonts.boldAppFont(withTextStyle: .caption2)
    }
}
