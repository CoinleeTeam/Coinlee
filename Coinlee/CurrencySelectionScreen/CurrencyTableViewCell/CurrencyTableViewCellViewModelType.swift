//
//  CurrencyTableViewCellViewModelType.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 22/08/2023.
//

import Foundation
import RxSwift

protocol CurrencyTableViewCellViewModelType: AnyObject {
    var currency: Observable<Currency> { get }
}
