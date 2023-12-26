//
//  CategoryViewModel.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 14/08/2023.
//

import UIKit
import RxSwift
import RxRelay

final class CategorySelectionViewModel: CategorySelectionViewModelType {
    let categories: BehaviorRelay<[SectionOfTransactionCategory]>
    let transactionType: TransactionType
    var collapsedSections: Set<Int> = []
    
    init(transactionType: TransactionType) {
        self.transactionType = transactionType
        let categories = transactionType == .income ? TransactionCategory.categories(ofType: .income) : TransactionCategory.categories(ofType: .expense)
        
        if transactionType == .expense {
            for section in 0..<categories.count {
                collapsedSections.insert(section)
            }
        }
        
        self.categories = BehaviorRelay(value: categories)
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
        
        (0..<categories.value[section].items.count).forEach { row in
            indexPaths.append(IndexPath(row: row, section: section))
        }
        return indexPaths
    }
    
    func numberOfSections() -> Int {
        return categories.value.count
    }
    
    func numberOfRows(forSection section: Int) -> Int {
        return categories.value[section].items.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CategoryCellViewModelType {
        let transactionCategory = categories.value[indexPath.section].items[indexPath.row]
        return CategoryCellViewModel(category: transactionCategory)
        
    }
    
    func headerViewModel(forSection section: Int) -> CategoryGroupHeaderViewModelType? {
        guard let categoryGroup = categories.value[section].items.first?.categoryGroup else { return nil }
        return CategoryGroupHeaderViewModel(categoryGroup: categoryGroup)
    }
}
