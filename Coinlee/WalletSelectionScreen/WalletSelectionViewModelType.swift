//
//  WalletSelectionViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 15/08/2023.
//

import Foundation

protocol WalletSelectionViewModelType: AnyObject {
    func numberOfSections() -> Int
    func numberOfWallets(inSection section: Int) -> Int
    func walletCellViewModel(at indexPath: IndexPath) -> WalletCellViewModelType?
    func walletCellHeaderViewViewModel(forSection section: Int) -> WalletCellHeaderViewModelType?
}
