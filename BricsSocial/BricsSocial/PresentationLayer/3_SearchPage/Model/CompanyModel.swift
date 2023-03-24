//
//  CompanyModel.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 22.03.2023.
//

import Foundation

struct Company: Identifiable {
    
    var id: Int
    var name: String
    var description: String
    var logo: String
    var countryId: Int
}
