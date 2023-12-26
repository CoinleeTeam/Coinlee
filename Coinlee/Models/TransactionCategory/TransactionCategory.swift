//
//  TransactionCategory.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 14/08/2023.
//

import Foundation
import Differentiator

enum TransactionType {
    case income
    case expense
}

enum TransactionCategory: String, CaseIterable {
    case accomodation
    case billsUtilities
    case birthday
    case books
    case business
    case cafe
    case catering
    case charity
    case children
    case clothing
    case courses
    case electronics
    case entertainmentSubscriptions
    case events
    case flights
    case footwear
    case freelance
    case fuel
    case games
    case groceries
    case healthInsurance
    case hobbies
    case homeGoods
    case interestRate
    case investment
    case maintenance
    case medicalExpenses
    case movies
    case parking
    case personalCare
    case pets
    case pharmacy
    case publicTransport
    case rental
    case rentMortgage
    case repairsMaintenance
    case restaurant
    case salary
    case sales
    case sightseeing
    case specialOccasions
    case sport
    case subscriptions
    case taxi
    case travelInsurance
    case tuition
    case workshop
    
    var categoryGroup: TransactionCategoryGroup {
        let categoryGroup: TransactionCategoryGroup
        switch self {
        case .groceries, .restaurant, .cafe, .catering:
            categoryGroup = .foodDining
        case .taxi, .publicTransport, .fuel, .maintenance, .parking:
            categoryGroup = .transportation
        case .rentMortgage, .billsUtilities, .repairsMaintenance, .homeGoods:
            categoryGroup = .housing
        case .movies, .games, .entertainmentSubscriptions, .events, .hobbies:
            categoryGroup = .entertainment
        case .clothing, .footwear, .electronics, .personalCare, .subscriptions:
            categoryGroup = .shoppingPurchases
        case .medicalExpenses, .sport, .pharmacy, .healthInsurance:
            categoryGroup = .healthFitness
        case .tuition, .books, .courses, .workshop:
            categoryGroup = .education
        case .pets, .children:
            categoryGroup = .family
        case .birthday, .charity, .specialOccasions:
            categoryGroup = .giftsDonations
        case .salary, .freelance, .investment, .rental ,.sales, .business, .interestRate:
            categoryGroup = .income
        case .accomodation, .flights, .sightseeing, .travelInsurance:
            categoryGroup = .travel
        }
        return categoryGroup
    }
    
    var localizedName: String {
        NSLocalizedString(rawValue, comment: "Localized category name")
    }
    
    static private func allCategoriesSorted() -> [SectionOfTransactionCategory] {
        let alphabeticallySortedCategoriesArray = TransactionCategory.allCases.sorted {
            NSLocalizedString($0.categoryGroup.rawValue, comment: "Category group name") < NSLocalizedString($1.categoryGroup.rawValue, comment: "Category group name")
        }
        var alphabeticallySorted2DArray = [SectionOfTransactionCategory(items: [])]
        var section = 0
        for category in alphabeticallySortedCategoriesArray {
            if alphabeticallySorted2DArray[section].items.isEmpty || alphabeticallySorted2DArray[section].items.first?.categoryGroup == category.categoryGroup {
                alphabeticallySorted2DArray[section].items.append(category)
            } else {
                section += 1
                alphabeticallySorted2DArray.append(SectionOfTransactionCategory(items: .init()))
                alphabeticallySorted2DArray[section].items.append(category)
            }
        }
        return alphabeticallySorted2DArray
    }
    
    static func categories(ofType type: TransactionType) -> [SectionOfTransactionCategory] {
        var categories = allCategoriesSorted()
        categories.removeAll { categoryGroup in
            if type == .income {
                return categoryGroup.items.first?.categoryGroup != .income
            } else {
                return categoryGroup.items.first?.categoryGroup == .income
            }
        }
        return categories
    }
}

struct SectionOfTransactionCategory {
    var items: [Item]
}

extension SectionOfTransactionCategory: SectionModelType {
    typealias Item = TransactionCategory

    init(original: SectionOfTransactionCategory, items: [Item]) {
        self = original
        self.items = items
    }
}
