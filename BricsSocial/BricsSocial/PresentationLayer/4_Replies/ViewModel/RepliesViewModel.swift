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

    @Published var approvedReplies: [Reply] = []
    @Published var rejectedReplies: [Reply] = []
    @Published var pendingReplies: [Reply] = []
    
    // MARK: - Initialization
    
    init(repliesService: IRepliesService,
         companiesService: ICompaniesService) {
        self.repliesService = repliesService
        self.companiesService = companiesService
    }
    
    // MARK: - Public
    
    func reloadReplies(of status: ReplyStatus) async {
        await repliesService.reloadReplies(of: status)
        
        DispatchQueue.main.async { [self] in
            switch status {
            case .approved: approvedReplies = repliesService.replies(of: .approved)
            case .pending: pendingReplies = repliesService.replies(of: .pending)
            case .rejected: rejectedReplies = repliesService.replies(of: .rejected)
            }
        }
    }
    
    func reloadAllReplies() async -> NetworkError? {
        if let error = await repliesService.reloadAllReplies() {
            return error
        }
        
        DispatchQueue.main.async { [self] in
            approvedReplies = repliesService.replies(of: .approved)
            pendingReplies = repliesService.replies(of: .pending)
            rejectedReplies = repliesService.replies(of: .rejected)
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
