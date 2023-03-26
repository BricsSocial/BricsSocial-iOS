//
//  Country.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

enum Country: Int, Codable {
    case brasil = 1
    case russia = 2
    case india = 3
    case china = 4
    case southAfrica = 5
    
    var code: String {
        switch self {
        case .brasil: return "BR"
        case .china: return "CN"
        case .southAfrica: return "ZA"
        case .russia: return "RU"
        case .india: return "IN"
        }
    }
}
