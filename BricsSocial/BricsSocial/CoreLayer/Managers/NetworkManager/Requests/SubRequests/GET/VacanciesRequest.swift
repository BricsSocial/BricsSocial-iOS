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
    
    // MARK: - Initialization
    
    init(status: VacancyStatus, pageNumber: Int, pageSize: Int) {
        self.status = status
        self.pageNumber = pageNumber
        self.pageSize = pageSize
    }

    // MARK: - BaseRequest
    
    override var queryParameters: [String: Any] {
        return [
            "Status": status.rawValue,
            "PageNumber": pageNumber,
            "PageSize": pageSize
        ]
    }

    override var query: String {
        return "/vacancies?"
    }
    
    override var requestType: HTTPRequestMethod {
        return .GET
    }
}
