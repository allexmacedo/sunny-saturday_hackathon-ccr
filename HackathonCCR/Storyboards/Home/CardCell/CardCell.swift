//
//  CardCell.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentBackground: GradientView!
    
    func configure(title: NSAttributedString, content: String) {
        
        self.title.attributedText = title
                
        self.contentBackground.backgroundColor = UIColor.AppColors.cardColor
        self.contentBackground.colors = [UIColor.AppColors.lightGreen,
                                         UIColor.AppColors.blue]
        
        self.contentLabel.text = content
        self.contentLabel.font = UIFont.AppFonts.appFont(withTextStyle: .footnote)
    }
}
