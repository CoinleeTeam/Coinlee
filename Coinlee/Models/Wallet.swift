//
//  Wallet.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 16/08/2023.
//

import Foundation
import Differentiator

struct Wallet {
    var name: String
    var balance: Double
    var currency: Currency
    var icon: WalletIcon
    var type: WalletType
    var isActive: Bool
}

struct SectionOfWallets {
    var items: [Item]
}

extension SectionOfWallets: SectionModelType {
    typealias Item = Wallet

    init(original: SectionOfWallets, items: [Item]) {
        self = original
        self.items = items
    }
}
