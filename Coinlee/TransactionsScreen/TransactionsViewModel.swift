//
//  TransactionsViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 26/08/2023.
//

import Foundation

final class TransactionsViewModel: TransactionsViewModelType {
    var balanceAmount: Double
    var incomeAmount: Double
    var expenseAmount: Double
    var transactionsArray: [[Transaction]] = [
        [
            Transaction(date: .now, sum: 130.52, description: "Some income", category: Subcategory(iconName: Icon.Category.workshop.rawValue, title: "Investment"), currency: "PLN"),
            Transaction(date: .now, sum: -20, description: "Pivo", category: Subcategory(iconName: Icon.Category.investments.rawValue, title: "Pivo category"), currency: "PLN")
        ],
        [
            Transaction(date: Date(timeIntervalSinceNow: -86400), sum: -0.99, description: "Tualet", category: Subcategory(iconName: Icon.Category.sport.rawValue, title: "Health"), currency: "PLN"),
            Transaction(date: Date(timeIntervalSinceNow: -86400), sum: 15000, description: "Zarplata iOS'era", category: Subcategory(iconName: Icon.Category.hobbies.rawValue, title: "Salary"), currency: "PLN"),
            Transaction(date: Date(timeIntervalSinceNow: -86400), sum: 500, description: "investicii", category: Subcategory(iconName: Icon.Category.investment.rawValue, title: "Investment"), currency: "PLN"),
        ],
        [
            Transaction(date: Date(timeIntervalSinceNow: -172800), sum: -0.99, description: "Tualet", category: Subcategory(iconName: Icon.Category.sport.rawValue, title: "Health"), currency: "PLN"),
            Transaction(date: Date(timeIntervalSinceNow: -172800), sum: 15000, description: "Zarplata iOS'era", category: Subcategory(iconName: Icon.Category.hobbies.rawValue, title: "Salary"), currency: "PLN"),
            Transaction(date: Date(timeIntervalSinceNow: -172800), sum: 500, description: "investicii", category: Subcategory(iconName: Icon.Category.investment.rawValue, title: "Investment"), currency: "PLN"),
        ]
    ]
    
    // MARK: - Init
    init(balanceAmount: Double, incomeAmount: Double, expenseAmount: Double) {
        self.balanceAmount = balanceAmount
        self.incomeAmount = incomeAmount
        self.expenseAmount = expenseAmount
    }
    
    // MARK: - UICollectionViewDataSource data
    func numberOfSections() -> Int {
        return transactionsArray.count + 1
    }
    
    func numberOfTransactions(inSection section: Int) -> Int {
        return transactionsArray[section - 1].count
    }
    
    // MARK: ViewModels
    func incomeExpenseStaticCellViewModel() -> IncomeExpenseStaticCellViewModelType? {
        return IncomeExpenseStaticCellViewModel(incomeAmount: incomeAmount, expenseAmount: expenseAmount)
    }
    
    func transactionCellViewModel(at indexPath: IndexPath) -> TransactionCellViewModelType? {
        return TransactionCellViewModel(transaction: transactionsArray[indexPath.section - 1][indexPath.row])
    }
    
    func transactionCellHeaderViewViewModel(forSection section: Int) -> TransactionCellHeaderViewModelType? {
        guard let firstCell = transactionsArray[section - 1].first else { return nil }
        var balance = 0.0
        transactionsArray[section - 1].forEach { transaction in
            balance += transaction.sum
        }
        return TransactionCellHeaderViewModel(date: firstCell.date, balance: balance, currency: firstCell.currency)
    }
}
