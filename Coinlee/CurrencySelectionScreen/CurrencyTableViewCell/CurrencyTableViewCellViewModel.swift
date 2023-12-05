//
//  CurrencyTableViewCellViewModel.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 22/08/2023.
//

import Foundation

final class CurrencyTableViewCellViewModel: CurrencyTableViewCellViewModelType {
    let currency: Currency
    
    init(currency: Currency) {
        self.currency = currency
    }
}
