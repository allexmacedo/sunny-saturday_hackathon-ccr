//
//  UICollectionView+registerNib.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 30/04/20.
//  Copyright (c) 2020 Mascarados. All rights reserved.

import UIKit

extension UICollectionView {
    
    /// Loads an identifiable Xib and register as a Cell on the collection view
    /// - Parameter nibClass: Identifiable Xib
    func register(nibClass: Identifiable.Type) {
        
        let nib = UINib(nibName: nibClass.identifier, bundle: .main)
        
        self.register(nib, forCellWithReuseIdentifier: nibClass.identifier)
        
    }
}
