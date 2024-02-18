//
//  BorderFreeCellViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 29/10/2023.
//

import Foundation
import RxSwift

final class BorderFreeCellViewModel: BorderFreeCellViewModelType {
    let title: Observable<String>
    var isSelected: Observable<Bool>
    
    // MARK: - Init
    init(title: String, isSelected: Bool = false) {
        self.title = .just(title)
        self.isSelected = .just(isSelected)
    }
}
