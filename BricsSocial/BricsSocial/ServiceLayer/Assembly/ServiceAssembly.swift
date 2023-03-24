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
    // Сущность для управления аватаром ползователя
    var profileImageHandler: IProfileImageHandler { get }
}

final class ServiceAssembly: IServiceAssembly {
    
    lazy var dataValidationHandler: IDataValidationHandler = DataValidationHandler()
    lazy var userDataHandler: IUserDataHandler = UserDataHandler()
    lazy var profileImageHandler: IProfileImageHandler = ProfileImageHandler(localFileManager: RootAssembly.coreAssembly.localFileManager)
}
