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
    var icon: BehaviorSubject<WalletIcon>
    var balance: Double
    var currency: BehaviorSubject<Currency>
    var walletType: BehaviorSubject<WalletType?>
    
    init() {
        self.walletName = String()
        self.icon = .Observer(value: .wallet)
        self.balance = Double()
        self.currency = .Observer(value: .eur)
        self.walletType = .Observer(value: .none)
    }
}
