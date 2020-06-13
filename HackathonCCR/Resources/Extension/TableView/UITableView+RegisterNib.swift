//
//  UITableView+RegisterNib.swift
//  AppDemias
//
//  Created by Lucas Antevere Santana on 14/05/20.
//  Copyright (c) 2020 Mascarados. All rights reserved.

import UIKit

extension UITableView {
    
    func register(nibClass: Identifiable.Type) {
        
        let nib = UINib(nibName: nibClass.identifier, bundle: .main)
        
        self.register(nib, forCellReuseIdentifier: nibClass.identifier)
        
    }
    
    func configureBackgroundActivityView() {
        
        let style: UIActivityIndicatorView.Style = {
            
            if #available(iOS 13.0, *) {
                return .large
                
            } else {
                return .gray
            }
        }()
        
        let loadingIndicator = UIActivityIndicatorView(style: style)
        
        self.backgroundView = loadingIndicator
        
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: loadingIndicator, attribute: .centerX, relatedBy: .equal,
                               toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: loadingIndicator, attribute: .centerY, relatedBy: .equal,
                               toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: loadingIndicator, attribute: .width, relatedBy: .equal,
                               toItem: self, attribute: .width, multiplier: 0.4, constant: 0.0),
            NSLayoutConstraint(item: loadingIndicator, attribute: .height, relatedBy: .equal,
                               toItem: self, attribute: .height, multiplier: 0.4, constant: 0.0)
        ])
        
        loadingIndicator.startAnimating()
        
        self.backgroundView?.alpha = 1.0
    }
    
    func removeBackgroundView() {
        
        self.backgroundView?.alpha = 0.0
        
        self.backgroundView = nil
    }
}
