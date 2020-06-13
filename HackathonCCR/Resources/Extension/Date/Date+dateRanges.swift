//
//  Date+dateRanges.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 12/06/20.
//  Copyright (c) 2020 Equipe261. All rights reserved.

import UIKit

extension Date {
    
    var beginOfYear: Date? {
        
        guard let year = Calendar.current.dateComponents([.year], from: self).year else {return nil}
        
        return Calendar.current.date(from: DateComponents(year: year, month: 1, day: 1))
    }
    
    var beginOfMonth: Date? {
        let components = Calendar.current.dateComponents([.month, .year], from: self)
        
        guard let year = components.year, let month = components.month else {return nil}
        
        return Calendar.current.date(from: DateComponents(year: year, month: month, day: 1))
    }
    
    var daysSinceBeginOfMonth: Int? {
        guard let beginOfMonth = self.beginOfMonth else {return nil}
        
        return Date.dayRange(from: beginOfMonth, to: self)
    }
    
    var monthsSinceBeginOfYear: Int? {
        guard let beginOfYear = self.beginOfYear else {return nil}
        
        return Date.monthRange(from: beginOfYear, to: self)
    }
    
    private static func dayRange(from date1: Date, to date2: Date) -> Int? {
        
        let components = Calendar.current.dateComponents([.day], from: date1, to: date2)
        
        return components.day
    }
    
    private static func monthRange(from date1: Date, to date2: Date) -> Int? {
        
        let components = Calendar.current.dateComponents([.month], from: date1, to: date2)
        
        return components.month
    }
}
