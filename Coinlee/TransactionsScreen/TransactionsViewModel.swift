//
//  TransactionsViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 26/08/2023.
//

import Foundation
import RxSwift

final class TransactionsViewModel: TransactionsViewModelType {
    var balanceText = BehaviorSubject<String>(value: CharacterConstants.doubleHyphen)
    var transactions = BehaviorSubject<[SectionOfTransactions]>(value: [SectionOfTransactions()])
    
    private var incomeText: String = CharacterConstants.doubleHyphen
    private var expenseText: String = CharacterConstants.doubleHyphen
    
    let fetchedTransactions: [[Transaction]]  = [
        [
            Transaction(date: .now, sum: 130.52, description: "Some income", category: .healthInsurance, currency: .pln),
            Transaction(date: .now, sum: -20, description: "Pivo", category: .books, currency: .pln)
        ],
        [
            Transaction(date: Date(timeIntervalSinceNow: -86400), sum: -0.99, description: "Tualet", category: .sport, currency: .pln),
            Transaction(date: Date(timeIntervalSinceNow: -86400), sum: 15000, description: "Zarplata iOS'era", category: .hobbies, currency: .pln),
            Transaction(date: Date(timeIntervalSinceNow: -86400), sum: 500, description: "investicii", category: .investment, currency: .pln),
        ],
        [
            Transaction(date: Date(timeIntervalSinceNow: -172800), sum: -0.99, description: "Tualet", category: .sport, currency: .pln),
            Transaction(date: Date(timeIntervalSinceNow: -172800), sum: 15000, description: "Zarplata iOS'era", category: .hobbies, currency: .pln),
            Transaction(date: Date(timeIntervalSinceNow: -172800), sum: 500, description: "investicii", category: .cafe, currency: .pln),
        ]
    ]
    
    // MARK: - Init
    init() {
        // <<<<<<<<<<<<<<<<<<<<<<< TO BE DELETED ----------------------------------------
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            var transactions = [SectionOfTransactions()]
            self.fetchedTransactions.forEach { groupedTransaction in
                let transactionSection = SectionOfTransactions(items: groupedTransaction)
                transactions.append(transactionSection)
            }
            
            self.transactions.onNext(transactions)
            self.incomeText = self.sumUpTransactions(ofTransactionType: .income)?.accountingFormatted() ?? CharacterConstants.doubleHyphen
            self.expenseText = self.sumUpTransactions(ofTransactionType: .expense)?.accountingFormatted() ?? CharacterConstants.doubleHyphen
            self.balanceText.onNext("2,425.35 PLN")
        }
        // ------------------------ TO BE DELETED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    }
    
    // MARK: - Calculations
    private func sumUpTransactions(ofTransactionType transactionType: TransactionType) -> Double? {
        guard let sectionsOfTranscations = try? transactions.value() else { return nil }
        var flattenTransactions: [Transaction] = []
        sectionsOfTranscations.forEach { sectionOfTransaction in
            flattenTransactions.append(contentsOf: sectionOfTransaction.items)
        }
        
        var result: Decimal = 0.0
        flattenTransactions.forEach { transaction in
            if transaction.sum > 0 && transactionType == .income {
                result += Decimal(transaction.sum)
            } else if transaction.sum < 0 && transactionType == .expense {
                result += Decimal(transaction.sum)
            }
        }
        
        return NSDecimalNumber(decimal: result).doubleValue
    }
        
    // MARK: ViewModels
    func incomeExpenseStaticCellViewModel() -> IncomeExpenseStaticCellViewModelType {
        return IncomeExpenseStaticCellViewModel(incomeText: incomeText, expenseText: expenseText)
    }
    
    func transactionCellViewModel(transaction: Transaction) -> TransactionCellViewModelType {
        return TransactionCellViewModel(transaction: transaction)
    }
    
    func transactionCellHeaderViewViewModel(forSection section: Int) -> TransactionCellHeaderViewModelType? {
        guard let firstCell = try? transactions.value()[section].items.first else { return nil }
        var balance = 0.0
        try? transactions.value()[section].items.forEach { transaction in
            balance += transaction.sum
        }
        return TransactionCellHeaderViewModel(date: firstCell.date, balance: balance, currency: firstCell.currency)
    }
}
