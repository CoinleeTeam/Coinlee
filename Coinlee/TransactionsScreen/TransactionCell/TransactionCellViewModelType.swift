//
//  TransactionCellViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import Foundation

protocol TransactionCellViewModelType: AnyObject {
    var transaction: Transaction { get }
    
    // MARK: Computed properties
    var balanceText: String { get }
}
