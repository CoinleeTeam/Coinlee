//
//  IncomeExpenseStaticCellViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import Foundation
import RxSwift

protocol IncomeExpenseStaticCellViewModelType: AnyObject {
    var incomeText: Observable<String> { get }
    var expenseText: Observable<String> { get }
}
