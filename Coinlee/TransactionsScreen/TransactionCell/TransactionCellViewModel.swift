//
//  TransactionCellViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import Foundation
import RxSwift

final class TransactionCellViewModel: TransactionCellViewModelType {
    let transaction: BehaviorSubject<Transaction>
    
    // MARK: - Init
    init(transaction: Transaction) {
        self.transaction = .Observer(value: transaction)
    }
}
