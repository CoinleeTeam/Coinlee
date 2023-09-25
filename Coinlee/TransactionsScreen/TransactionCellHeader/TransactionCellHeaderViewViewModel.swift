//
//  TransactionCellHeaderViewViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import Foundation

final class TransactionCellHeaderViewViewModel: TransactionCellHeaderViewViewModelType {
    let date: Date
    let balance: Double
    let currency: String
    
    // MARK: Computed properties
    var monthDay: String {
        date.formatted(.dateTime.day())
    }
    
    var month: String {
        date.formatted(.dateTime.month())
    }
    
    var weekDay: String {
        date.formatted(.dateTime.weekday(.wide))
    }
    
    var monthAndYear: String {
        date.formatted(.dateTime.month(.wide)) + CharacterConstants.whitespace + date.formatted(.dateTime.year())
    }
    
    // MARK: - Init
    init(date: Date, balance: Double, currency: String) {
        self.date = date
        self.balance = balance
        self.currency = currency
    }
}
