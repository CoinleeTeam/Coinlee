//
//  IconCellViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 31/10/2023.
//

import Foundation
import RxSwift

protocol IconCellViewModelType: AnyObject {
    var icon: Observable<WalletIcon> { get }
}
