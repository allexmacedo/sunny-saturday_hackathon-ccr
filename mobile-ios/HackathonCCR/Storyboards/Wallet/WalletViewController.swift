//
//  WalletViewController.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureTableView()
    }
    
}

extension WalletViewController {
    
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(nibClass: PointCell.self)
        self.tableView.contentInset = UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0)
    }
}

extension WalletViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        cell = tableView.dequeueReusableCell(withIdentifier: PointCell.identifier, for: indexPath)
        
        if let cardCell = cell as? PointCell {
            
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
        cell.selectionStyle = .none
        
        return cell
    }
}

extension WalletViewController: UITableViewDelegate {
    
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
