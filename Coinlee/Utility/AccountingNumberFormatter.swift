//
//  AccountingNumberFormatter.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 07/11/2023.
//

import Foundation

final class AccountingNumberFormatter: NumberFormatter {
    override init() {
        super.init()
        numberStyle = .decimal
        maximumFractionDigits = 2
        roundingMode = .down
        locale = .current
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyFormat(previousText: String, currentText: String) -> String {
        let formatter = AccountingNumberFormatter()
        let newTextWithoutGroupingSeparators = currentText.replacingOccurrences(of: formatter.groupingSeparator, with: String())
        guard let newTextLast = currentText.last else { return currentText }
        
        if !previousText.isEmpty &&
            String(newTextLast) == formatter.decimalSeparator &&
            currentText.components(separatedBy: formatter.decimalSeparator).count < 3 &&
            previousText.components(separatedBy: formatter.decimalSeparator).count < 2 {
            return currentText
        }
        
        if let numberWithoutGroupingSeparator = formatter.number(from: newTextWithoutGroupingSeparators),
           let formattedText = formatter.string(from: numberWithoutGroupingSeparator), formattedText.count <= 19 {
            if newTextWithoutGroupingSeparators.isValidWith(regex: RegexPattern.exactZero(separator: formatter.decimalSeparator)) {
                return formattedText + formatter.decimalSeparator + String(0)
                
            } else if newTextWithoutGroupingSeparators.isValidWith(regex: RegexPattern.twoOrThreeZeros(separator: formatter.decimalSeparator)) {
                return formattedText + formatter.decimalSeparator + String(0) + String(0)
                
            } else if newTextWithoutGroupingSeparators.isValidWith(regex: RegexPattern.zeroAtEnd(separator: formatter.decimalSeparator)) {
                return formattedText + String(0)
                
            } else  {
                return formattedText
            }
        }
        return currentText.isEmpty ? currentText : previousText
    }
}
