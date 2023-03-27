//
//  Vacancy.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import Foundation

struct VacanciesMetaInfo: Decodable {
    let items: [Vacancy]
    let pageNumber: Int
    let totalPages: Int
    let totalCount: Int
    let hasPreviousPage: Bool
    let hasNextPage: Bool
}

struct Vacancy: Codable, Identifiable {
    let id: Int
    let name: String?
    let requirements: String?
    let offerings: String?
    let status: VacancyStatus
    let skillTags: String?
    let companyId: Int
    
    var skills: [Skill] {
        skillTags?.trimmingCharacters(in: .whitespaces).split(separator: ",").map { Skill(name: String($0)) } ?? []
    }
}

struct Skill: Identifiable {
    let id = UUID().uuidString
    let name: String
}

enum VacancyStatus: Int, Codable {
    case closed
    case `open`
}

