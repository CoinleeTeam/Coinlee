//
//  CategoryTableViewCellViewModelType.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 15/08/2023.
//

import UIKit
import RxSwift

protocol CategoryCellViewModelType: AnyObject {
    var category: Observable<TransactionCategory> { get }
}
