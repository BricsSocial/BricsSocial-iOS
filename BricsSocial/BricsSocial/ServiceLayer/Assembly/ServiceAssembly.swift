//
//  ServiceAssembly.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

protocol IServiceAssembly {
    // Сущность для валидации введенных данных
    var dataValidationHandler: IDataValidationHandler { get }
    // Сущность для управления аватаром ползователя
    var profileImageHandler: IProfileImageHandler { get }
    // Сущность для управления сетевыми запрсоами
    var networkHandler: INetworkHandler { get }
    // Сущность для управления токеном доступа
    var tokenHandler: ITokenHandler { get }
    // Сервис для работы с данными о специалисте
    var specialistInfoService: ISpecialistInfoService { get }
    // Сервис для работы с авторизацией пользователя в системе
    var authService: IAuthService { get }
    // Сервис для работы с заявками
    var vacanciesService: IVacanciesService { get }
    // Сервис для работы с компаниями
    var companiesService: ICompaniesService { get }
    // Сервис для работы с заявками
    var repliesService: IRepliesService { get }
}

final class ServiceAssembly: IServiceAssembly {
    
    lazy var dataValidationHandler: IDataValidationHandler = DataValidationHandler()
    lazy var profileImageHandler: IProfileImageHandler = ProfileImageHandler(localFileManager: RootAssembly.coreAssembly.localFileManager, networkHandler: networkHandler)
    lazy var tokenHandler: ITokenHandler = TokenHandler(keyChainManager: RootAssembly.coreAssembly.keyChainManager)
    lazy var networkHandler: INetworkHandler = NetworkHandler(tokenHandler: tokenHandler, networkManager: RootAssembly.coreAssembly.networkRequestsManager)
    
    lazy var specialistInfoService: ISpecialistInfoService = SpecialistInfoService(networkHandler: networkHandler)
    lazy var authService: IAuthService = AuthService(tokenHandler: tokenHandler, networkHandler: networkHandler)
    lazy var vacanciesService: IVacanciesService = VacanciesService(networkHandler: networkHandler, companiesService: companiesService)
    lazy var companiesService: ICompaniesService = CompaniesService(networkHandler: networkHandler)
    lazy var repliesService: IRepliesService = RepliesService(networkHandler: networkHandler, companiesService: companiesService)
}
