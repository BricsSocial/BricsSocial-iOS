//
//  CoreAssembly.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 23.03.2023.
//

import Foundation

protocol ICoreAssembly {
    var logger: ILogger { get }
    var localFileManager: ILocalFileManager { get }
    var networkRequestsManager: INetworkRequestsManager { get }
    var keyChainManager: IKeyChainManager { get }
}

final class CoreAssembly: ICoreAssembly {
    
    // MARK: - ICoreAssembly

    lazy var logger: ILogger = Logger.shared
    lazy var localFileManager: ILocalFileManager = LocalFileManager()
    lazy var networkRequestsManager: INetworkRequestsManager = NetworkRequestsManager(session: URLSession.shared)
    lazy var keyChainManager: IKeyChainManager = KeyChainManager(logger: logger)
}
