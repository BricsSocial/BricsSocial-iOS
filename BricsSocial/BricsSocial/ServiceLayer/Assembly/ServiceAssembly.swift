//
//  ServiceAssembly.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

protocol IServiceAssembly {
    // Сущность для валидации введенных данных
    var dataValidationHandler: IDataValidationHandler { get }
    // Сущность для работы с данными пользователя
    var userDataHandler: IUserDataHandler { get }
}

final class ServiceAssembly: IServiceAssembly {
    
    lazy var dataValidationHandler: IDataValidationHandler = DataValidationHandler()
    lazy var userDataHandler: IUserDataHandler = UserDataHandler()
}
