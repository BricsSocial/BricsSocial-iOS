//
//  RootAssembly.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

final class RootAssembly {
    static var serviceAssembly: IServiceAssembly = ServiceAssembly()
    static var coreAssembly: ICoreAssembly = CoreAssembly()
}
