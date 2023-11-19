//
//  CurrencyModel.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 22/08/2023.
//

import Foundation

struct Currency {
    var name: String {
        NSLocalizedString(code.rawValue, comment: "Localized name")
    }
    
    var code: CurrencyCode
    
    static func availableCurrencies() -> [Currency] {
        var availableCurrencies = [Currency]()
        CurrencyCode.allCases.forEach { currencyCode in
            let currency = Currency(code: currencyCode)
            availableCurrencies.append(currency)
        }
        
        return availableCurrencies.sorted { $0.code.rawValue < $1.code.rawValue }
    }
}

enum CurrencyCode: String, CaseIterable {
    case aed = "AED"
    case aud = "AUD"
    case cad = "CAD"
    case chf = "CHF"
    case cny = "CNY"
    case czk = "CZK"
    case dkk = "DKK"
    case eur = "EUR"
    case gbp = "GBP"
    case ils = "ILS"
    case inr = "INR"
    case jpy = "JPY"
    case krw = "KRW"
    case kzt = "KZT"
    case nok = "NOK"
    case pln = "PLN"
    case rub = "RUB"
    case sek = "SEK"
    case `try` = "TRY"
    case uah = "UAH"
    case usd = "USD"
    case zar = "ZAR"
}

