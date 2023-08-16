//
//  WalletCellHeaderViewViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 16/08/2023.
//

import Foundation

final class WalletCellHeaderViewViewModel: WalletCellHeaderViewViewModelType {
    let walletType: WalletType
    
    init(walletType: WalletType) {
        self.walletType = walletType
    }
}
