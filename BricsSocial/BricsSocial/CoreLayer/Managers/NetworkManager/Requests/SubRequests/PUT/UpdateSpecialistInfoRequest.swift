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
            "firstName": specialist.firstName,
            "lastName": specialist.lastName,
            "bio": specialist.bio,
            "about": specialist.about,
            "skillTags": specialist.skillTags,
            "photo": specialist.photo
        ].compactMapValues { $0 }
    }
}
