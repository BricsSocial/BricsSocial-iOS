//
//  AsyncContentView.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 23.03.2023.
//

import SwiftUI

protocol LoadableObject: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
    func load() async
}

enum LoadingState<Value> {
    case loading
    case failed(Error)
    case loaded(Value)
}

struct AsyncContentView<Source: LoadableObject,
                        LoadingView: View,
                        Content: View>: View {
    @ObservedObject var source: Source
    var loadingView: LoadingView
    var content: (Source.Output) -> Content

    init(source: Source,
         loadingView: LoadingView,
         @ViewBuilder content: @escaping (Source.Output) -> Content) {
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
        case .loaded(let output):
            content(output)
        }
    }
}

typealias DefaultProgressView = ProgressView<EmptyView, EmptyView>

extension AsyncContentView where LoadingView == DefaultProgressView {
    init(
        source: Source,
        @ViewBuilder content: @escaping (Source.Output) -> Content
    ) {
        self.init(
            source: source,
            loadingView: ProgressView(),
            content: content
        )
    }
}
