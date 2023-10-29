//
//  BorderFreeCellViewModel.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 29/10/2023.
//

import Foundation

final class BorderFreeCellViewModel: BorderFreeCellViewModelType {
    let title: String
    var isSelected: Bool
    
    // MARK: - Init
    init(title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
}
