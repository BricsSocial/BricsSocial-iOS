//
//  KeyChainManager.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 25.03.2023.
//

import Foundation

// Ошибки при работе с KeyChain
enum KeyChainManagerError: Error {
    case saveError
    case getError(message: String)
    case encodeError
    case decodeError
    case updateError
    case deleteError
}

protocol IKeyChainManager {
    // Сохранить значение в KeyChain
    func save<T: Codable>(_ value: T, metaInfo: KeyChainManager.MetaInfo) throws
    // Обновить значение в KeyChain
    func update<T: Codable>(with value: T, metaInfo: KeyChainManager.MetaInfo) throws
    // Получить значение из KeyChain
    func get<T: Codable>(metaInfo: KeyChainManager.MetaInfo) throws -> T
    // Удалить значение из KeyChain
    func delete(metaInfo: KeyChainManager.MetaInfo) throws
}

final class KeyChainManager {
    
    // Models
    struct MetaInfo {
        // Наименование сущности ( Пр.: `Login` )
        let valueName: String
        // Назначение сущности ( Пр.: `User login` )
        let valueService: String
    }
    
    // MARK: - IKeyChainManager

    func save<T: Codable>(_ value: T, metaInfo: KeyChainManager.MetaInfo) throws {
        guard let data = try? JSONEncoder().encode(value) else { throw KeyChainManagerError.encodeError }
        
        let query = [
            // Encryption enabled
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: metaInfo.valueName,
            kSecAttrService as String: metaInfo.valueService,
            kSecValueData as String: data
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        
        switch status {
            // Successfull operation
        case errSecSuccess: break
            // Duplicate occured
        case errSecDuplicateItem: try update(with: value, metaInfo: metaInfo)
            // Unknown error
        default: throw KeyChainManagerError.saveError
        }
    }
    
    func get<T: Codable>(metaInfo: KeyChainManager.MetaInfo) throws -> T {
        let query: [String: Any] = [
            // Encryption enabled
            kSecClass as String: kSecClassGenericPassword,
            // Unique identifier for a password in KeyChain
            kSecAttrAccount as String: metaInfo.valueName,
            kSecAttrService as String: metaInfo.valueService,
            // Single item expected
            kSecMatchLimit as String: kSecMatchLimitOne,
            // To return all data and attributes for the found value
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        // Search logic with item to store received data
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        // Checking for status of an item
        switch status {
        case errSecItemNotFound: throw KeyChainManagerError.getError(message: "NOT FOUND")
        case errSecSuccess:
            if let existingItem = item as? [String: Any],
               let valueData = existingItem[kSecValueData as String] as? Data,
               let value = try? JSONDecoder().decode(T.self, from: valueData) {
                return value
            } else {
                throw KeyChainManagerError.decodeError
            }
        default: throw KeyChainManagerError.getError(message: "UNKNOWN ERROR")
        }
    }
    
    func update<T: Codable>(with value: T, metaInfo: KeyChainManager.MetaInfo) throws {
        guard let data = try? JSONEncoder().encode(value) else { throw KeyChainManagerError.encodeError }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: metaInfo.valueName,
            kSecAttrService as String: metaInfo.valueService
        ]
        
        // target attributes to change (dictionary for changes)
        let attributes: [String: Any] = [
            kSecValueData as String: data
        ]
        
        // execution of a query
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        
        guard case errSecSuccess = status else {
            throw KeyChainManagerError.updateError
        }
    }
    
    func delete(metaInfo: KeyChainManager.MetaInfo) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: metaInfo.valueName,
            kSecAttrService as String: metaInfo.valueService
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeyChainManagerError.deleteError
        }
    }
}
