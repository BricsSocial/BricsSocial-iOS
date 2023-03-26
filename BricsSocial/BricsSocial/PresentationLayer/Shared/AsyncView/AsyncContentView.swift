//
//  AsyncContentView.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 23.03.2023.
//

import SwiftUI

protocol LoadableObject: ObservableObject {
    var state: LoadingState { get }
    func load() async
}

enum LoadingState {
    case loading
    case loaded
    case failed(Error)
}

struct AsyncContentView<Source: LoadableObject,
                        LoadingView: View,
                        Content: View>: View {
    @ObservedObject var source: Source
    var loadingView: LoadingView
    var content: () -> Content

    init(source: Source,
         loadingView: LoadingView,
         @ViewBuilder content: @escaping () -> Content) {
        self.source = source
        self.loadingView = loadingView
        self.content = content
    }

    var body: some View {
        switch source.state {
        case .loading:
            loadingView.task { await source.load() }
        case .failed:
            EmptyView()
        case .loaded:
            content()
        }
    }
}

typealias DefaultProgressView = ProgressView<EmptyView, EmptyView>

extension AsyncContentView where LoadingView == DefaultProgressView {
    init(
        source: Source,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(
            source: source,
            loadingView: ProgressView(),
            content: content
        )
    }
}
