//
//  MapViewController.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 13/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: Segues
    enum Segues: String {
        case annotationInformations = "FacilityInformation"
    }
    
    // MARK: Services
    var locationServices: LocationBusinessLogic = LocationServices()

    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        requestAuthorizationForLocation(completion: configureMapView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true )
    }
}
