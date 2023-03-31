//
//  CompaniesService.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 28.03.2023.
//

import Foundation

protocol ICompaniesService {
    // Список компаний по id
    var companiesById: [Int: Company] { get }
    // Загрузить компании по id
    func loadCompanies(ids: [Int]) async
}

final class CompaniesService: ICompaniesService {
    
    // Private
    private let networkHandler: INetworkHandler
    
    var companiesById: [Int: Company] = [:]
    
    // MARK: - Initialization
    
    init(networkHandler: INetworkHandler) {
        self.networkHandler = networkHandler
    }
    
    // MARK: - ICompaniesService
    
    func loadCompanies(ids: [Int]) async {
        let companies = await withTaskGroup(of: Optional<Company>.self, returning: [Company].self) { group in
            for companyId in Set(ids).subtracting(companiesById.keys) {
                group.addTask {
                    return await self.loadCompanyInfo(companyId: companyId)
                }
            }
            
            return await group.compactMap { $0 }.reduce(into: [Company]()) { $0.append($1) }
        }
        
        companies.forEach { company in
            companiesById[company.id] = company
        }
    }
    
    // MARK: - Private

    private func loadCompanyInfo(companyId: Int) async -> Company? {
        let request = CompanyInfoRequest(companyId: companyId)
        
        if case .success(let model) = await networkHandler.send(request: request, type: Company.self) {
            return model
        } else {
            return nil
        }
    }
    
}
