//
//  CountryPickerViewModel.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

import SwiftUI

private extension String {
    
    static let phoneNumbersPrefixes: [String: String] = [
        "BR":"55",
        "RU":"7",
        "IN":"91",
        "CN":"86",
        "ZA":"27"
    ]
    static let bricsISO: [String] = [
        "BR", "RU", "IN", "CN", "ZA"
    ]
    static let localeIdentifier: String = "en-US"
}

private extension Locale {
    static let englishLocale = Locale(identifier: String.localeIdentifier)
}

struct CountryModel: Hashable {
    
    let code: String
    let name: String
    let flag: String
    let phoneCode: String
    
    // MARK: - Initialization

    init?(regionCode: String) {
        guard let name = Locale.englishLocale.localizedString(forRegionCode: regionCode),
              let phoneCode = String.phoneNumbersPrefixes[regionCode] else { return nil }
        self.code = regionCode
        self.name = name
        self.flag = regionCode
        self.phoneCode = phoneCode
    }
    
    static let allCountries: [CountryModel] = String.bricsISO.compactMap(CountryModel.init(regionCode:))
}
