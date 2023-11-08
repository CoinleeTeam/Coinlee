//
//  TransactionsViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 26/08/2023.
//

import Foundation

protocol TransactionsViewModelType: AnyObject {
    var balanceAmount: Double { get }
    var incomeAmount: Double { get }
    var expenseAmount: Double { get }
    var transactionsArray: [[Transaction]] { get }
    
    // MARK: UICollectionViewDataSource data
    func numberOfSections() -> Int
    func numberOfTransactions(inSection section: Int) -> Int
    
    // MARK: ViewModels
    func incomeExpenseStaticCellViewModel() -> IncomeExpenseStaticCellViewModelType?
    func transactionCellViewModel(at indexPath: IndexPath) -> TransactionCellViewModelType?
    func transactionCellHeaderViewViewModel(forSection section: Int) -> TransactionCellHeaderViewModelType?
}
