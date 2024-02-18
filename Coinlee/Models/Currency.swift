//
//  CurrencyModel.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 22/08/2023.
//

import Foundation

enum Currency: String, CaseIterable {
    case aed
    case aud
    case cad
    case chf
    case cny
    case czk
    case dkk
    case eur
    case gbp
    case ils
    case inr
    case jpy
    case krw
    case kzt
    case nok
    case pln
    case rub
    case sek
    case `try`
    case uah
    case usd
    case zar
    
    var code: String {
        rawValue.uppercased()
    }
    
    var localizedName: String {
        NSLocalizedString(code, comment: "Localized name")
    }
    
    static func availableCurrenciesSorted() -> [Currency] {
        return allCases.sorted { $0.code < $1.code }
    }
}

