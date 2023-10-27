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
}
