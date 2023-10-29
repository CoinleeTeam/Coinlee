//
//  WalletTypesViewViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 22/10/2023.
//

import Foundation

protocol WalletTypesViewViewModelType: AnyObject {
    var walletTypes: [WalletType] { get }
    
    func numberOfSections() -> Int
    func numberOfItems() -> Int
    func walletTypeCellViewModel(forIndexPath indexPath: IndexPath) -> BorderFreeCellViewModelType?
}
