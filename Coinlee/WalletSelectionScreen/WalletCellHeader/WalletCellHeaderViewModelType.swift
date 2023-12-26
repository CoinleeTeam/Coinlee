//
//  WalletCellHeaderViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 16/08/2023.
//

import Foundation
import RxSwift

protocol WalletCellHeaderViewModelType: AnyObject {
    var walletType: Observable<WalletType> { get }
}
