//
//  WalletCellViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 15/08/2023.
//

import Foundation

protocol WalletCellViewModelType: CornerRoundedCellViewModelType {
    var wallet: Wallet { get }
}
