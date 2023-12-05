//
//  TransactionCellHeaderViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import Foundation
import RxRelay

protocol TransactionCellHeaderViewModelType: AnyObject {
    var date: BehaviorRelay<Date> { get }
    var balance: BehaviorRelay<Double> { get }
    var currency: Currency { get }
    
    // MARK: Computed properties
    var monthDay: String { get }
    var weekDay: String { get }
    var monthAndYear: String { get }
}
