//
//  CurrencyTableViewCellViewModelType.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 22/08/2023.
//

import Foundation

protocol CurrencyTableViewCellViewModelType: AnyObject {
    var currencyName: String { get }
    var currencyCode: String { get }
}
