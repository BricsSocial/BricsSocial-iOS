//
//  RepliesService.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 28.03.2023.
//

import Foundation

protocol IRepliesService {
    // Получить все реплаи для статуса
    func replies(of status: ReplyStatus) -> [Reply]
    // Перезагрузить реплаи конкретного статуса
    func reloadReplies(of status: ReplyStatus) async -> NetworkError?
    // Перезагрузить все реплаи
    func reloadAllReplies() async -> NetworkError?
}

final class RepliesService: IRepliesService {
    
    // Dependencies
    private let networkHandler: INetworkHandler
    private let companiesService: ICompaniesService
    
    // Private
    private var replies: [Reply] = []
    
    // MARK: - Initialization
    
    init(networkHandler: INetworkHandler,
         companiesService: ICompaniesService
    ) {
        self.networkHandler = networkHandler
        self.companiesService = companiesService
    }
    
    // MARK: - IRepliesService
        
    func replies(of status: ReplyStatus) -> [Reply] {
        return replies.filter { $0.status == status }
    }

    func reloadReplies(of status: ReplyStatus) async -> NetworkError? {
        replies.removeAll(where: { $0.status == status })
        
        let request = AllRepliesRequest(status: status, pageNumber: 1)
        switch await networkHandler.send(request: request, type: ReplyMetaInfo.self) {
        case .success(let metaInfo):
            replies.append(contentsOf: metaInfo.items)
            await companiesService.loadCompanies(ids: metaInfo.items.map { $0.vacancy.companyId })
            return nil
        case .failure(let error):
            return error
        }
    }
    
    func reloadAllReplies() async -> NetworkError? {
        let request = AllRepliesRequest()
        switch await networkHandler.send(request: request, type: ReplyMetaInfo.self) {
        case .success(let metaInfo):
            replies = metaInfo.items
            await companiesService.loadCompanies(ids: metaInfo.items.map { $0.vacancy.companyId })
            return nil
        case .failure(let error):
            return error
        }
    }
}
