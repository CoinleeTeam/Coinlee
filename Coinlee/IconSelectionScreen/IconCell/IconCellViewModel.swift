//
//  IconCellViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 31/10/2023.
//

import Foundation
import RxSwift

final class IconCellViewModel: IconCellViewModelType {
    let icon: Observable<WalletIcon>
    
    // MARK: - Init
    init(icon: WalletIcon) {
        self.icon = .just(icon)
    }
}
