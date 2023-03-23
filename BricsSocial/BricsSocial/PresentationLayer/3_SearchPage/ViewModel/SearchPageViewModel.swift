//
//  SearchPageViewModel.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 22.03.2023.
//

import SwiftUI

final class SearchPageViewModel: ObservableObject {
    
    @Published var fetchedCompanies: [Company] = []
    @Published var displayingCompanies: [Company]?
    
    init() {
        fetchedCompanies = [
           Company(id: 1,
                   name: "Tinkoff",
                   description: "Financial ecosystem offers a full range of financial and lifestyle services for individuals and businesses via its mobile app and web interface. At the core of the ecosystem is Tinkoff Bank, one of the world’s biggest online banks with over 20 million customers.",
                   logo: "https://telekomdom.com/wp-content/uploads/2022/08/tinkoff-id--1024x572.png",
                   countryId: 1)
        ]
        
        displayingCompanies = fetchedCompanies
    }
    
    func getIndex(company: Company) -> Int {
        let index = displayingCompanies?.firstIndex(where: { currentCompany in
            return company.id == currentCompany.id
        }) ?? 0
        
        return index
    }
}
