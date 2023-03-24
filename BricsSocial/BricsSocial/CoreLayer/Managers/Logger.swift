//
//  Logger.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 23.03.2023.
//

import Foundation

extension String {
    static let space = ": "
}

protocol ILogger {
    func log(_ type: MessageType, arguments: String...)
}

enum MessageType: String {
    case error = "⛔️[ERROR]"
    case success = "✅[SUCCESS]"
    case warning = "⚠️[WARNING]"
}

final class Logger: ILogger {
    
    public static let shared: ILogger = Logger()
    
    // MARK: - Initialization

    private init() {}
    
    // MARK: - ILogger
    
    func log(_ type: MessageType, arguments: String...) {
        print(type.rawValue, String.space, arguments.map { $0.capitalized }.joined(separator: "|"))
    }
}
