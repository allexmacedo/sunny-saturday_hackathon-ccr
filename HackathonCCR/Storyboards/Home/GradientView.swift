//
//  GradientView.swift
//  AppDemias
//
//  Created by Lucas Antevere Santana on 29/05/20.
//  Copyright © 2020 Mascarados. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    var colors: [UIColor] = [] {
        didSet {
            reloadGradient()
        }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        reloadGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        reloadGradient()
    }
    
    public func setGradientColors(initial: UIColor?, final: UIColor?) {
        
        colors.removeAll()
        
        if let initialColor = initial, let finalColor = final {
            
            colors.append(initialColor)
            colors.append(finalColor)
            
        } else {
            colors = []
        }
        
        reloadGradient()
    }
    
    private func reloadGradient() {
        
        guard !colors.isEmpty, let gradientLayer = self.layer as? CAGradientLayer else {return}
                        
        gradientLayer.colors = colors.map {$0.cgColor}
        
        gradientLayer.locations = [0, 1]
                
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    
        self.setNeedsDisplay()
    }
}
