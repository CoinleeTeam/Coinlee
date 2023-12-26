//
//  CategoryTableViewHeaderViewModelType.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 15/08/2023.
//

import Foundation
import RxSwift

protocol CategoryGroupHeaderViewModelType: AnyObject {
    var categoryGroup: Observable<TransactionCategoryGroup> { get }
}
