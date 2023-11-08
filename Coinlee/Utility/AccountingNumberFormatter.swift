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
}
