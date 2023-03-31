//
//  RepliesViewModel.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 28.03.2023.
//

import Foundation

final class RepliesViewModel: ObservableObject {
    
    // Private
    private let repliesService: IRepliesService
    private let companiesService: ICompaniesService
    
    // Observed values
    @Published var state: LoadingState = .loading

    @Published var repliesViewModels: [ReplyCardViewModel] = []
    
    // MARK: - Initialization
    
    init(repliesService: IRepliesService,
         companiesService: ICompaniesService) {
        self.repliesService = repliesService
        self.companiesService = companiesService
    }
    
    // MARK: - Public
    
    func reloadAllReplies() async -> NetworkError? {
        if let error = await repliesService.reloadAllReplies() {
            return error
        }
        
        DispatchQueue.main.async { [self] in
            repliesViewModels = repliesService.replies.map { reply in
                ReplyCardViewModel(repliesService: repliesService,
                                   reply: reply,
                                   company: companiesService.companiesById[reply.vacancy.companyId])
            }
        }
        
        return nil
    }
    
    func companyForId(_ id: Int) -> Company? {
        companiesService.companiesById[id] 
    }
}

// MARK: - LoadableObject

extension RepliesViewModel: LoadableObject {
    
    func load() async {
        guard let error = await reloadAllReplies() else {
            DispatchQueue.main.async { [self] in
                self.state = .loaded
            }
            return
        }
        DispatchQueue.main.async { [self] in
            state = .failed(error)
        }
    }
}
