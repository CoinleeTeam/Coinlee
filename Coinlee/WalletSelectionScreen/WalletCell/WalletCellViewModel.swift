//
//  WalletCellViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 15/08/2023.
//

import Foundation

final class WalletCellViewModel: WalletCellViewModelType {
    let wallet: Wallet
    
    init(wallet: Wallet) {
        self.wallet = wallet
    }
}
