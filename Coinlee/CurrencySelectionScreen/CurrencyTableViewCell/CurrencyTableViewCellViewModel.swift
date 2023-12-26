//
//  CurrencyTableViewCellViewModel.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 22/08/2023.
//

import Foundation
import RxSwift

final class CurrencyTableViewCellViewModel: CurrencyTableViewCellViewModelType {
    let currency: Observable<Currency>
    
    init(currency: Currency) {
        self.currency = .just(currency)
    }
}
