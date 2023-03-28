//
//  NetworkHandler.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

protocol INetworkHandler {
    func send<Request: BaseRequest>(request: Request) async -> NetworkError?
    func send<Request: BaseRequest, Model: Decodable>(request: Request, type: Model.Type) async -> Result<Model, NetworkError>
}

final class NetworkHandler: INetworkHandler {
    
    // Dependencies
    private var tokenHandler: ITokenHandler
    private let networkManager: INetworkRequestsManager
    
    // MARK: - Initialization
    
    init(tokenHandler: ITokenHandler,
         networkManager: INetworkRequestsManager) {
        self.tokenHandler = tokenHandler
        self.networkManager = networkManager
    }
    
    // MARK: - INetworkHandler
    
    func send<Request: BaseRequest>(request: Request) async -> NetworkError? {
        request.headers["Authorization"] = "Bearer \(tokenHandler.authentificationToken)"
        return await networkManager.send(request: request)
    }
    
    func send<Request: BaseRequest, Model: Decodable>(request: Request, type: Model.Type) async -> Result<Model, NetworkError> {
        request.headers["Authorization"] = "Bearer \(tokenHandler.authentificationToken)"
        return await networkManager.send(request: request, type: type)
    }
}
