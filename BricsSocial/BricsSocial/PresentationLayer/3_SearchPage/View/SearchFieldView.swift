//
//  SearchFieldView.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 31.03.2023.
//

import SwiftUI

struct SearchFieldView: View {
    
    @EnvironmentObject var viewModel: SearchPageViewModel
            
    var body: some View {
        HStack {
            Text("BRICS")
                .font(.title.bold())
            Spacer()
            HStack {
                Button(action: {
                    Task {
                        await viewModel.search()
                    }
                }, label: {
                    Image(systemName: "magnifyingglass.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color("LightGrayColor"))
                        .padding(.horizontal, 10)
                    
                })
                TextField("Search something...", text: $viewModel.searchTags)
                    .font(Font.body.weight(.medium))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding(.vertical, 5)
            .background(
                RoundedRectangle(cornerRadius: 20,
                                 style: .continuous)
                    .stroke(Color("LightGrayColor"), lineWidth: 1.2)
            )
        }
        
    }
}
