//
//  IconSelectionViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 31/10/2023.
//

import Foundation
import RxSwift

final class IconSelectionViewModel: IconSelectionViewModelType {
    let icons: Observable<[WalletIcon]> = .just(WalletIcon.allCases)
        
    // MARK: ViewModels
    func iconCellViewModel(icon: WalletIcon) -> IconCellViewModelType {
        return IconCellViewModel(icon: icon)
    }
}
