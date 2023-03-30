//
//  Country.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import Foundation

private extension Locale {
    static let englishLocale = Locale(identifier: String.localeIdentifier)
}

private extension String {
    static let phoneNumbersPrefixes: [String: String] = [
        "BR":"55",
        "RU":"7",
        "IN":"91",
        "CN":"86",
        "ZA":"27"
    ]
    
    static let localeIdentifier: String = "en-US"
}

enum Country: Int, Codable, CaseIterable, Equatable {
    case brasil = 1
    case russia
    case india
    case china
    case southAfrica

    var code: String {
        switch self {
        case .brasil: return "BR"
        case .china: return "CN"
        case .southAfrica: return "ZA"
        case .russia: return "RU"
        case .india: return "IN"
        }
    }
    
    var name: String {
        return Locale.englishLocale.localizedString(forRegionCode: code) ?? "None"
    }
    
    var phoneCode: String {
        return String.phoneNumbersPrefixes[self.code] ?? "no code available"
    }
}
