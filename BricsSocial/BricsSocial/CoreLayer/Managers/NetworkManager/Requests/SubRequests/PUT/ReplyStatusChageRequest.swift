//
//  AddReplyRequest.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 25.03.2023.
//

import Foundation
import SwiftUI

enum ReplyStatus: Int, Codable, CaseIterable {
    case pending
    case approved
    case rejected
    
    var raw: String {
        switch self {
        case .pending: return "pending"
        case .approved: return "approved"
        case .rejected: return "rejected"
        }
    }
    
    var color: Color {
        switch self {
        case .pending: return .yellow
        case .approved: return .green
        case .rejected: return .red
        }
    }
}

final class ReplyStatusChageRequest: BaseRequest {
    
    // Private
    private let replyId: Int
    private let status: ReplyStatus
    
    // MARK: - Initialization
    
    init(replyId: Int, status: ReplyStatus) {
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
            "status": status
        ]
    }
}
