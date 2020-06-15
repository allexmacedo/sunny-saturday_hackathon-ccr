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
    
    var facilitiesServices: FacilitiesBusinessLogic = FacilitiesServices()
    
    var annotations: [CommercialFacilityAnnotation] = []

    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        requestAuthorizationForLocation(completion: configureMapView)
        loadContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let navigation = segue.destination as? UINavigationController,
            let facilityViewController = navigation.viewControllers.first as? FacilityViewController,
            let sender = sender as? CommercialFacilityAnnotation {
            facilityViewController.facility = sender.facility
            facilityViewController.userLocation = mapView.userLocation.location
        }
    }
    
    func loadContent() {
        
        facilitiesServices.retriveFacilities(ofCategory: FacilityCategory(id: 1, name: "Alimentação", description: nil)) { (result) in
            switch result {
                
                case .success(let facilities):
                    self.addFacilities(model: facilities)
                
                case .failure(let error):
                    print("Unsolved error at \(self): \(error)")
            }
            
        }
    }
    
    func addFacilities(model: [CommercialFacility]) {
        
        mapView.removeAnnotations(annotations)

        annotations = model.map {CommercialFacilityAnnotation(from: $0)}
        
        mapView.addAnnotations(annotations)
        
        if let firstItem = annotations.first {
            self.centerMapOnCoordinate(location: firstItem.coordinate, coordinateSpan: self.defaultSpan)
        }
    }
}
