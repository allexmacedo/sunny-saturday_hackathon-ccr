//
//  CommercialFacility.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 13/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import CoreLocation

struct CommercialFacility: Decodable {
    
    let id: UUID
    
    let name: String
    
    let category: FacilityCategory
    
    let image: String
    
    let rating: Double
    
    let coordinate: CLLocation
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case category
        case image
        case rating
        case latitude
        case longitude
    }
    
    init(id: UUID, name: String, category: FacilityCategory, image: String, rating: Double, coordinate: CLLocation) {
        self.image = image
        self.id = id
        self.name = name
        self.category = category
        self.rating = rating
        self.coordinate = coordinate
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id: UUID = try container.decode(UUID.self, forKey: .id)
        
        let name: String = try container.decode(String.self, forKey: .id)
        
        let image: String = try container.decode(String.self, forKey: .id)
        
        let category: FacilityCategory = try container.decode(FacilityCategory.self, forKey: .category)
        
        let rating: Double = try container.decode(Double.self, forKey: .id)
        
        let latitude: Double = try container.decode(Double.self, forKey: .id)
        let longitude: Double = try container.decode(Double.self, forKey: .id)
        
        self.init(id: id, name: name, category: category, image: image,
                  rating: rating, coordinate: CLLocation(latitude: latitude, longitude: longitude))
    }
}
