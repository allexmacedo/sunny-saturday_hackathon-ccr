//
//  FacilityViewController+CollectionView.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright (c) 2020 Equipe261. All rights reserved.

import UIKit

extension FacilityViewController {
   
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(nibClass: ImageCell.self)
    }
}

extension FacilityViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath)
        
        if let imageCell = cell as? ImageCell {
            imageCell.configure(image: UIImage(named: "graal_bg"), width: self.view.frame.width - 2 * 16)
        }
        
        return cell
    }
}

extension FacilityViewController: UICollectionViewDelegate {}
