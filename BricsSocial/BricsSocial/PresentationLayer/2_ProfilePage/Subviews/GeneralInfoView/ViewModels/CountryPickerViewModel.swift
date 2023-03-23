//
//  CountryPickerViewModel.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

import SwiftUI

private extension String {
    static let phoneNumbersPrefixes: [String: String] = ["BR":"55", "RU":"7", "IN":"91", "CN":"86", "ZA":"27"]
    static let localeIdentifier: String = "en-US"
    static let bricsISO: [String] = ["BR", "RU", "IN", "CN", "ZA"]
}

struct Country: Hashable {
    let code: String
    let name: String
    let flag: String
    let phoneCode: String
}

final class CountryPickerViewModel: ObservableObject {
    
    // Constants
    private static let locale = Locale(identifier: String.localeIdentifier)
    
    // States
    @Published var country: Country
    
    init(countryCode: String) {
        guard
            let name = CountryPickerViewModel.locale.localizedString(forRegionCode: countryCode),
            let phone = String.phoneNumbersPrefixes[countryCode] else {
            fatalError("Country code doesn't exist")
        }
        
        self.country = Country(code: countryCode, name: name, flag: countryCode, phoneCode: "(+\(phone))")
    }
    
    static var countries: [Country] {
        String.bricsISO
            .compactMap { regionCode in
                guard let name = CountryPickerViewModel.locale.localizedString(forRegionCode: regionCode),
                      let phone = String.phoneNumbersPrefixes[regionCode] else { return nil }
                return Country(code: regionCode, name: name, flag: regionCode, phoneCode: "(+\(phone))")
            }
    }
    
}
