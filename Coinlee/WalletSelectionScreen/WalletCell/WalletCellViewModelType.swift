//
//  WalletCellViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 15/08/2023.
//

import Foundation
import RxSwift

protocol WalletCellViewModelType: AnyObject {
    var wallet: Observable<Wallet> { get }
    
    // MARK: - Texts
    func balanceText(forWallet wallet: Wallet) -> String
}
