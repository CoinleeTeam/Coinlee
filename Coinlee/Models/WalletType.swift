//
//  WalletType.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 29/10/2023.
//

import Foundation

enum WalletType: String, CaseIterable {
    case cash = "cash_type"
    case creditCard = "credit_card_type"
    case debitCard = "debit_card_type"
    case savingsAccount = "savings_account_type"
    case giftCard = "gift_card_type"
    case emergencyFund = "emergency_fund_type"
    case retirementAccount = "retirement_account_type"
    case investmentAccount = "investment_account_type"
    case businessAccount = "business_account_type"
    case loanAccount = "loan_account_type"
}
