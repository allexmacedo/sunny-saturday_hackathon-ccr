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
    
    var facilitiesServices: FacilitiesBusinessLogic = FacilitiesServices()
    
    var categories = [FacilityCategory]()
    
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
        
        loadContent()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let commercialFacilitiesVC = segue.destination as? CommercialFacilityViewController,
           let category = sender as? FacilityCategory {
            commercialFacilitiesVC.category = category
        }
    }
    
    func loadContent() {
        facilitiesServices.retriveCategories { (result) in
            
            switch result {
                case .success(let categories):
                    self.categories = categories
                    
                case .failure(let error):
                    print("Unsolved error at \(self): \(error)")
            }
            
            self.tableView.removeBackgroundView()
            self.tableView.reloadData()
        }
    }
}
