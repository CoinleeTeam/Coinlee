//
//  TransactionCellViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import Foundation
import RxSwift

protocol TransactionCellViewModelType: AnyObject {
    var transaction: Observable<Transaction> { get }
    
    // MARK: - Texts
    func transactionSumText(forTransaction transaction: Transaction) -> String
}
