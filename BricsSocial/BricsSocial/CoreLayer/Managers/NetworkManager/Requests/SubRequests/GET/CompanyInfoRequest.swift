//
//  CompanyInfoRequest.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import Foundation

final class CompanyInfoRequest: BaseRequest {
    
    // Private
    private let companyId: Int
    
    // MARK: - Initialization
    
    init(companyId: Int) {
        self.companyId = companyId
    }
    
    // MARK: - BaseRequest

    override var query: String {
        return "/companies/\(companyId)"
    }
    
    override var requestType: HTTPRequestMethod {
        return .GET
    }
}
