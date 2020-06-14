//
//  RoundedView.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import UIKit

class RoundedView: UIImageView {

    override var bounds: CGRect {
        didSet {
            self.layer.cornerRadius = self.bounds.height/2
        }
    }

}
