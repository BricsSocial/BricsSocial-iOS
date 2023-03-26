//
//  CurrentSpecialistInfoRequest.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import Foundation

final class CurrentSpecialistInfoRequest: BaseRequest {
    
    // MARK: - BaseRequest
    
    override var query: String {
        return "/specialists/current"
    }
    
    override var requestType: HTTPRequestMethod {
        return .GET
    }
}
