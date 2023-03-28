//
//  SearchPageView.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 22.03.2023.
//

import SwiftUI

struct AsyncSearchPageView: View {
    
    @StateObject var viewModel: SearchPageViewModel = SearchPageViewModel(vacanciesService: RootAssembly.serviceAssembly.vacanciesService)
    
    var body: some View {
        AsyncContentView(source: viewModel, content: {
            SearchPageView(viewModel: viewModel)
        })
    }
}

struct SearchPageView: View {
    @ObservedObject var viewModel: SearchPageViewModel
    
    var body: some View {
        GeometryReader() { geometry in
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("BRICS")
                        .font(.title.bold())
                    ZStack {
                        if let vacancies = viewModel.displayingVacancies {
                            if vacancies.isEmpty {
                                Text("Come back later we can find more companies for you")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            } else {
                                ForEach(vacancies.reversed()) { vacancy in
                                    StackCardView(vacancy: vacancy)
                                        .environmentObject(viewModel)
                                }
                            }
                        } else {
                            ProgressView()
                        }
                    }
                    .padding(.vertical)
                    .padding(.top, 30)
                    .padding()
                    .frame(height: geometry.size.height - 150)
                    
                    HStack(spacing: 15) {
                        
                        Button {
                            doSwipe()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                                .padding(13)
                                .background(Color.red)
                                .clipShape(Circle())
                        }
                        
                        Button {
                            doSwipe(rightSwipe: true)
                        } label: {
                            Image(systemName: "checkmark")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                                .padding(13)
                                .background(Color.green)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.bottom)
                    .disabled(viewModel.displayingVacancies.isEmpty)
                    .opacity((viewModel.displayingVacancies.isEmpty) ? 0.6 : 1)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .refreshable {
            Task { await viewModel.loadVacancies() }
        }
    }
    
    func doSwipe(rightSwipe: Bool = false) {
        guard let first = viewModel.displayingVacancies.first else { return }
        
        NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"),
                                        object: nil,
                                        userInfo: [
                                            "id": first.id,
                                            "rightSwipe": rightSwipe
                                        ])
    }
}
