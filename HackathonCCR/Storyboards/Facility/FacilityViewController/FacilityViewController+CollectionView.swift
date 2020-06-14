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
        collectionView.register(nibClass: LabelCell.self)
        
    }
}

extension FacilityViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell
        
        let width = self.view.frame.width - 2 * 16
        
        if indexPath.section == 0 {
            
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
                
                case 2:
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCell.identifier, for: indexPath)
                    if let labelCell = cell as? LabelCell, let facility = facility {
                        labelCell.configure(text: facility.description, alignment: .center, width: width)
                }
                
                default:
                    cell = UICollectionViewCell()
            }
            
        } else {
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCell.identifier, for: indexPath)
            
            if let labelCell = cell as? LabelCell, let facility = facility {
                
                var headText: String?
                let text: String
                
                if indexPath.row == 0 {
                    
                    headText = "Endereço"
                    text = facility.address
                    
                } else if indexPath.row == 1 {
                    headText = "Horário"
                    text = facility.timeOfWork
                    
                } else {
                    
                    headText = "Telefone"
                    text = facility.phone
                }
                
                labelCell.configure(headText: headText, text: text, alignment: .natural, width: width)
            }
        }
        
        return cell
    }
}
extension FacilityViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard section != 0 else {return .zero}
        
        return 16
    }
    
}
