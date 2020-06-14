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
    @IBOutlet weak var contentBackground: UIView!
    
    func configure(title: String, content: String) {
        
        self.title.text = title
        self.title.font = UIFont.AppFonts.boldAppFont(withTextStyle: .title2)
        
        self.contentBackground.backgroundColor = UIColor.AppColors.cardColor
        
        self.contentLabel.text = content
    }
}
