//
//  TextCell.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
   
    func configure(text: String?) {
        self.label.text = text
        self.label.font = UIFont.AppFonts.boldAppFont(withTextStyle: .title2)
    }
}
