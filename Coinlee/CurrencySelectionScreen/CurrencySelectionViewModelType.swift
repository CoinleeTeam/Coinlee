//
//  CurrencyTableViewModelType.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 26/08/2023.
//

import Foundation
import RxRelay

protocol CurrencySelectionViewModelType: AnyObject {
    var currencies: [Currency] { get }
    var filteredCurrencies: BehaviorRelay<[Currency]> { get set }
    
    func updateFilteredCurrenciesWithSearchText(_ searchText: String)
    func cellViewModel(currency: Currency) -> CurrencyTableViewCellViewModelType
}
