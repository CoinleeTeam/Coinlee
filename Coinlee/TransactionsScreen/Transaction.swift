//
//  Transaction.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 18/09/2023.
//

import Foundation

struct Transaction {
    let date: Date
    let sum: Double
    let description: String
    let category: Subcategory
    let currency : String
}

// MARK: - TO BE DELETED
struct Subcategory {
    let iconName: String
    let title : String
}
