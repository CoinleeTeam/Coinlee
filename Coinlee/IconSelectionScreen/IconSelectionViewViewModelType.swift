//
//  IconSelectionViewViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 31/10/2023.
//

import Foundation

protocol IconSelectionViewViewModelType: AnyObject {
    var icons: [Icon.Wallet] { get }
    
    func numberOfSections() -> Int
    func numberOfItems() -> Int
    func iconCellViewModel(forIndexPath indexPath: IndexPath) -> IconCellViewModelType?
}
