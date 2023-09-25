//
//  IncomeExpenseStaticCellViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import Foundation

protocol IncomeExpenseStaticCellViewModelType: AnyObject {
    var incomeAmount: Double { get }
    var expenseAmount: Double { get }
}
