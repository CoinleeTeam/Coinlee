//
//  IconCellViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 31/10/2023.
//

import Foundation

final class IconCellViewModel: IconCellViewModelType {
    let icon: Icon.Wallet
    
    // MARK: - Init
    init(icon: Icon.Wallet) {
        self.icon = icon
    }
}
