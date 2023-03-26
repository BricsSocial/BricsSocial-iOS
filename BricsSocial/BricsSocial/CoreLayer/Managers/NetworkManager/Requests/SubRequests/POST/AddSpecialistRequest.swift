//
//  AddSpecialistRequest.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import Foundation

struct SpecialistRegistrationInfo: Codable {
    let email: String
    let password: String
    let firstName: String
    let lastName: String
    let countryId: Int
}

final class AddSpecialistRequest: BaseRequest {
    
    // Models
    private let info: SpecialistRegistrationInfo
    
    // MARK: - Initialization
    
    init(info: SpecialistRegistrationInfo) {
        self.info = info
    }

    // MARK: - BaseRequest

    override var query: String {
        return "/specialists"
    }
    
    override var requestType: HTTPRequestMethod {
        return .POST
    }
    
    override var bodyParameters: [String : Any] {
        return [
            "email": info.email,
            "password": info.password,
            "firstName": info.firstName,
            "lastName": info.lastName,
            "countryId": info.countryId
        ]
    }
}
