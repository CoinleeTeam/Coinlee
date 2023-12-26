//
//  Transaction.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 18/09/2023.
//

import Foundation
import Differentiator

struct Transaction {
    let date: Date
    let sum: Double
    let description: String
    let category: TransactionCategory
    let currency : Currency
    
    init(date: Date, sum: Double, description: String, category: TransactionCategory, currency: Currency) {
        self.date = date
        self.sum = sum
        self.description = description
        self.category = category
        self.currency = currency
    }
    
    init() {
        self.init(date: Date(),
                  sum: Double(),
                  description: String(),
                  category: .accomodation,
                  currency: .usd)
    }
}

struct SectionOfTransactions {
    var items: [Item]
}

extension SectionOfTransactions: SectionModelType {
    typealias Item = Transaction

    init(original: SectionOfTransactions, items: [Item]) {
        self = original
        self.items = items
    }
    
    init() {
        self.items = [Transaction()]
    }
}
