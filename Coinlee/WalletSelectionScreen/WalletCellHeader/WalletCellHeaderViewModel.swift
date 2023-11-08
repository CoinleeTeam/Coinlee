//
//  WalletCellHeaderViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 16/08/2023.
//

import Foundation

final class WalletCellHeaderViewModel: WalletCellHeaderViewModelType {
    let walletType: WalletType
    
    init(walletType: WalletType) {
        self.walletType = walletType
    }
}
