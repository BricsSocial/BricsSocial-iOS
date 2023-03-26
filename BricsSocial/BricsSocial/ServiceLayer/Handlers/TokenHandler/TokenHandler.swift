//
//  KeyChainHandler.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

private extension String {
    static let valueName: String = "AuthToken"
    static let serviceName: String = "Authentification"
    static let defaultTokenValue: String = "NONE"
}

protocol ITokenHandler {
    var authentificationToken: String { set get }
}

final class TokenHandler {
    
    // Models
    private static let metaInfo = KeyChainManager.MetaInfo(valueName: String.valueName, valueService: String.serviceName)
    
    // Dependencies
    private let keyChainManager: IKeyChainManager
    
    // MARK: - Initialization
    
    init(keyChainManager: IKeyChainManager) {
        self.keyChainManager = keyChainManager
    }
}

// MARK: - ITokenHandler

extension TokenHandler: ITokenHandler {
    
    var authentificationToken: String {
        get { (try? keyChainManager.get(metaInfo: TokenHandler.metaInfo)) ?? String.defaultTokenValue }
        set { try? keyChainManager.save(newValue, metaInfo: TokenHandler.metaInfo) }
    }
}
