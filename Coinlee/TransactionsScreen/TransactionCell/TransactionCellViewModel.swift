//
//  TransactionCellViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import Foundation
import RxSwift

final class TransactionCellViewModel: TransactionCellViewModelType {
    let transaction: Observable<Transaction>
    
    // MARK: - Init
    init(transaction: Transaction) {
        self.transaction = .just(transaction)
    }
    
    // MARK: - Texts
    func transactionSumText(forTransaction transaction: Transaction) -> String {
        return transaction.sum.accountingFormatted() + CharacterConstants.whitespace + transaction.currency.code
    }
}
