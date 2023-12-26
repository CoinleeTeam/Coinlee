//
//  String.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 23/10/2023.
//

import Foundation

// MARK: String
extension String {
    /// Truncates the string to a specified maximum length, if the string's length exceeds the specified limit.
    func truncated(to length: Int) -> String {
        if self.count > length {
            let truncatedIndex = self.index(self.startIndex, offsetBy: length)
            return String(self[..<truncatedIndex])
        }
        return self
    }
    
    /**
     Determines if a string conforms to a specific regex pattern. It compiles the provided regex pattern and attempts to find a match within the entire string. If a match is found, it returns `true`; otherwise, it returns `false`.
     
     - Note: If the provided regex pattern is invalid, this method will also return `false`.
     */
    func isValidWith(regex: String) -> Bool {
        guard let gRegex = try? NSRegularExpression(pattern: regex) else { return false }
        let range = NSRange(location: 0, length: self.utf16.count)
        
        if gRegex.firstMatch(in: self, range: range) != nil {
            return true
        }
        
        return false
    }
    
    /// Attempts to convert a formatted numeric string into a Double.
    ///
    ///
    /// - Returns: A Double value if the conversion is successful, or nil if the string does not represent a valid numeric value.
    func asDouble() -> Double? {
        let stringWithoutGroupingSeparator = self.replacingOccurrences(of: AccountingNumberFormatter().groupingSeparator,
                                                                       with: String())
        let stringInFormatOfDouble = stringWithoutGroupingSeparator.replacingOccurrences(of: AccountingNumberFormatter().decimalSeparator,
                                                                                         with: CharacterConstants.dot)
        return Double(stringInFormatOfDouble)
    }
}
