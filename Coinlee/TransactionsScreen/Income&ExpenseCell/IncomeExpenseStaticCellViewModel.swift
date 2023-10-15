//
//  IncomeExpenseStaticCellViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import Foundation

final class IncomeExpenseStaticCellViewModel: IncomeExpenseStaticCellViewModelType {
    let incomeAmount: Double
    let expenseAmount: Double
    
    // MARK: - Init
    init(incomeAmount: Double, expenseAmount: Double) {
        self.incomeAmount = incomeAmount
        self.expenseAmount = expenseAmount
    }
}
