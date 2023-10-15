//
//  WalletCellViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 15/08/2023.
//

import Foundation

protocol WalletCellViewModelType: AnyObject {
    var wallet: Wallet { get }
    
    // MARK: Computed properties
    var balanceText: String { get }
}
