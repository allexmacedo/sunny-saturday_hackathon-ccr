//
//  FacilityCell.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import UIKit

class FacilityCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var contentBackground: UIView!
    
    @IBOutlet weak var verifiedIcon: UIImageView!
    @IBOutlet weak var ratingsIcon: UIImageView!
    
    func configure(image: UIImage?, title: String, rating: String?, distance: String?) {
        
        self.iconView.image = image
        
        self.titleLabel.text = title
        self.titleLabel.font = UIFont.AppFonts.boldAppFont(withTextStyle: .headline)
        
        if let rating = rating {
            self.ratingLabel.text = rating
            self.ratingLabel.font = UIFont.AppFonts.boldAppFont(withTextStyle: .callout)
            
            self.ratingLabel.isHidden = false
            self.ratingsIcon.isHidden = false
        } else {
            
            self.ratingLabel.isHidden = true
            self.ratingsIcon.isHidden = true
        }
        
        if let distance = distance {
            self.distanceLabel.text = distance
            
            self.distanceLabel.isHidden = false
            
        } else {
            self.distanceLabel.isHidden = true
        }
        
        self.contentBackground.adjustCornerRadius()
        self.contentBackground.backgroundColor = UIColor.AppColors.cardColor
    }
}
