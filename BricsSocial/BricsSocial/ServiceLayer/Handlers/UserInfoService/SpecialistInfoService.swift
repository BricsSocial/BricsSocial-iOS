//
//  UserInfoService.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import Foundation

protocol ISpecialistInfoService {
    // Кэшированная информация о специалисте
    var specialist: Specialist? { get }
    // Загрузка инфоомации о специалисте
    func loadSpecialistInfo() async -> NetworkError?
    // Обновление информации о специалисте
    func updateSpecialistInfo(specialist: Specialist) async -> NetworkError?
}

final class SpecialistInfoService: ISpecialistInfoService {
    
    // Dependencies
    private let networkHandler: INetworkHandler
    
    // Public
    private(set) var specialist: Specialist?
    
    // MARK: - Initialization
    
    init(networkHandler: INetworkHandler) {
        self.networkHandler = networkHandler
    }
    
    // MARK: - ISpecialistInfoService

    func loadSpecialistInfo() async -> NetworkError? {
        let request = CurrentSpecialistInfoRequest()
        let result = await networkHandler.send(request: request, type: Specialist.self)
        
        switch result {
        case .success(let specialist):
            self.specialist = specialist
        case .failure(let failure):
            return failure
        }
        
        return nil
    }
    
    func updateSpecialistInfo(specialist: Specialist) async -> NetworkError? {
        let request = UpdateSpecialistInfoRequest(specialist: specialist)
        let result = await networkHandler.send(request: request, type: Specialist.self)
        
        switch result {
        case .success(let specialist):
            self.specialist = specialist
        case .failure(let failure):
            return failure
        }
        
        return nil
    }
}
