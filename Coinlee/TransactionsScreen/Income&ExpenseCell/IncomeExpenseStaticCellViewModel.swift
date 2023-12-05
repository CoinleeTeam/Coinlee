//
//  IncomeExpenseStaticCellViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import Foundation
import RxSwift

final class IncomeExpenseStaticCellViewModel: IncomeExpenseStaticCellViewModelType {
    let incomeText: BehaviorSubject<String>
    let expenseText: BehaviorSubject<String>
    
    // MARK: - Init
    init(incomeText: String, expenseText: String) {
        self.incomeText = .Observer(value: incomeText)
        self.expenseText = .Observer(value: expenseText)
    }
}
