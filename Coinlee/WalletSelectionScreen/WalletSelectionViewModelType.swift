//
//  WalletSelectionViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 15/08/2023.
//

import Foundation
import RxSwift

protocol WalletSelectionViewModelType: AnyObject {
    var wallets: BehaviorSubject<[SectionOfWallets]> { get }
    
    func walletCellViewModel(wallet: Wallet) -> WalletCellViewModelType
    func walletCellHeaderViewViewModel(forSection section: Int) -> WalletCellHeaderViewModelType?
}
