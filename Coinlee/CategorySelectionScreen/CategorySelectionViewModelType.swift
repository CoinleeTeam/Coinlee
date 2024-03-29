//
//  CategoryViewModelType.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 15/08/2023.
//

import UIKit

protocol CategorySelectionViewModelType: AnyObject {
    var collapsedSections: Set<Int> { get set }
    var transactionType: TransactionType { get }
    
    func toggleSectionCollapse(forSection section: Int)
    func indexPaths(atSection section: Int) -> [IndexPath]
    func numberOfSections() -> Int
    func numberOfRows(forSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CategoryCellViewModelType
    func headerViewModel(forSection section: Int) -> CategoryGroupHeaderViewModelType?
}
