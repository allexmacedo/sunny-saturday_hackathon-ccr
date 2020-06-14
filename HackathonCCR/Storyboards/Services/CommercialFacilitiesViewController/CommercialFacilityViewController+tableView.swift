//
//  CommercialFacilityViewController+tableView.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright (c) 2020 Equipe261. All rights reserved.

import UIKit

extension CommercialFacilityViewController {
    
    func configureTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
    
        tableView.register(nibClass: FacilityCell.self)
    }
}

extension CommercialFacilityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facilities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FacilityCell.identifier, for: indexPath)
        
        if let facilityCell = cell as? FacilityCell {
            
            let item = facilities[indexPath.row]
            
            let image = UIImage(named: item.image)
            
            let title = item.name
            
            let rating: String? = NumberFormatter.localizedDecimalString(from: item.rating)
            
            let distance = userLocation?.distance(from: item.coordinate)
            
            var distanceLabel: String?
            
            if let distance = distance {
                distanceLabel = LengthFormatter.localizedString(fromMeters: distance)
            }
            
            facilityCell.configure(image: image, title: title, rating: rating, distance: distanceLabel)
        }
        
        return cell
    }
}

extension CommercialFacilityViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
