//
//  String+SpecialChars.swift
//  AppDemias
//
//  Created by Lucas Antevere Santana on 29/04/20.
//  Copyright (c) 2020 Mascarados. All rights reserved.

import Foundation
import UIKit

extension String {
    
    static func matchRegex(for regex: String, in text: String) -> String {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            
            if results.isEmpty {
                return ""
            } else {
                return String(text[Range(results[0].range, in: text)!])
            }
            
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return ""
        }
    }
    
    var forSorting: String {
        
        let simple = folding(options: [.diacriticInsensitive, .widthInsensitive, .caseInsensitive], locale: nil)
        
        let nonAlphaNumeric = CharacterSet.alphanumerics.inverted
        
        return simple.components(separatedBy: nonAlphaNumeric).joined(separator: "")
    }
}
