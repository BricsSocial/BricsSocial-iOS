//
//  URLRequestsBuilder.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 25.03.2023.
//

import Foundation

class BaseRequest {
    // Тип метода запроса
    enum HTTPRequestMethod: String {
           case GET = "GET"
           case POST = "POST"
           case PUT = "PUT"
           case HEAD = "HEAD"
           case DELETE = "DELETE"
           case PATCH = "PATCH"
           case OPTIONS = "OPTIONS"
           case CONNECT = "CONNECT"
           case TRACE = "TRACE"
       }
    
    // Заголовки запроса
    var headers: [String: String] = {
        return [
            "content-type": "application/json"
        ]
    }()
    
    // Основной url для построения запросов
    var baseUrl: String {
        return "http://51.250.86.18"
    }
    
    // Тип запроса
    var requestType: HTTPRequestMethod {
        return .GET
    }
    
    // Корневой префикс любого запроса
    var root: String {
        return "/api"
    }
    
    // Метод запроса
    var query: String {
        return "/"
    }
    
    // Параметры в наименовании запроса
    var queryParameters: [String: Any] {
        return [:]
    }
    
    // Параметры передаваемые с запросом
    var bodyParameters: [String: Any] {
        return [:]
    }
    
    var url: String {
        return [baseUrl, root, query, formattedQueryParameters].joined()
    }
    
    // MARK: - Private

    private var formattedQueryParameters: String {
        queryParameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
    }
}

extension BaseRequest {
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: url) else { return nil }
        
        var request = URLRequest(url: url)
    
        request.httpMethod = requestType.rawValue
        request.allHTTPHeaderFields = headers
        
        if requestType != .GET,
           let httpBody = try? JSONSerialization.data(withJSONObject: self.bodyParameters, options: .prettyPrinted) {
            request.httpBody = httpBody
        }
        
        return request
    }
}
