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
            Wallet(name: "Main Card", balance: 150.32999, currency: "PLN", icon: .cardsWallet, type: .debitCard, isActive: true),
            Wallet(name: "Nie Main Card", balance: 1053.0325, currency: "USD", icon: .cardPayment, type: .debitCard, isActive: false),
            Wallet(name: "Voobshe Nie Main Card", balance: 150.32, currency: "EUR", icon: .coins, type: .debitCard, isActive: false)
        ],
        [
            Wallet(name: "Bank", balance: 15340.32, currency: "AUD", icon: .bankBuilding, type: .cash, isActive: false),
            Wallet(name: "Bitoc", balance: 2350.35, currency: "RUB", icon: .bitcoinAccepted, type: .cash, isActive: false)
        ],
        [
            Wallet(name: "Mnogo Casha", balance: 3999.64, currency: "UAH", icon: .stackOfMoney, type: .savingsAccount, isActive: false),
            Wallet(name: "Safe of Money", balance: 7045.87, currency: "GBP", icon: .safe, type: .savingsAccount, isActive: false)
        ]
    ]
    
    // MARK: - UICollectionViewDataSource data
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
        guard let walletType = array[section].first?.type else { return nil }
        return WalletCellHeaderViewViewModel(walletType: walletType)
    }
}
