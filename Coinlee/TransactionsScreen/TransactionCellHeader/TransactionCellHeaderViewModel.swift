//
//  TransactionCellHeaderViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import Foundation
import RxSwift

final class TransactionCellHeaderViewModel: TransactionCellHeaderViewModelType {
    let date: Observable<Date>
    let balance: Observable<Double>
    let currency: Currency
    
    // MARK: - Init
    init(date: Date, balance: Double, currency: Currency) {
        self.date = .just(date)
        self.balance = .just(balance)
        self.currency = currency
    }
    
    // MARK: - Texts
    func monthDayText(forDate date: Date) -> String {
        date.formatted(.dateTime.day())
    }
    
    func weekDayText(forDate date: Date) -> String {
        date.formatted(.dateTime.weekday(.wide))
    }
    
    func monthAndYearText(forDate date: Date) -> String {
        date.formatted(.dateTime.month(.wide)) + CharacterConstants.whitespace + date.formatted(.dateTime.year())
    }
    
    func balanceText(balance: Double) -> String {
        balance.accountingFormatted() + CharacterConstants.whitespace + currency.code
    }
}
