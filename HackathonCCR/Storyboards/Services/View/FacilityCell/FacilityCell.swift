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
    
    func configure(image: UIImage?, title: String, rating: String, distance: String) {
        
        self.iconView.image = image
        
        self.titleLabel.text = title
        self.titleLabel.font = UIFont.AppFonts.boldAppFont(withTextStyle: .title2)
        
        self.ratingLabel.text = rating
        self.ratingLabel.font = UIFont.AppFonts.boldAppFont(withTextStyle: .callout)
        
        self.distanceLabel.text = distance
        
    }
    
}
