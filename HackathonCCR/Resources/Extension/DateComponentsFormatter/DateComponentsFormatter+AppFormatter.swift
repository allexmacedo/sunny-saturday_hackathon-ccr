//
//  DateIntervalFormatter+AppFormatter.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 13/06/20.
//  Copyright (c) 2020 Equipe261. All rights reserved.

import UIKit

extension DateComponentsFormatter {
    
    private static var timeFormatter: DateComponentsFormatter {
        
        let dateIntervalFormatter = DateComponentsFormatter()
        
        dateIntervalFormatter.allowedUnits     = [.day, .hour, .minute]
        dateIntervalFormatter.unitsStyle       = .abbreviated
        dateIntervalFormatter.maximumUnitCount = 3
        
        dateIntervalFormatter.calendar = Calendar.current
        
        return dateIntervalFormatter
    }
    
    static func localizedTimeIntervalString(duration: TimeInterval) -> String? {
        return DateComponentsFormatter.timeFormatter.string(from: duration)
    }
}
