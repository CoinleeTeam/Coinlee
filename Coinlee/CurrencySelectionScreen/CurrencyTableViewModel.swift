//
//  CurrencyTableViewModel.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 26/08/2023.
//

import Foundation

final class CurrencyTableViewModel: CurrencyTableViewModelType {
    let currencies = Currency.availableCurrencies()
    var filteredCurrencies = [Currency]()
    
    init() {
        filteredCurrencies = currencies
    }

    func updateFilteredCurrenciesWithSearchText(_ searchText: String) {
        filteredCurrencies = currencies.filter { currency in
            let searchTextLowercased = searchText.lowercased()
            return currency.name.lowercased().contains(searchTextLowercased) || currency.code.rawValue.lowercased().contains(searchTextLowercased)
        }
    }
    
    func numberOfRows(forSection section: Int) -> Int {
        filteredCurrencies.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CurrencyTableViewCellViewModelType? {
        let currency = filteredCurrencies[indexPath.row]
        return CurrencyTableViewCellViewModel(currency: currency)
    }
}

