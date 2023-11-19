//
//  CategoryViewModel.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 14/08/2023.
//

import UIKit

final class CategoryTableViewViewModel: CategoryTableViewViewModelType {
    let categories: [[TransactionCategory]]
    let categoriesTransactionType: TransactionType
    var collapsedSections: Set<Int>
    
    init(categoriesTransactionType: TransactionType) {
        self.categoriesTransactionType = categoriesTransactionType
        self.categories = categoriesTransactionType == .income ? TransactionCategory.categories(ofType: .income) : TransactionCategory.categories(ofType: .expense)
        
        self.collapsedSections = []
        if categoriesTransactionType == .expense {
            (0..<categories.count).forEach { section in
                collapsedSections.insert(section)
            }
        }
    }
    
    func toggleSectionCollapse(forSection section: Int) {
        if collapsedSections.contains(section) {
            collapsedSections.remove(section)
        } else {
            collapsedSections.insert(section)
        }
    }
    
    func indexPaths(atSection section: Int) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        (0..<categories[section].count).forEach { row in
            indexPaths.append(IndexPath(row: row, section: section))
        }
        
        return indexPaths
    }
    
    func numberOfSections() -> Int {
        return categories.count
    }
    
    func numberOfRows(forSection section: Int) -> Int {
        return categories[section].count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CategoryTableViewCellViewModelType? {
        let category = categories[indexPath.section][indexPath.row]
        return CategoryTableViewCellViewModel(subCategory: category)
    }
    
    func headerViewModel(forSection section: Int) -> CategoryTableViewHeaderViewModelType? {
        guard let headCategory = categories[section].first?.categoryGroup else { return nil }
        return CategoryTableViewHeaderViewModel(headCategory: headCategory)
    }
}
