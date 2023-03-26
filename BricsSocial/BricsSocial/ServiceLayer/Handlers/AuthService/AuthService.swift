//
//  AuthService.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import Foundation

protocol IAuthService {
    // Зарегестрировать специалиста
    func performSignUp(info: SpecialistRegistrationInfo) async -> NetworkError?
    // Войти в аккаунт специалиста
    func performSignIn(email: String, password: String) async -> NetworkError?
}

final class AuthService: IAuthService {
    
    // Dependencies
    private var tokenHandler: ITokenHandler
    private var networkHandler: INetworkHandler
    
    // MARK: - Initialization

    init(tokenHandler: ITokenHandler,
         networkHandler: INetworkHandler) {
        self.tokenHandler = tokenHandler
        self.networkHandler = networkHandler
    }
    
    // MARK: - IAuthService

    func performSignUp(info: SpecialistRegistrationInfo) async -> NetworkError? {
        let request = AddSpecialistRequest(info: info)
        return await networkHandler.send(request: request)
    }
    
    func performSignIn(email: String, password: String) async -> NetworkError? {
        let request = LogInRequest(email: email, password: password)
        let result = await networkHandler.send(request: request, type: Token.self)
        
        switch result {
        case .success(let model):
            tokenHandler.authentificationToken = model.token
            return nil
        case .failure(let failure):
            return failure
        }
    }
}
