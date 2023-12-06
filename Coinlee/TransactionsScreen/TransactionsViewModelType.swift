//
//  TransactionsViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 26/08/2023.
//

import Foundation
import RxSwift

protocol TransactionsViewModelType: AnyObject {
    var balanceText: BehaviorSubject<String> { get }
    var transactions: BehaviorSubject<[SectionOfTransactions]> { get }
    
    // MARK: ViewModels
    func incomeExpenseStaticCellViewModel() -> IncomeExpenseStaticCellViewModelType?
    func transactionCellViewModel(transaction: Transaction) -> TransactionCellViewModelType
    func transactionCellHeaderViewViewModel(forSection section: Int) -> TransactionCellHeaderViewModelType?
}
