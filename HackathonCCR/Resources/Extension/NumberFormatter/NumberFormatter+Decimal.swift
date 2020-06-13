//
//  NumberFormatter+Decimal.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 12/06/20.
//  Copyright (c) 2020 Equipe261. All rights reserved.

import UIKit

extension NumberFormatter {
    
    private static var decimalFormatter: NumberFormatter {
        
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale.current
        
        return numberFormatter
    }
    
    static func localizedDecimalString(from number: Double) -> String? {
        return NumberFormatter.decimalFormatter.string(from: NSNumber(value: number))
    }
    
    static func decimalNumber(from text: String) -> Double? {
        return NumberFormatter.decimalFormatter.number(from: text) as? Double
    }
}
