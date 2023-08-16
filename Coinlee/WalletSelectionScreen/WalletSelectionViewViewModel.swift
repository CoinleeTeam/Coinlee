//
//  WalletSelectionViewViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 15/08/2023.
//

import Foundation

final class WalletSelectionViewViewModel: WalletSelectionViewViewModelType {
    let array = [
        [
            Wallet(name: "Main Card", balance: 150.32, icon: .cardsWallet, type: .card, isActive: true),
            Wallet(name: "Nie Main Card", balance: 1053.00, icon: .cardPayment, type: .card, isActive: false),
            Wallet(name: "Voobshe Nie Main Card", balance: 150.32, icon: .coins, type: .card, isActive: false)
        ],
        [
            Wallet(name: "Bank", balance: 15340.32, icon: .bankBuilding, type: .cash, isActive: false),
            Wallet(name: "Bitoc", balance: 2350.35, icon: .bitcoinAccepted, type: .cash, isActive: false)
        ],
        [
            Wallet(name: "Mnogo Casha", balance: 3999.64, icon: .stackOfMoney, type: .saving, isActive: false),
            Wallet(name: "Safe of Money", balance: 7045.87, icon: .safe, type: .saving, isActive: false)
        ]
    ]
    
    // MARK: UICollectionViewDataSource data
    func numberOfSections() -> Int {
        return array.count
    }
    
    func numberOfWallets(inSection section: Int) -> Int {
        return array[section].count
    }
    
    // MARK: ViewModels
    func walletCellViewModel(at indexPath: IndexPath) -> WalletCellViewModelType? {
        return WalletCellViewModel(wallet: array[indexPath.section][indexPath.row])
    }
    
    func walletCellHeaderViewViewModel(forSection section: Int) -> WalletCellHeaderViewViewModelType? {
        return WalletCellHeaderViewViewModel(walletType: array[section].first!.type)
    }
}
