//
//  CurrencyTableViewModel.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 26/08/2023.
//

import Foundation

final class CurrencySelectionViewModel: CurrencySelectionViewModelType {
    let currencies = Currency.availableCurrenciesSorted()
    var filteredCurrencies = [Currency]()
    
    init() {
        filteredCurrencies = currencies
    }

    func updateFilteredCurrenciesWithSearchText(_ searchText: String) {
        filteredCurrencies = currencies.filter { currency in
            let searchTextLowercased = searchText.lowercased()
            return currency.localizedName.lowercased().contains(searchTextLowercased) || currency.code.lowercased().contains(searchTextLowercased)
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

