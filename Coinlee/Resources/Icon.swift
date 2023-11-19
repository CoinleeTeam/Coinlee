//
//  Icons.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 13/08/2023.
//

import Foundation

enum Icon {
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
    }
    
    enum TranasctionCategoryGroup: String {
        case foodDining
        case transportation
        case housing
        case entertainment
        case shoppingPurchases
        case healthFitness
        case travel
        case education
        case family
        case giftsDonations
        case investments
        case income
    }
    
    enum Wallet: String, CaseIterable {
        case bankBuilding
        case billing
        case bitcoinAccepted
        case cardPayment
        case cash
        case coins
        case growingMoney
        case magneticCard
        case moneyBag
        case moneyBox
        case receiveCash
        case safe
        case salesPerformance
        case stackOfMoney
        case wallet
        case cardsWallet
    }
    
    enum Linear: String {
        case account
        case angleLeft
        case angleRight
        case calendar
        case checkMark
        case dollar
        case edit
        case expandAngle
        case home
        case list
        case magnifyingGlass
        case plus
        case report
        case clear
        case walletTemplate
    }
}
