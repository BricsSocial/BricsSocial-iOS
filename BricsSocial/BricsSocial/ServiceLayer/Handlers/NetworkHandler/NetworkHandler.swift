//
//  NetworkHandler.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

private extension String {
    static let token = "eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImExQHlhbmRleC5ydSIsImp0aSI6ImZiNzA3NjkxLTI2Y2UtNDQ2MS1iZTE0LWE2Njk2Nzg5Nzg4YSIsImF1dGhfdGltZSI6IjAzLzI2LzIwMjMgMDk6NDM6NDkiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjNjMmFlMGJiLTBiMzUtNGRiYy05OWQwLWRhNWVkYWNiZmRlOCIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlNwZWNpYWxpc3QiLCJleHAiOjE2ODI0MTU4MjksImlzcyI6ImJyaWNzc29jaWFsIiwiYXVkIjoiYnJpY3Nzb2NpYWwifQ.uoFs36LDSIkBU2cWx5O4mw1fOHXdQ0WAjefKpMTW-90"
}
protocol INetworkHandler {
    // Добавить отклик на вакансию
    func changeReplyStatus(replyId: Int, status: ReplyStatus) async -> NetworkError?
    // Получить отклики
    func receiveReplies() async -> Result<Array<Reply>, NetworkError>
    
    func send<Request: BaseRequest>(request: Request) async -> NetworkError?
    func send<Request: BaseRequest, Model: Decodable>(request: Request, type: Model.Type) async -> Result<Model, NetworkError>
}

final class NetworkHandler: INetworkHandler {
    
    // Dependencies
    private var tokenHandler: ITokenHandler
    private let networkManager: INetworkRequestsManager
    
    // MARK: - Initialization
    
    init(tokenHandler: ITokenHandler,
         networkManager: INetworkRequestsManager) {
        self.tokenHandler = tokenHandler
        self.networkManager = networkManager
    }
    
    // MARK: - INetworkHandler
    
    func changeReplyStatus(replyId: Int, status: ReplyStatus) async -> NetworkError? {
        let request = ReplyStatusChageRequest(replyId: replyId, status: status)
        return await send(request: request)
    }
    
    func receiveReplies() async -> Result<Array<Reply>, NetworkError> {
        let request = AllRepliesRequest()
        return await send(request: request, type: Array<Reply>.self)
    }
    
    func send<Request: BaseRequest>(request: Request) async -> NetworkError? {
        request.headers["Authorization"] = "Bearer \(tokenHandler.authentificationToken)"
        return await networkManager.send(request: request)
    }
    
    func send<Request: BaseRequest, Model: Decodable>(request: Request, type: Model.Type) async -> Result<Model, NetworkError> {
        request.headers["Authorization"] = "Bearer \(tokenHandler.authentificationToken)"
        return await networkManager.send(request: request, type: type)
    }
}
