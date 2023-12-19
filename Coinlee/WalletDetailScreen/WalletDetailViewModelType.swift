//
//  WalletDetailViewModelType.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 03/11/2023.
//

import Foundation
import RxSwift

protocol WalletDetailViewModelType: AnyObject {
    var walletName: String { get set }
    var balance: Double { get set }
    var icon: BehaviorSubject<WalletIcon> { get }
    var currency: BehaviorSubject<Currency> { get }
    var walletType: BehaviorSubject<WalletType?> { get }
}
