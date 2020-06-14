//
//  CategoriesViewController+tableView.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright (c) 2020 Equipe261. All rights reserved.

import UIKit

extension CategoriesViewController {
    
    func configureTableView() {
        tableView.register(nibClass: CategoryCell.self)
        tableView.register(nibClass: TextCell.self)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension CategoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FacilityCategory.allCases.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: TextCell.identifier, for: indexPath)
            
            if let headerCell = cell as? TextCell {
                headerCell.configure(text: "Categorias")
            }
            
        } else {
            
            cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath)
            
            if let categoryCell = cell as? CategoryCell {
                let text = categories[indexPath.row - 1].rawValue
                
                categoryCell.configure(image: nil, text: text, first: indexPath.row == 1, last: indexPath.row == numberOfItems)
            }
        }
        
        cell.selectionStyle = .none

        return cell
    }
}

extension CategoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath.row > 0 else {return}
    }
}
