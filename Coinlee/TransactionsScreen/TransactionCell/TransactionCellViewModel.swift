//
//  TransactionCellViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import Foundation

final class TransactionCellViewModel: TransactionCellViewModelType {
    let transaction: Transaction
    
    // MARK: Computed properties
    var balanceText: String {
        transaction.sum.accountingFormatted() + CharacterConstants.whitespace + transaction.currency
    }
    
    // MARK: - Init
    init(transaction: Transaction) {
        self.transaction = transaction
    }
}
