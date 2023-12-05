//
//  TransactionCellHeaderViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import Foundation
import RxRelay

final class TransactionCellHeaderViewModel: TransactionCellHeaderViewModelType {
    let date: BehaviorRelay<Date>
    let balance: BehaviorRelay<Double>
    let currency: String
    
    // MARK: Computed properties
    var monthDay: String {
        date.value.formatted(.dateTime.day())
    }
    
    var weekDay: String {
        date.value.formatted(.dateTime.weekday(.wide))
    }
    
    var monthAndYear: String {
        date.value.formatted(.dateTime.month(.wide)) + CharacterConstants.whitespace + date.value.formatted(.dateTime.year())
    }
    
    // MARK: - Init
    init(date: Date, balance: Double, currency: String) {
        self.date = .init(value: date)
        self.balance = .init(value: balance)
        self.currency = currency
    }
}
