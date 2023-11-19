//
//  Wallet.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 16/08/2023.
//

import Foundation

struct Wallet {
    var name: String
    var balance: Double
    var currency: String
    var icon: Icon.Wallet
    var type: WalletType
    var isActive: Bool
}