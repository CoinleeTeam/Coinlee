//
//  IconCellViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 31/10/2023.
//

import Foundation

final class IconCellViewModel: IconCellViewModelType {
    let icon: WalletIcon
    
    // MARK: - Init
    init(icon: WalletIcon) {
        self.icon = icon
    }
}
