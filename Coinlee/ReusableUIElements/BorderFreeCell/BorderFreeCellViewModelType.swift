//
//  BorderFreeCellViewModelType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 29/10/2023.
//

import Foundation
import RxSwift

protocol BorderFreeCellViewModelType: AnyObject {
    var title: Observable<String> { get }
    var isSelected: Observable<Bool> { get }
}
