//
//  VacanciesService.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import Foundation

protocol IVacanciesService {
    
    // Загрузка информации о вакансиях
    func loadFullVacanciesInfo() async
    // Согласиться на вакансию
    func approveVacancy(vacancyId: Int) async -> NetworkError?
    // Информация о компаниях по id
    var companiesById: [Int: Company] { get }
    // Информация о вакансиях
    var vacancies: [Vacancy] { get }
}

final class VacanciesService: IVacanciesService {
    
    // Dependencies
    private let networkHandler: INetworkHandler
    
    // Models
    private var pageNumber: Int?
    
    // MARK: - IVacanciesService

    var companiesById: [Int: Company] = [:]
    var vacancies: [Vacancy] = []
    
    // MARK: - Initialization
    
    init(networkHandler: INetworkHandler) {
        self.networkHandler = networkHandler
    }
    
    func approveVacancy(vacancyId: Int) async -> NetworkError? {
        let request = ApproveVacancyRequest(vacancyId: vacancyId)
        
        return await networkHandler.send(request: request)
    }
    
    func loadFullVacanciesInfo() async {
        vacancies = await loadVacancies()
    
        let companies = await withTaskGroup(of: Optional<Company>.self, returning: [Company].self) { group in
            for companyId in Set(vacancies.map { $0.companyId }).subtracting(companiesById.keys) {
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
    
    private func loadCompanyInfo(companyId: Int) async -> Company? {
        let request = CompanyInfoRequest(companyId: companyId)
        
        if case .success(let model) = await networkHandler.send(request: request, type: Company.self) {
            return model
        } else {
            return nil
        }
    }
    
    private func loadVacancies(status: VacancyStatus = .closed, pageSize: Int = 10) async -> [Vacancy] {
        let pageNumber: Int = self.pageNumber ?? 1
        let request = VacanciesRequest(status: status, pageNumber: pageNumber, pageSize: pageSize)
        
        if case .success(let metaModel) = await networkHandler.send(request: request, type: VacanciesMetaInfo.self) {
            if metaModel.hasNextPage {
                self.pageNumber = pageNumber + 1
            }
            
            return metaModel.items
        } else {
            return []
        }
    }
}
