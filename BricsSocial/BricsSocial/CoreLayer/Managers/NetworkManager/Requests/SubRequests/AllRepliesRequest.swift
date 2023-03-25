//
//  AllReplies.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 25.03.2023.
//

import Foundation

final class AllRepliesRequest: BaseRequest {
    
    // MARK: - BaseRequest
    
    override var query: String {
        return "/specialists/replies"
    }
    
    override var requestType: HTTPRequestMethod {
        return .GET
    }
}
