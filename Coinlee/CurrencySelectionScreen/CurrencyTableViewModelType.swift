//
//  CurrencyTableViewModelType.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 26/08/2023.
//

import Foundation

protocol CurrencyTableViewModelType: AnyObject {
    var currencies: [Currency] { get }
    var filteredCurrencies: [Currency] { get set }
    
    func updateFilteredCurrenciesWithSearchText(_ searchText: String)
    func numberOfRows(forSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CurrencyTableViewCellViewModelType?
}
