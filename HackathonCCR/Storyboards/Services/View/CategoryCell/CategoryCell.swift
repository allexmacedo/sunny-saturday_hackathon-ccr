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
    
    func configure(image: UIImage?, text: String?, first: Bool, last: Bool) {
        
        if let image = image {
            self.iconView.image = image
            self.iconView.isHidden = false
            
        } else {
            self.iconView.isHidden = true
        }
        
        self.titleLabel.text = text
        
        if last || first {
            self.stackBackground.layer.cornerRadius = 16
            
        } else {
            self.stackBackground.layer.cornerRadius = 0
        }
        
        self.mockSeparator.isHidden = false

        if first {
            self.stackBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
        } else if last {
            self.stackBackground.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            
            self.mockSeparator.isHidden = true
        }
        
    }
}
