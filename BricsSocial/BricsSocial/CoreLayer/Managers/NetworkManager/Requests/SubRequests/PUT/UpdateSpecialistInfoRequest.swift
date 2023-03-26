//
//  UpdateSpecialistInfoRequest.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import Foundation

final class UpdateSpecialistInfoRequest: BaseRequest {

    // Private
    private let specialist: Specialist
    
    // MARK: - Initialization
    
    init(specialist: Specialist) {
        self.specialist = specialist
    }

    // MARK: - BaseRequest

    override var query: String {
        return "/specialists/\(specialist.id)"
    }
    
    override var requestType: HTTPRequestMethod {
        return .PUT
    }
    
    override var bodyParameters: [String : Any] {
        return [
            "id": specialist.id,
            "firstName": specialist.firstName          as Any,
            "lastName": specialist.lastName            as Any,
            "bio": specialist.bio                      as Any,
            "about": specialist.about                  as Any,
            "skillTags": specialist.skillTags          as Any,
            "photo": specialist.photo                  as Any
        ].compactMapValues { $0 }
    }
}
