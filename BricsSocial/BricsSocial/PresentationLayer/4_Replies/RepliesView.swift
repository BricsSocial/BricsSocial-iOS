//
//  RepliesView.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 28.03.2023.
//

import SwiftUI

struct AsyncRepliesPageView: View {
    
    @StateObject var viewModel: RepliesViewModel = RepliesViewModel(repliesService: RootAssembly.serviceAssembly.repliesService,
                                                                    companiesService: RootAssembly.serviceAssembly.companiesService)
    
    var body: some View {
        AsyncContentView(source: viewModel, content: {
            RepliesView(viewModel: viewModel)
        })
    }
}


struct RepliesView: View {
    
    @ObservedObject var viewModel: RepliesViewModel
    @State var status: ReplyStatus = .pending
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Text("Replies")
                        .font(.largeTitle.bold())
                    ForEach(viewModel.repliesViewModels) { viewModel in
                        ReplyCardView(viewModel: viewModel)
                    }
                }
            }.refreshable {
                Task { await viewModel.reloadAllReplies() }
            }
        }
    }
}
