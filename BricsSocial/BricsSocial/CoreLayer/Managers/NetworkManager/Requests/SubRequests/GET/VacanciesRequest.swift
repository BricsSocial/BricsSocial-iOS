//
//  VacanciesRequest.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import Foundation

final class VacanciesRequest: BaseRequest {
        
    // Private
    private let status: VacancyStatus
    private let pageNumber: Int
    private let pageSize: Int
    private let skillTags: String?
    
    // MARK: - Initialization
    
    init(status: VacancyStatus, pageNumber: Int, pageSize: Int, skillTags: String? = nil) {
        self.status = status
        self.pageNumber = pageNumber
        self.pageSize = pageSize
        self.skillTags = skillTags
    }

    // MARK: - BaseRequest
    
    override var queryParameters: [String: Any] {
        var query: [String: Any] = [
            "Status": status.rawValue,
            "PageNumber": pageNumber,
            "PageSize": pageSize,
        ]
        
        if let skillTags = skillTags {
            query["SkillTags"] = skillTags
        }
        
        return query
    }

    override var query: String {
        return "/vacancies?"
    }
    
    override var requestType: HTTPRequestMethod {
        return .GET
    }
}
