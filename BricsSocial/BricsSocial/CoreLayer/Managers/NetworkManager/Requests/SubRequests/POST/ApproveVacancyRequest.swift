//
//  ApproveVacancyRequest.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 28.03.2023.
//

import Foundation

final class ApproveVacancyRequest: BaseRequest {
    
    // Models
    private let vacancyId: Int
    
    // MARK: - Initialization
    
    init(vacancyId: Int) {
        self.vacancyId = vacancyId
    }

    // MARK: - BaseRequest

    override var query: String {
        return "/vacancies/replies"
    }
    
    override var requestType: HTTPRequestMethod {
        return .POST
    }
    
    override var bodyParameters: [String : Any] {
        return [
            "vacancyId": vacancyId
        ]
    }
}
