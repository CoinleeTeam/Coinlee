//
//  CurrencyTableViewViewModelType.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 26/08/2023.
//

import Foundation

protocol CurrencyTableViewViewModelType {
    func numberOfRows(forSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CurrencyTableViewCellViewModelType?
}
