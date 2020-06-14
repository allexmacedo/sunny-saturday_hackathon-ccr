//
//  ImageCell.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    func configure(image: UIImage?, width: CGFloat) {
        self.imageView.image = image
        self.widthConstraint.constant = width
    }
}
