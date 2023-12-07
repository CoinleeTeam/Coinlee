//
//  TransactionDetailViewModel.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 28/10/2023.
//

import UIKit
import RxSwift

final class TransactionDetailViewModel: TransactionDetailViewModelType {
    var amount: Double
    var date: Date
    var note: String
    var transactionType: TransactionType
    let wallet: BehaviorSubject<Wallet>
    let transactionCategory: BehaviorSubject<TransactionCategory?>
    
    init() {
        self.amount = Double()
        self.transactionCategory = .Observer(value: .none)
        self.date = Date()
        self.wallet = .Observer(value: .init(name: "Wallet", balance: 200, currency: .rub, icon: .bankBuilding, type: .businessAccount, isActive: true))
        self.note = String()
        self.transactionType = .expense
    }
}
