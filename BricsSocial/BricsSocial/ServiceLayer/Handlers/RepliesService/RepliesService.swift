//
//  RepliesService.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 28.03.2023.
//

import Foundation

protocol IRepliesService {
    var replies: [Reply] { get }
    // Перезагрузить все реплаи
    func reloadAllReplies() async -> NetworkError?
    // Изменить статус reply
    func changeReplyStatus(replyId: Int, newStatus: ReplyStatus) async -> Reply?
}

final class RepliesService: IRepliesService {
    
    // Dependencies
    private let networkHandler: INetworkHandler
    private let companiesService: ICompaniesService
    
    // Private
    var replies: [Reply] = []
    
    // MARK: - Initialization
    
    init(networkHandler: INetworkHandler,
         companiesService: ICompaniesService
    ) {
        self.networkHandler = networkHandler
        self.companiesService = companiesService
    }
    
    // MARK: - IRepliesService
    
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
    
    func changeReplyStatus(replyId: Int, newStatus: ReplyStatus) async -> Reply? {
        let request = ChangeReplyStatusRequest(replyId: replyId, status: newStatus)
        
        if case .success(let model) = await networkHandler.send(request: request, type: Reply.self) {
            return model
        } else {
            return nil
        }
    }
}
