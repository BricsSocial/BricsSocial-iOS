//
//  CoreAssembly.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 23.03.2023.
//

protocol ICoreAssembly {
    var logger: ILogger { get }
    var localFileManager: ILocalFileManager { get }
}

final class CoreAssembly: ICoreAssembly {
    
    // MARK: - ICoreAssembly

    lazy var logger: ILogger = Logger.shared
    lazy var localFileManager: ILocalFileManager = LocalFileManager()
}
