//
//  AllReplies.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 25.03.2023.
//

import Foundation

// Получение всех типов предложений по специалисту
final class AllRepliesRequest: BaseRequest {
    
    // Private
    private let status: ReplyStatus?
    private let pageNumber: Int
    
    // MARK: - Initialization
    
    init(status: ReplyStatus? = nil, pageNumber: Int = 1) {
        self.status = status
        self.pageNumber = pageNumber
    }

    // MARK: - BaseRequest
    
    override var query: String {
        return "/specialists/replies?"
    }
    
    override var requestType: HTTPRequestMethod {
        return .GET
    }
    
    override var queryParameters: [String : Any] {
        var parameters: [String: Any] = [
            "PageNumber": pageNumber
        ]
        if let status = status {
            parameters["Status"] = status.rawValue
        }
        return parameters
    }
}
