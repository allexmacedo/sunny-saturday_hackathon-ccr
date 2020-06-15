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
        
        tableView.configureBackgroundActivityView()
        
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
}

extension CategoriesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        guard section == 0 else {return 1}
        
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath)
        
        if let categoryCell = cell as? CategoryCell {
            
            let text: String
            var image: UIImage?
            let first, last: Bool
            let cardColor: UIColor
            
            first = indexPath.row == 0
            
            if indexPath.section == 0 {
                text = categories[indexPath.row].name ?? ""
                last = indexPath.row == numberOfItems - 1
                cardColor = UIColor.AppColors.cardColor
                
            } else {
                text = "Telefones de emergência"
                image = UIImage(named: "telephone")
                last = true
                cardColor = UIColor.AppColors.green
            }
            
            categoryCell.configure(image: image, text: text, first: first, last: last, backgroundColor: cardColor)
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
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let category = categories[indexPath.row]
        
        self.performSegue(withIdentifier: Segues.commercialFacilities.rawValue, sender: category)
    }
}
