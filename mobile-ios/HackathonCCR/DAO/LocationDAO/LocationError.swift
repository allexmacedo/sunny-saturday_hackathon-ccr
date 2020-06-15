//
//  LocationError.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 29/04/20.
//  Copyright © 2020 Mascarados. All rights reserved.
//

import Foundation

enum LocationError: String, Error {
    
    case nilLocation             = "Could not get the current user location"
    case localizationNotEnabled  = "Localization services are not enabled"
    case localizationRestricted  = "The localization services are restriced to this app"
    case userAlreadyDeniedAccess = "The user already denied access to localization services"
    case frameworkError          = "There are not covered new options of location authorization"
    case reverseGeocodingError   = "Could not reverse geocode current location"
}
