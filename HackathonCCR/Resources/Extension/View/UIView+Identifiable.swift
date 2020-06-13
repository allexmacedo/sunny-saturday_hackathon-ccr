//
//  UIView+Identifiable.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 30/04/20.
//  Copyright (c) 2020 Mascarados. All rights reserved.

import UIKit

protocol Identifiable {
    static var identifier: String {get}
}

extension Identifiable {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIView: Identifiable {
    
    func pinToSuperview(with insets: UIEdgeInsets = .zero, edges: UIRectEdge = .all) {
        
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if edges.contains(.top) {
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top).isActive = true
        }
        
        if edges.contains(.bottom) {
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom).isActive = true
        }
        
        if edges.contains(.left) {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left).isActive = true
        }
        
        if edges.contains(.right) {
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right).isActive = true
        }
    }
}
