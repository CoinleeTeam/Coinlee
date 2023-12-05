//
//  CategoryTableViewHeaderViewModel.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 15/08/2023.
//

import Foundation

final class CategoryTableViewHeaderViewModel: CategoryTableViewHeaderViewModelType {
    let categoryGroup: TransactionCategoryGroup
    
    // MARK: - Init
    init(categoryGroup: TransactionCategoryGroup) {
        self.categoryGroup = categoryGroup
    }
}
