//
//  TransactionCellHeaderViewViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import Foundation

protocol TransactionCellHeaderViewViewModelType: AnyObject {
    var date: Date { get }
    var balance: Double { get }
    var currency: String { get }
    
    // MARK: Computed properties
    var monthDay: String { get }
    var month: String { get }
    var weekDay: String { get }
    var monthAndYear: String { get }
}
