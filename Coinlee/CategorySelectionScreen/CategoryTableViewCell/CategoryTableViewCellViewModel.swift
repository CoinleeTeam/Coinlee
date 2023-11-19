//
//  CategoryTableViewCellViewModel.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 15/08/2023.
//

import Foundation

final class CategoryTableViewCellViewModel: CategoryTableViewCellViewModelType {
    let categoryName: String

    init(subCategory: TransactionCategory) {
        self.categoryName = subCategory.title
    }
}
