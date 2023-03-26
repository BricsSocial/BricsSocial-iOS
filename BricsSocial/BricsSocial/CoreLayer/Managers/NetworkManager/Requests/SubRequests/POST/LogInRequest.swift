//
//  LogInRequest.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

final class LogInRequest: BaseRequest {
    
    // Private
    private let email: String
    private let password: String
    
    // MARK: - Initialization
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }

    // MARK: - BaseRequest

    override var query: String {
        return "/auth/login"
    }
    
    override var requestType: HTTPRequestMethod {
        return .POST
    }
    
    override var bodyParameters: [String : Any] {
        return [
            "email": email,
            "password": password
        ]
    }
}
