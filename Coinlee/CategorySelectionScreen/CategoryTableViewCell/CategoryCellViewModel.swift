//
//  CategoryTableViewCellViewModel.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 15/08/2023.
//

import Foundation
import RxSwift

final class CategoryCellViewModel: CategoryCellViewModelType {
    let category: Observable<TransactionCategory>
    
    init(category: TransactionCategory) {
        self.category = .just(category)
    }
}
