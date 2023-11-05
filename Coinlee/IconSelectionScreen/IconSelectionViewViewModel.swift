//
//  IconSelectionViewViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 31/10/2023.
//

import Foundation

final class IconSelectionViewViewModel: IconSelectionViewViewModelType {
    let icons = Icon.Wallet.allCases
    
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