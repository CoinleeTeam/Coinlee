//
//  TransactionCategoryGroup.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 05/12/2023.
//

import Foundation

enum TransactionCategoryGroup: String {
    case foodDining
    case transportation
    case housing
    case entertainment
    case shoppingPurchases
    case healthFitness
    case travel
    case education
    case family
    case giftsDonations
    case investments
    case income
    
    var localizedName: String {
        NSLocalizedString(rawValue, comment: "Category group name")
    }
}
