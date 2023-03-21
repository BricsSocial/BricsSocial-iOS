//
//  RootAssembly.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

protocol IRootAssembly {
    
}

final class RootAssembly: IRootAssembly {
    static var serviceAssembly: IServiceAssembly = ServiceAssembly()
}
