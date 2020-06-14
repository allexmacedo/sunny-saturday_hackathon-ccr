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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FacilityCell.identifier, for: indexPath)
        
        if let facilityCell = cell as? FacilityCell {
            facilityCell.configure(image: UIImage(named: "graal"), title: "Posto Graal", rating: "4/5", distance: "10,0 km")
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
