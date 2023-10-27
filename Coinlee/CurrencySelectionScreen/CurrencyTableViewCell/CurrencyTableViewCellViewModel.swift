//
//  CurrencyTableViewCellViewModel.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 22/08/2023.
//

import Foundation

final class CurrencyTableViewCellViewModel: CurrencyTableViewCellViewModelType {
    private var currency: Currency
    
    var currencyName: String {
        return currency.name
    }
    
    var currencyCode: String {
        return currency.code.rawValue
    }
    
    init(currency: Currency) {
        self.currency = currency
    }
}
