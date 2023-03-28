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

struct Reply: Decodable, Identifiable {
    let id = UUID().uuidString
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
