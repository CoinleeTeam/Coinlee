//
//  CurrencyTableViewViewModel.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 26/08/2023.
//

import Foundation

class CurrencyTableViewViewModel: CurrencyTableViewViewModelType {
    func numberOfRows(forSection section: Int) -> Int {
        return Currency.availableCurrencies().count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CurrencyTableViewCellViewModelType? {
        let currency = Currency.availableCurrencies()[indexPath.row]
        return CurrencyTableViewCellViewModel(currency: currency)
    }
}
