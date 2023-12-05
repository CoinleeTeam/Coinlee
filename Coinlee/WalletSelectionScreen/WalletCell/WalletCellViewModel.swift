//
//  WalletCellViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 15/08/2023.
//

import Foundation

final class WalletCellViewModel: WalletCellViewModelType {
    let wallet: Wallet
    
    // MARK: Computed properties
    var balanceText: String {
        wallet.balance.accountingFormatted() + CharacterConstants.whitespace + wallet.currency.code
    }
    
    // MARK: - Init
    init(wallet: Wallet) {
        self.wallet = wallet
    }
}
