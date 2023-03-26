//
//  Reply.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import Foundation

struct Reply: Decodable {
    
    let vacancy: Vacancy
    let status: ReplyStatus
    let type: ReplyType
    
    enum CodingKeys: String, CodingKey {
        case items
    }
    
    enum ReplyCodingKeys: String, CodingKey {
        case vacancy
        case status
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let replyContainer = try container.nestedContainer(keyedBy: ReplyCodingKeys.self, forKey: .items)
        
        self.vacancy = try replyContainer.decode(Vacancy.self, forKey: .vacancy)
        self.status = try replyContainer.decode(ReplyStatus.self, forKey: .status)
        self.type = try replyContainer.decode(ReplyType.self, forKey: .type)
    }
}

enum ReplyType: Int, Codable {
    // Отклик на специалиста - можем поменять статус ( vacancy/reply )
    case specialist
    // Отклик на вакансию специалистом
    case vacancy
}
