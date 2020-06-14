//
//  CommercialFacilityViewController.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import UIKit
import CoreLocation

class CommercialFacilityViewController: UIViewController {
    
    var category: FacilityCategory?
    
    var facilities: [CommercialFacility] = []
    
    var userLocation: CLLocation?
    
    var locationServices: LocationBusinessLogic = LocationServices()
    
    var facilitiesServices: FacilitiesBusinessLogic = FacilitiesServices()

    @IBOutlet weak var tableView: UITableView!
    
    enum Segues: String {
        case facilitiesInformation = "FacilityInformation"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = category?.rawValue
        
        configureTableView()
        
        loadContent()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let facilityViewController = segue.destination as? FacilityViewController,
            let sender = sender as? CommercialFacility {
            facilityViewController.facility = sender
        }
    }
    
    func loadContent() {
        
        guard let category = category else {return}
        
        facilitiesServices.retriveFacilities(ofCategory: category) { (result) in
            switch result {
                case .success(let facilities):
                    self.facilities = facilities
                    self.tableView.reloadData()
                
                case .failure(let error):
                    print("Unsolved error at \(self): \(error)")
            }
        }
        
        locationServices.retriveUserLocation { (result) in
            
            switch result {
                case .success(let location):
                    self.userLocation = location
                    self.tableView.reloadData()
                
                case .failure(let error):
                    print("Unsolved error at \(self): \(error)")
            }
        }
    }
}
