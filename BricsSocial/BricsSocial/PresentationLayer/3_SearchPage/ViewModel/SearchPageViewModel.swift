//
//  SearchPageViewModel.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 22.03.2023.
//

import SwiftUI

final class SearchPageViewModel: ObservableObject {
    
    // Dependencies
    private let vacanciesService: IVacanciesService
    
    // Observed values
    @Published var state: LoadingState = .loading
    @Published var displayingVacancies: [Vacancy] = []
    
    // MARK: - Initialization
    
    init(vacanciesService: IVacanciesService) {
        self.vacanciesService = vacanciesService
    }
    
    func loadVacancies() async {
        guard displayingVacancies.isEmpty else { return }
        
        await vacanciesService.loadFullVacanciesInfo()
        
        DispatchQueue.main.async {
            self.displayingVacancies = self.vacanciesService.vacancies
        }
    }
    
    func approveVacancy(vacancyId: Int) async -> NetworkError? {
        return await vacanciesService.approveVacancy(vacancyId: vacancyId)
    }
    
    func getIndex(vacancy: Vacancy) -> Int {
        let index = displayingVacancies.firstIndex(where: { currentVacancy in
            return vacancy.id == currentVacancy.id
        }) ?? 0
        return index
    }
    
    func getCompany(vacancy: Vacancy) -> Company? {
        return vacanciesService.companiesById[vacancy.companyId]
    }
}

// MARK: - LoadableObject

extension SearchPageViewModel: LoadableObject {
    
    func load() async {
        await vacanciesService.loadFullVacanciesInfo()
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.state = .loaded
            self.displayingVacancies = self.vacanciesService.vacancies
        }
    }
}
