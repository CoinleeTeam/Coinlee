//
//  Wallet.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 16/08/2023.
//

import Foundation

enum WalletType: String {
    case cash = "Cash"
    case card = "Credit card"
    case saving = "Saving"
}

struct Wallet {
    var name: String
    var balance: Double
    var icon: Icons.Wallet
    var type: WalletType
    var isActive: Bool
}
