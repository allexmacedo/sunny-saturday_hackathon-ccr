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
            return 2
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
                    
                    let title = NSMutableAttributedString(string: "Uau, você já tem ",
                                                          attributes: [NSAttributedString.Key.font: UIFont.AppFonts.appFont(withTextStyle: .body)])
                    let points = NSMutableAttributedString(string: "0 pts",
                                                           attributes: [NSAttributedString.Key.font: UIFont.AppFonts.boldAppFont(withTextStyle: .body)])
                    
                    title.append(points)
                    
                    let content = "Continue avaliando os pontos por  onde você passa, desse " +
                                  "modo você  acumula mais pontos, e pode trocar por serviços e " +
                                  "descontos nas empresas parceiras."
                    
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
