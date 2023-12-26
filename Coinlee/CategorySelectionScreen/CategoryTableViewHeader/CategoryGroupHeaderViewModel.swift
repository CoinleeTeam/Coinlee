//
//  CategoryTableViewHeaderViewModel.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 15/08/2023.
//

import Foundation
import RxSwift

final class CategoryGroupHeaderViewModel: CategoryGroupHeaderViewModelType {
    let categoryGroup: Observable<TransactionCategoryGroup>
    
    // MARK: - Init
    init(categoryGroup: TransactionCategoryGroup) {
        self.categoryGroup = .just(categoryGroup)
    }
}
