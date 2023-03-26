//
//  Specialist.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import Foundation

struct Specialist: Codable {
    var id: Int
    var email: String?
    var firstName: String?
    var lastName: String?
    var bio: String?
    var about: String?
    var skillTags: String?
    var photo: String?
    var countryId: Country
}
