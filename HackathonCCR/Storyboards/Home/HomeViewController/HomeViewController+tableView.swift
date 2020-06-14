//
//  HomeViewController+tableView.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright (c) 2020 Equipe261. All rights reserved.

import UIKit

extension HomeViewController {
    
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(nibClass: TextCell.self)
        self.tableView.register(nibClass: CardCell.self)
        self.tableView.register(nibClass: CategoryCell.self)
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 3
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
                cell = tableView.dequeueReusableCell(withIdentifier: TextCell.identifier, for: indexPath)
                
                if let textCell = cell as? TextCell {
                    textCell.configure(text: "Olá", textStyle: .title1)
                }
                
            } else {
                
                cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath)
                
                if let cardCell = cell as? CardCell {
                    let title: String = indexPath.row == 1 ? "Saldo" : "Pontos"
                    let content: String = indexPath.row == 1 ? (NumberFormatter.localizedCurrencyString(from: 0.0) ?? "R$ 0,00") : "0.0 pts"
                    
                    cardCell.configure(title: title, content: content)
                }
            }
            
        } else {
            cell = UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
                
        if indexPath.section == 0 && indexPath.row == 2 {
            self.tabBarController?.selectedIndex = 3
        }
    }
}
