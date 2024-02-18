//
//  WalletTypesViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 22/10/2023.
//

import Foundation
import RxSwift

protocol WalletTypesViewModelType: AnyObject {
    var walletTypes: Observable<[WalletType]> { get }
    
    func walletTypeCellViewModel(withWalletType walletType: WalletType, atIndexPath indexPath: IndexPath) -> BorderFreeCellViewModelType
}
