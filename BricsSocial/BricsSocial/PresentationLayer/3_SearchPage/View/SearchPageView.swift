//
//  SearchPageView.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 22.03.2023.
//

import SwiftUI

struct SearchPageView: View {
    
    @ObservedObject var viewModel: SearchPageViewModel
    
    var body: some View {
        VStack {
            Text("BRICS")
                .font(.title.bold())
            
            ZStack {
                if let companies = viewModel.displayingCompanies {
                    if companies.isEmpty {
                        Text("Come back later we can find more companies for you")
                            .font(.caption)
                            .foregroundColor(.gray)
                    } else {
                        ForEach(companies.reversed()) { company in
                            StackCardView(company: company)
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
            .frame(maxHeight: .infinity)
            
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
            .disabled(viewModel.displayingCompanies?.isEmpty ?? false)
            .opacity((viewModel.displayingCompanies?.isEmpty ?? false) ? 0.6 : 1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    func doSwipe(rightSwipe: Bool = false) {
        guard let first = viewModel.displayingCompanies?.first else { return }
        
        NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"),
                                        object: nil,
                                        userInfo: [
                                            "id": first.id,
                                            "rightSwipe": rightSwipe
        ])
    }
}
