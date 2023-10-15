//
//  Double.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 18/09/2023.
//

import Foundation

extension Double {
    /// Returns a string representation of a double value in a currency format.
    func currencyFormatted() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.decimalSeparator = CharacterConstants.comma
        numberFormatter.groupingSeparator = CharacterConstants.dot
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.roundingMode = .down
        return numberFormatter.string(from: NSNumber(value: self)) ?? String()
    }
}
