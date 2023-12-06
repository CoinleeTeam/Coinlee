//
//  TransactionCellHeaderViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import Foundation
import RxSwift

protocol TransactionCellHeaderViewModelType: AnyObject {
    var date: Observable<Date> { get }
    var balance: Observable<Double> { get }
    var currency: Currency { get }
    
    // MARK: Texts
    func monthDayText(forDate date: Date) -> String
    func weekDayText(forDate date: Date) -> String
    func monthAndYearText(forDate date: Date) -> String
    func balanceText(balance: Double) -> String
}
