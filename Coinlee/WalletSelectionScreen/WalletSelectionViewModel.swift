//
//  WalletSelectionViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 15/08/2023.
//

import Foundation
import RxSwift

final class WalletSelectionViewModel: WalletSelectionViewModelType {
    let wallets: BehaviorSubject<[SectionOfWallets]>
    
    private let fetchedWallets: [[Wallet]] = [
        [
            Wallet(name: "Main Card", balance: 150.32999, currency: .pln, icon: .cardsWallet, type: .debitCard, isActive: true),
            Wallet(name: "Nie Main Card", balance: 1053.0325, currency: .usd, icon: .cardPayment, type: .debitCard, isActive: false),
            Wallet(name: "Voobshe Nie Main Card", balance: 150.32, currency: .eur, icon: .coins, type: .debitCard, isActive: false)
        ],
        [
            Wallet(name: "Bank", balance: 15340.001, currency: .aud, icon: .bankBuilding, type: .cash, isActive: false),
            Wallet(name: "Bitoc", balance: 2350.35, currency: .rub, icon: .bitcoinAccepted, type: .cash, isActive: false)
        ],
        [
            Wallet(name: "Mnogo Casha", balance: 3999.64, currency: .uah, icon: .stackOfMoney, type: .savingsAccount, isActive: false),
            Wallet(name: "Safe of Money", balance: 7045.87, currency: .gbp, icon: .safe, type: .savingsAccount, isActive: false)
        ]
    ]
    
    init() {
        self.wallets = .Observer(value: .init())
        // <<<<<<<<<<<<<<<<<<<<<<< TO BE DELETED ----------------------------------------
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            var wallets: [SectionOfWallets] = []
            self.fetchedWallets.forEach { groupedWallets in
                let walletSection = SectionOfWallets(items: groupedWallets)
                wallets.append(walletSection)
            }
            
            self.wallets.onNext(wallets)
        }
        // ------------------------ TO BE DELETED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>    }
    }
    
    // MARK: ViewModels
    func walletCellViewModel(wallet: Wallet) -> WalletCellViewModelType {
        return WalletCellViewModel(wallet: wallet)
    }
    
    func walletCellHeaderViewViewModel(forSection section: Int) -> WalletCellHeaderViewModelType? {
        guard let walletType = try? wallets.value()[section].items.first?.type else { return nil }
        return WalletCellHeaderViewModel(walletType: walletType)
    }
}
