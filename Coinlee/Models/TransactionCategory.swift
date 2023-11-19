//
//  TransactionCategory.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 14/08/2023.
//

import Foundation

enum TransactionType {
    case income
    case expense
}

struct TransactionCategory: Hashable {
    var title: String
    var categoryGroup: Icon.TranasctionCategoryGroup
    
    static private func allCategories() -> Set<TransactionCategory> {
        var allCategories: Set<TransactionCategory> = []
        
        Icon.TransactionCategory.allCases.forEach { categoryName in
            let categoryGroup: Icon.TranasctionCategoryGroup
            
            switch categoryName {
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
            
            let category = TransactionCategory(title: categoryName.rawValue, categoryGroup: categoryGroup)
            allCategories.insert(category)
        }
        return allCategories
    }
    
    static private func allCategoriesSorted() -> [[TransactionCategory]] {
        let alphabeticallySortedCategoriesArray = allCategories().sorted {
            NSLocalizedString($0.categoryGroup.rawValue, comment: "Category group name") < NSLocalizedString($1.categoryGroup.rawValue, comment: "Category group name")
        }
        var alphabeticallySorted2DArray: [[TransactionCategory]] = [[]]
        var section = 0
        for category in alphabeticallySortedCategoriesArray {
            if alphabeticallySorted2DArray[section].isEmpty || alphabeticallySorted2DArray[section].first?.categoryGroup == category.categoryGroup {
                alphabeticallySorted2DArray[section].append(category)
            } else {
                section += 1
                alphabeticallySorted2DArray.append([])
                alphabeticallySorted2DArray[section].append(category)
            }
        }
        return alphabeticallySorted2DArray
    }
    
    static func categories(ofType type: TransactionType) -> [[TransactionCategory]] {
        var categories = allCategoriesSorted()
        categories.removeAll { categoryGroup in
            if type == .income {
                return categoryGroup.first?.categoryGroup != .income
            } else {
                return categoryGroup.first?.categoryGroup == .income
            }
        }
        return categories
    }
}
