//
//  IncomeExpenseStaticCellViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import Foundation
import RxSwift

protocol IncomeExpenseStaticCellViewModelType: AnyObject {
    var incomeText: BehaviorSubject<String> { get }
    var expenseText: BehaviorSubject<String> { get }
}
