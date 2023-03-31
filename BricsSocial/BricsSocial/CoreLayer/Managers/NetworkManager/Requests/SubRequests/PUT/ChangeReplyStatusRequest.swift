//
//  ChangeReplyStatusRequest.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 30.03.2023.
//

import Foundation

final class ChangeReplyStatusRequest: BaseRequest {
    
    // Private
    private let replyId: Int
    private let status: ReplyStatus
    
    // MARK: - Initialization
    
    init(replyId: Int,
         status: ReplyStatus) {
        self.replyId = replyId
        self.status = status
    }

    // MARK: - BaseRequest
    
    override var query: String {
        return "/specialists/replies/\(replyId)"
    }
    
    override var requestType: HTTPRequestMethod {
        return .PUT
    }

    override var bodyParameters: [String : Any] {
        return [
            "id": replyId,
            "status": status.rawValue                  as Any
        ]
    }
}
