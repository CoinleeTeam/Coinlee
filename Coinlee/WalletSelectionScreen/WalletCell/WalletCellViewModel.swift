//
//  WalletCellViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 15/08/2023.
//

import Foundation
import RxSwift

final class WalletCellViewModel: WalletCellViewModelType {
    let wallet: Observable<Wallet>
    
    // MARK: - Init
    init(wallet: Wallet) {
        self.wallet = .just(wallet)
    }
    
    // MARK: - Texts
    func balanceText(forWallet wallet: Wallet) -> String {
        wallet.balance.accountingFormatted() + CharacterConstants.whitespace + wallet.currency.code
    }
}
