//
//  IconSelectionViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 31/10/2023.
//

import Foundation

protocol IconSelectionViewModelType: AnyObject {
    var icons: [Icon.Wallet] { get }
    
    func numberOfSections() -> Int
    func numberOfItems() -> Int
    func iconCellViewModel(forIndexPath indexPath: IndexPath) -> IconCellViewModelType?
}
