//
//  WalletDetailViewModel.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 03/11/2023.
//

import Foundation
import RxSwift

final class WalletDetailViewModel: WalletDetailViewModelType {
    var walletName: String 
    var balance: Double
    let icon: BehaviorSubject<WalletIcon>
    let currency: BehaviorSubject<Currency>
    let walletType: BehaviorSubject<WalletType?>
    
    init() {
        self.walletName = String()
        self.icon = .Observer(value: .wallet)
        self.balance = Double()
        self.currency = .Observer(value: .eur)
        self.walletType = .Observer(value: .none)
    }
}
