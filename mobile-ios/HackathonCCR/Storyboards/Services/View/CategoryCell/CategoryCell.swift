//
//  CategoryCell.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var stackBackground: UIView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mockSeparator: UIView!
    @IBOutlet weak var indicatorIcon: UIImageView!
    
    func configure(image: UIImage?,
                   text: String?,
                   first: Bool,
                   last: Bool,
                   backgroundColor: UIColor) {
        
        if let image = image {
            self.iconView.image = image
            self.iconView.isHidden = false
            
        } else {
            self.iconView.isHidden = true
        }
        
        self.titleLabel.text = text
        
        self.stackBackground.backgroundColor = backgroundColor
        
        if last || first {
            self.stackBackground.layer.cornerRadius = 5
            
        } else {
            self.stackBackground.layer.cornerRadius = 0
        }
        
        self.mockSeparator.isHidden = false
        
        if first && last {
            self.stackBackground.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner,
                                                        .layerMinXMinYCorner, .layerMaxXMinYCorner]
            self.mockSeparator.isHidden = true

        } else if first {
            self.stackBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
        } else if last {
            self.stackBackground.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            
            self.mockSeparator.isHidden = true
        }
        
        if backgroundColor == UIColor.AppColors.green {
            indicatorIcon.tintColor = .white
            titleLabel.textColor = .white

        } else {
            indicatorIcon.tintColor = UIColor.AppColors.secondaryLabel
            titleLabel.textColor = UIColor.AppColors.label
        }
    }
}
