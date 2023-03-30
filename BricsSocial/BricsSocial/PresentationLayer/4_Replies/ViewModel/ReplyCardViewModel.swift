//
//  ReplyCardViewModel.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 30.03.2023.
//

import Foundation

final class ReplyCardViewModel: ObservableObject, Identifiable {
    
    lazy var id: ObjectIdentifier = ObjectIdentifier(self)
    
    // Dependencies
    private let repliesService: IRepliesService
    
    // Dependencies
    @Published var reply: Reply
    @Published var company: Company?
    
    // MARK: - Initialization
    
    init(repliesService: IRepliesService,
         reply: Reply,
         company: Company?) {
        self.repliesService = repliesService
        self.reply = reply
        self.company = company
    }
    
    func acceptReply() async {
        guard let reply = await repliesService.changeReplyStatus(replyId: reply.id, newStatus: .approved)
        else { return }
        
        DispatchQueue.main.async {
            self.reply = reply
        }
    }
    
    func rejectReply() async {
        guard let reply = await repliesService.changeReplyStatus(replyId: reply.id, newStatus: .rejected)
        else { return }
        
        DispatchQueue.main.async {
            self.reply = reply
        }
    }
}
