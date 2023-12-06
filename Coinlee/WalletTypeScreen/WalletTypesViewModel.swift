//
//  WalletTypesViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 22/10/2023.
//

import Foundation
import RxSwift

final class WalletTypesViewModel: WalletTypesViewModelType {
    let walletTypes: Observable<[WalletType]>
    var selectedType: WalletType?
    
    // MARK: - Init
    init(selectedType: WalletType?) {
        walletTypes = .just(WalletType.allCases)
        self.selectedType = selectedType
    }
    
    // MARK: ViewModels
    func walletTypeCellViewModel(withWalletType walletType: WalletType, atIndexPath indexPath: IndexPath) -> BorderFreeCellViewModelType {
        let viewModel: BorderFreeCellViewModelType
        if let selectedType = selectedType {
            viewModel = BorderFreeCellViewModel(title: walletType.localizedTitle,
                                                isSelected: walletType.localizedTitle == selectedType.localizedTitle)
        } else {
            viewModel = BorderFreeCellViewModel(title: walletType.localizedTitle)
        }
        return viewModel
    }
}
