//
//  DetailCell.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import UIKit

class DetailCell: UICollectionViewCell {

    @IBOutlet weak var centerImageView: RoundedView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingIcon: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var verifiedFacility: UIView!
    
    @IBOutlet weak var wdithConstraint: NSLayoutConstraint!
    
    func configure(image: UIImage?, rating: String?, distance: String?, verified: Bool, width: CGFloat) {
        
        centerImageView.image = image
        
        ratingLabel.text = rating
        
        if let rating = rating {
            self.ratingLabel.text = rating
            self.ratingLabel.font = UIFont.AppFonts.boldAppFont(withTextStyle: .callout)
            
            self.ratingLabel.isHidden = false
            self.ratingIcon.isHidden = false
        } else {
            
            self.ratingLabel.isHidden = true
            self.ratingIcon.isHidden = true
        }
        
        if let distance = distance {
            self.distanceLabel.text = distance
            
            self.distanceLabel.isHidden = false
            
        } else {
            self.distanceLabel.isHidden = true
        }
        
        verifiedFacility.isHidden = !verified
        
        self.wdithConstraint.constant = width
    }

}
