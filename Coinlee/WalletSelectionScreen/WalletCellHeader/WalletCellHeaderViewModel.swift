//
//  WalletCellHeaderViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 16/08/2023.
//

import Foundation
import RxSwift

final class WalletCellHeaderViewModel: WalletCellHeaderViewModelType {
    let walletType: Observable<WalletType>
    
    init(walletType: WalletType) {
        self.walletType = .just(walletType)
    }
}
