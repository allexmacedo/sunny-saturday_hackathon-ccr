//
//  CategoriesViewController.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var categories = FacilityCategory.allCases.sorted {$0.rawValue < $1.rawValue}
    
    var numberOfItems: Int {
        return categories.count
    }
    
    enum Segues: String {
        case commercialFacilities = "CommercialFacilities"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let commercialFacilitiesVC = segue.destination as? CommercialFacilityViewController,
           let category = sender as? FacilityCategory {
            commercialFacilitiesVC.category = category
        }
    }
}
