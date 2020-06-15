//
//  MKDistanceFormatter+appFormatter.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright (c) 2020 Equipe261. All rights reserved.

import Foundation

extension LengthFormatter {
    
    private static var kilometersFormmater: LengthFormatter {
        
        let formatter = LengthFormatter()
        
        formatter.unitStyle = .short
        
        return formatter
    }
    
    static func localizedString(fromMeters value: Double) -> String? {
        return LengthFormatter.kilometersFormmater.string(fromMeters: value)
    }
}
