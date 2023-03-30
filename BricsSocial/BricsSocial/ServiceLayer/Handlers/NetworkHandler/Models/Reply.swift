//
//  Reply.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import Foundation

struct ReplyMetaInfo: Decodable {
    let items: [Reply]
    let pageNumber: Int
    let totalPages: Int
    let hasPreviousPage: Bool
    let hasNextPage: Bool
}

struct Agent: Decodable {
    let id: Int
    let email: String?
    let firstName: String?
    let lastName: String?
    let position: String?
    let photo: String?
    let companyId: Int
}

struct Reply: Decodable {
    let id: Int
    let agent: Agent?
    let vacancy: Vacancy
    let status: ReplyStatus
    let type: ReplyType
}

enum ReplyType: Int, Codable {
    // Отклик на специалиста - можем поменять статус ( vacancy/reply )
    case specialist
    // Отклик на вакансию специалистом
    case vacancy
}
