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
        self.icon = BehaviorSubject(value: .wallet)
        self.balance = Double()
        self.currency = BehaviorSubject(value: .eur)
        self.walletType = BehaviorSubject(value: .none)
    }
}
