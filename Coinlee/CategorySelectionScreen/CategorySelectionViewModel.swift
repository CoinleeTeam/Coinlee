//
//  CategoryViewModel.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 14/08/2023.
//

import UIKit

final class CategorySelectionViewModel: CategorySelectionViewModelType {
    let categories: [SectionOfTransactionCategory]
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
        (0..<categories[section].items.count).forEach { row in
            indexPaths.append(IndexPath(row: row, section: section))
        }
        
        return indexPaths
    }
    
    func numberOfSections() -> Int {
        return categories.count
    }
    
    func numberOfRows(forSection section: Int) -> Int {
        return categories[section].items.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CategoryTableViewCellViewModelType? {
        let transactionCategory = categories[indexPath.section].items[indexPath.row]
        return CategoryTableViewCellViewModel(transactionCategory: transactionCategory)
    }
    
    func headerViewModel(forSection section: Int) -> CategoryTableViewHeaderViewModelType? {
        guard let categoryGroup = categories[section].items.first?.categoryGroup else { return nil }
        return CategoryTableViewHeaderViewModel(categoryGroup: categoryGroup)
    }
}
