//
//  IconSelectionViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 31/10/2023.
//

import Foundation
import RxSwift

protocol IconSelectionViewModelType: AnyObject {
    var icons: Observable<[WalletIcon]> { get }
    
    func iconCellViewModel(icon: WalletIcon) -> IconCellViewModelType
}
