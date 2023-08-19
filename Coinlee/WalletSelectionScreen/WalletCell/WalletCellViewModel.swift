//
//  WalletCellViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 15/08/2023.
//

import Foundation

final class WalletCellViewModel: WalletCellViewModelType {
    let headerTitle: String
    let iconImageName: String
    let wallet: Wallet
    
    init(wallet: Wallet) {
        self.wallet = wallet
        self.headerTitle = wallet.name
        self.iconImageName = wallet.icon.rawValue
    }
}
