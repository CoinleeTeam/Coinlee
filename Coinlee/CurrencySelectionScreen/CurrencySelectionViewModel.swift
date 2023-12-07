//
//  CurrencyTableViewModel.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 26/08/2023.
//

import Foundation
import RxRelay

final class CurrencySelectionViewModel: CurrencySelectionViewModelType {
    let currencies = Currency.availableCurrenciesSorted()
    var filteredCurrencies: BehaviorRelay<[Currency]>
    
    init() {
        self.filteredCurrencies = .init(value: currencies)
    }

    func updateFilteredCurrenciesWithSearchText(_ searchText: String) {
        let searchTextFilteredCurrencies = currencies.filter { currency in
            let searchTextLowercased = searchText.lowercased()
            return currency.localizedName.lowercased().contains(searchTextLowercased) || currency.code.lowercased().contains(searchTextLowercased)
        }
        filteredCurrencies.accept(searchTextFilteredCurrencies)
    }
    
    func cellViewModel(currency: Currency) -> CurrencyTableViewCellViewModelType {
        return CurrencyTableViewCellViewModel(currency: currency)
    }
}

