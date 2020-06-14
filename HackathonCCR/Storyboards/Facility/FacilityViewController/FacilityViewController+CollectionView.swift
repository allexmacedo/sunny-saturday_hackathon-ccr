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
        collectionView.register(nibClass: DetailCell.self)

    }
}

extension FacilityViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell
        
        let width = self.view.frame.width - 2 * 16
        
        switch indexPath.row {
            case 0:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath)
                
                if let imageCell = cell as? ImageCell {
                    imageCell.configure(image: UIImage(named: "graal_bg"), width: width)
            }
            
            case 1:
                
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.identifier, for: indexPath)
            
                if let detailCell = cell as? DetailCell, let facility = facility {
                    
                    let image = UIImage(named: facility.image)
                                        
                    let rating: String? = NumberFormatter.localizedDecimalString(from: facility.rating)
                    
                    let distance = userLocation?.distance(from: facility.coordinate)
                    
                    var distanceLabel: String?
                    
                    if let distance = distance {
                        distanceLabel = LengthFormatter.localizedString(fromMeters: distance)
                    }
                    
                    detailCell.configure(image: image, rating: rating, distance: distanceLabel,
                                         verified: facility.verified, width: width)
            }
            
            default:
                cell = UICollectionViewCell()
        }
        
        return cell
    }
}

extension FacilityViewController: UICollectionViewDelegate {}
