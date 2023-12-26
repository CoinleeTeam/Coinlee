//
//  IncomeExpenseStaticCellViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import Foundation
import RxSwift

final class IncomeExpenseStaticCellViewModel: IncomeExpenseStaticCellViewModelType {
    let incomeText: Observable<String>
    let expenseText: Observable<String>
    
    // MARK: - Init
    init(incomeText: String, expenseText: String) {
        self.incomeText = .just(incomeText)
        self.expenseText = .just(expenseText)
    }
}
