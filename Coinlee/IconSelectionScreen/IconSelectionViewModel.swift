//
//  IconSelectionViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 31/10/2023.
//

import Foundation

final class IconSelectionViewModel: IconSelectionViewModelType {
    let icons = WalletIcon.allCases
    
    // MARK: - UICollectionViewDataSource data
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems() -> Int {
        return icons.count
    }
    
    // MARK: ViewModels
    func iconCellViewModel(forIndexPath indexPath: IndexPath) -> IconCellViewModelType? {
        return IconCellViewModel(icon: icons[indexPath.row])
    }
}
