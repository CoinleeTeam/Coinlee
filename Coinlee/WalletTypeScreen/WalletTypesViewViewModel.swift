//
//  WalletTypesViewViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 22/10/2023.
//

import Foundation

final class WalletTypesViewViewModel: WalletTypesViewViewModelType {
    let walletTypes = WalletType.allCases
    var selectedType: WalletType?
    
    // MARK: - Init
    init(selectedType: WalletType?) {
        self.selectedType = selectedType
    }
    
    // MARK: - UICollectionViewDataSource data
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems() -> Int {
        return walletTypes.count
    }
    
    // MARK: ViewModels
    func walletTypeCellViewModel(forIndexPath indexPath: IndexPath) -> BorderFreeCellViewModelType? {
        let viewModel = BorderFreeCellViewModel(title: walletTypes[indexPath.row].rawValue)
        if let selectedType = selectedType {
            viewModel.isSelected = viewModel.title == selectedType.rawValue
        }
        return viewModel
    }
}
