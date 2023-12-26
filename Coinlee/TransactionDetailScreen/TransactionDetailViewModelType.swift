//
//  TransactionDetailViewModelType.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 28/10/2023.
//

import Foundation
import RxSwift

protocol TransactionDetailViewModelType: AnyObject {
    var amount: Double { get set }
    var date: Date { get set }
    var note: String { get set }
    var transactionType: TransactionType { get set }
    var wallet: BehaviorSubject<Wallet> { get }
    var transactionCategory: BehaviorSubject<TransactionCategory?> { get }
}
