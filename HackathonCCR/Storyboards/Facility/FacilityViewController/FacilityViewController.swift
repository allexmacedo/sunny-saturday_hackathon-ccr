//
//  FacilityViewController.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import UIKit
import CoreLocation

class FacilityViewController: UIViewController {
    
    var facility: CommercialFacility?
    
    var userLocation: CLLocation?

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = facility?.name
        
        configureCollectionView()
    }
    
}
