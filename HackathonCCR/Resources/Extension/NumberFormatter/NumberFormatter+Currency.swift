//
//  NumberFormatter+Currency.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 12/06/20.
//  Copyright (c) 2020 Equipe261. All rights reserved.

import UIKit

extension NumberFormatter {
    
    private static var currencyFormatter: NumberFormatter {
        
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        
        return numberFormatter
    }
       
    static func localizedCurrencyString(from number: Double) -> String? {
        return NumberFormatter.currencyFormatter.string(from: NSNumber(value: number))
    }
    
    static func currencyNumber(from text: String) -> Double? {
        return NumberFormatter.currencyFormatter.number(from: text) as? Double
    }
}
