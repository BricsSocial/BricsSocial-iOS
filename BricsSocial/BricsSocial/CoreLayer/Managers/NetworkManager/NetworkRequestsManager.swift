//
//  NetworkRequestsManager.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 25.03.2023.
//

import Foundation

enum NetworkError: Error {
    // unable to parse URL from string-version
    case badUrl
    // unable to receive session
    case badSession(message: String)
    // unable to parse reeceived data
    case badDataWhileParsing(message: String)
    // ptoblems with session
    case badResponse(message: String)
    // some error http=code
    case badCode(code: Int)
    // unknown error occurried
    case unknownError(message: String)
}

protocol INetworkRequestsManager {
    func send<Request: BaseRequest, Model: Codable>(request: Request, type: Model.Type) async throws -> Model
}

final class NetworkRequestsManager: INetworkRequestsManager {
    
    // Dependencies
    private let session: URLSession
    
    // MARK: - Initialization
    
    init(session: URLSession) {
        self.session = session
    }

    // MARK: - INetworkRequestsManager

    func send<Request: BaseRequest, Model: Codable>(request: Request, type: Model.Type) async throws -> Model {
        guard let urlRequest = request.urlRequest else {
            Logger.shared.log(.error, arguments: "UNABLE TO CREATE URL REQUEST: \(request.url)")
            throw NetworkError.badUrl
        }
        
        let (data, _) = try await session.data(for: urlRequest)
        
        let result = try JSONDecoder().decode(type, from: data)
        
        return result
    }
}
