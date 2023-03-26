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
    // unable to get status code from response
    case badResponse
    // unable to auth
    case unauthorized
    // unable to process request
    case badRequest
    // no access to data
    case forbidden
    // failed to decode data
    case parseFailed
    // unknown error occurried
    case unknownError
    // can't process received status code
    case unexpectedStatusCode
}

protocol INetworkRequestsManager {
    func send<Request: BaseRequest>(request: Request) async -> NetworkError?
    func send<Request: BaseRequest, Model: Decodable>(request: Request, type: Model.Type) async -> Result<Model, NetworkError>
}

final class NetworkRequestsManager: INetworkRequestsManager {
    
    // Dependencies
    private let session: URLSession
    
    // MARK: - Initialization
    
    init(session: URLSession) {
        self.session = session
    }

    // MARK: - INetworkRequestsManager
    
    func send<Request: BaseRequest>(request: Request) async -> NetworkError? {
        guard let urlRequest = request.urlRequest else {
            Logger.shared.log(.error, arguments: "UNABLE TO CREATE URL REQUEST: \(request.url)")
            return .badUrl
        }
        
        do {
            let (_, response) = try await session.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else { return .badResponse }
            
            switch httpResponse.statusCode {
            case 200:
                Logger.shared.log(.success, arguments: "[NETWORK] REQUEST PROCESSED SUCCESSFULLY: \(request.url)")
                return nil
            case 400:
                Logger.shared.log(.error, arguments: "[NETWORK: 400] BAD REQUEST: \(request.url)")
                return .badRequest
            case 401:
                Logger.shared.log(.error, arguments: "[NETWORK: 401] UNAUTHORIZED REQUEST: \(request.url)")
                return .unauthorized
            case 403:
                Logger.shared.log(.error, arguments: "[NETWORK: 403] FORBIDDEN REQUEST: \(request.url)")
                return .forbidden
            default:
                Logger.shared.log(.error, arguments: "[NETWORK: UNEXPECTED] STATUS CODE \(httpResponse.statusCode): \(request.url)")
                return .unexpectedStatusCode
            }
        } catch let error {
            Logger.shared.log(.error, arguments: "[NETWORK] UNKNOWN ERROR: \(error.localizedDescription)")
            return .unknownError
        }
    }

    func send<Request: BaseRequest, Model: Decodable>(request: Request, type: Model.Type) async -> Result<Model, NetworkError> {
        
        guard let urlRequest = request.urlRequest else {
            Logger.shared.log(.error, arguments: "UNABLE TO CREATE URL REQUEST: \(request.url)")
            return .failure(.badUrl)
        }
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else { return .failure(.badResponse) }
            
            switch httpResponse.statusCode {
            case 200:
                guard let model = try? JSONDecoder().decode(type, from: data) else {
                    Logger.shared.log(.warning, arguments: "[NETWORK: 200] FAILED TO PARSE DATA: \(String(decoding: data, as: UTF8.self))")
                    return .failure(.parseFailed)
                }
                Logger.shared.log(.success, arguments: "[NETWORK] REQUEST PROCESSED SUCCESSFULLY: \(request.url)")
                return .success(model)
            case 400:
                Logger.shared.log(.error, arguments: "[NETWORK: 400] BAD REQUEST: \(request.url)")
                return .failure(.badRequest)
            case 401:
                Logger.shared.log(.error, arguments: "[NETWORK: 401] UNAUTHORIZED REQUEST: \(request.url)")
                return .failure(.unauthorized)
            case 403:
                Logger.shared.log(.error, arguments: "[NETWORK: 403] FORBIDDEN REQUEST: \(request.url)")
                return .failure(.forbidden)
            default:
                Logger.shared.log(.error, arguments: "[NETWORK: UNEXPECTED] STATUS CODE \(httpResponse.statusCode): \(request.url)")
                return .failure(.unexpectedStatusCode)
            }
        } catch let error {
            Logger.shared.log(.error, arguments: "[NETWORK] UNKNOWN ERROR: \(error.localizedDescription)")
            return .failure(.unknownError)
        }
    }
}
