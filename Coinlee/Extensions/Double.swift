//
//  Double.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 18/09/2023.
//

import Foundation

extension Double {
    /// Returns a string representation of a double value in a currency format.
    func accountingFormatted() -> String {
        let numberFormatter = AccountingNumberFormatter()
        let hasDecimalPlaces = self != Double(Int(self))
        numberFormatter.minimumFractionDigits = hasDecimalPlaces ? 2 : 0
        return numberFormatter.string(from: NSNumber(value: self)) ?? String()
    }
}
