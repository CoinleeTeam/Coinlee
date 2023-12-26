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
    let transactionCategory: BehaviorSubject<TransactionCategory?>
    let wallet: BehaviorSubject<Wallet>
    
    init() {
        self.amount = Double()
        self.date = Date()
        self.note = String()
        self.transactionType = .expense
        self.transactionCategory = BehaviorSubject(value: .none)
        self.wallet = BehaviorSubject(value: Wallet(name: "Wallet",
                                                    balance: 200,
                                                    currency: .rub,
                                                    icon: .bankBuilding,
                                                    type: .businessAccount,
                                                    isActive: true))
    }
}
