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
    // Информация о вакансиях
    var vacancies: [Vacancy] { get }
}

final class VacanciesService: IVacanciesService {
    
    // Dependencies
    private let networkHandler: INetworkHandler
    private let companiesService: ICompaniesService
    
    // Models
    private var pageNumber: Int = 1
    private var hasNextPage: Bool = true
    
    // MARK: - IVacanciesService

    var vacancies: [Vacancy] = []
    
    // MARK: - Initialization
    
    init(networkHandler: INetworkHandler,
         companiesService: ICompaniesService) {
        self.networkHandler = networkHandler
        self.companiesService = companiesService
    }
    
    func approveVacancy(vacancyId: Int) async -> NetworkError? {
        let request = ApproveVacancyRequest(vacancyId: vacancyId)
        
        return await networkHandler.send(request: request)
    }
    
    func loadFullVacanciesInfo() async {
        vacancies = await loadVacancies()
        await companiesService.loadCompanies(ids: vacancies.map { $0.companyId })
    }
    
    // MARK: - Private
    
    private func loadVacancies(status: VacancyStatus = .open, pageSize: Int = 10) async -> [Vacancy] {
        guard hasNextPage else { return [] }
        
        let pageNumber: Int = self.pageNumber
        let request = VacanciesRequest(status: status, pageNumber: pageNumber, pageSize: pageSize)
        
        if case .success(let metaModel) = await networkHandler.send(request: request, type: VacanciesMetaInfo.self) {
            self.hasNextPage = metaModel.hasNextPage
            self.pageNumber = metaModel.pageNumber
            
            return metaModel.items
        } else {
            return []
        }
    }
}
