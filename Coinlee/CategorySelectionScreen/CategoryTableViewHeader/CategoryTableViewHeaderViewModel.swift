//
//  CategoryTableViewHeaderViewModel.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 15/08/2023.
//

import Foundation

final class CategoryTableViewHeaderViewModel: CategoryTableViewHeaderViewModelType {
    let categoryName: String
    
    // MARK: - Init
    init(headCategory: Icon.TranasctionCategoryGroup) {
        self.categoryName = headCategory.rawValue
    }
}
