//
//  Constants.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import Foundation

/// Constants for commonly used character strings and symbols.
enum CharacterConstants {
    /// Returns a string representing the minus sign
    static let minusSign = "-"
    
    /// Returns a string representing whitespace
    static let whitespace = " "
    
    /// Returns a string representing the comma sign
    static let comma = ","
    
    /// Returns a string representing the dot sign
    static let dot = "."
    
    /// Returns a string representing a newline character ("\n").
    static let newLine = "\n"
    
    static let doubleHyphen = "--"
}

enum RegexPattern {
    /// "[(separator)]0$" -  Matches a number with exactly one zero after a separator at the end of the string (e.g., "5.0" or "10,0").
    static func exactZero(separator: String) -> String {
        return "[\(separator)]0$"
    }
    
    /// "[(separator)]0{2,3}[0-9]*$" -  Matches a number with two or three consecutive zeros after a separator, followed by optional digits at the end of the string (e.g., "5.000" or "10,000")
    static func twoOrThreeZeros(separator: String) -> String {
        return "[\(separator)]0{2,3}[0-9]*$"
    }
    
    /// "[(separator)][0-9]0" - Matches a number with a zero preceded by any single digit and a separator before the digit  (e.g., "5.50" or "1,90").
    static func zeroAtEnd(separator: String) -> String {
        return "[\(separator)][0-9]0"
    }
}
