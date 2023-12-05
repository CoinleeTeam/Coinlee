//
//  CategoryTableViewCellViewModelType.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 15/08/2023.
//

import UIKit

protocol CategoryTableViewCellViewModelType: AnyObject {
    var transactionCategory: TransactionCategory { get }
}
