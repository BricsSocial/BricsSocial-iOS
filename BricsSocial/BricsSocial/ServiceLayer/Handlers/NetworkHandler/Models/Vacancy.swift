//
//  Vacancy.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import Foundation

struct Vacancy: Codable {
    let id: Int
    let name: String?
    let requirements: String?
    let offerings: String?
    let status: VacancyStatus
    let skillTags: String?
}

enum VacancyStatus: Int, Codable {
    case `open` = 1
    case closed = 2
}

