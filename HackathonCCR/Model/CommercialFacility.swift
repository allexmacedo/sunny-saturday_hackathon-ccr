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
    
    let description: String
    
    let address: String
    
    let timeOfWork: String
    
    let phone: String
    
    let category: [FacilityCategory]
    
    let image: String
    
    let rating: Double
    
    let coordinate: CLLocation
    
    let verified: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case category
        case image
        case rating
        case latitude
        case longitude
        case verified
        case address
        case timeOfWork
        case phone
        case description
    }
    
    init(id: UUID, name: String, category: [FacilityCategory], description: String,
         address: String, timeOfWork: String, phone: String,
         image: String, rating: Double, verified: Bool, coordinate: CLLocation) {
        
        self.image = image
        self.id = id
        self.name = name
        self.category = category
        self.rating = rating
        self.coordinate = coordinate
        self.verified = verified
        self.address = address
        self.timeOfWork = timeOfWork
        self.phone = phone
        self.description = description
    }
    
    init(from decoder: Decoder) throws {
        
        let container                    = try decoder.container(keyedBy: CodingKeys.self)
        
        let id: UUID                     = try container.decode(UUID.self, forKey: .id)
        
        let name: String                 = try container.decode(String.self, forKey: .name)
        
        let image: String                = try container.decode(String.self, forKey: .image)
        
        let address: String              = try container.decode(String.self, forKey: .address)
        
        let description: String          = try container.decode(String.self, forKey: .description)
        
        let timeOfWork: String           = try container.decode(String.self, forKey: .timeOfWork)
        
        let phone: String                = try container.decode(String.self, forKey: .phone)

        let category: [FacilityCategory] = try container.decode([FacilityCategory].self, forKey: .category)
        
        let verified: Bool               = try container.decode(Bool.self, forKey: .verified)
        
        let rating: Double               = try container.decode(Double.self, forKey: .rating)
        
        let latitude: Double             = try container.decode(Double.self, forKey: .latitude)
        let longitude: Double            = try container.decode(Double.self, forKey: .longitude)
        
        self.init(id: id, name: name, category: category, description: description,
                  address: address, timeOfWork: timeOfWork, phone: phone, image: image,
                  rating: rating, verified: verified, coordinate: CLLocation(latitude: latitude, longitude: longitude))
    }
}
