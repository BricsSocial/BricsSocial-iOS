//
//  ProfilePageView.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 11.03.2023.
//

import SwiftUI

enum ProfileSection : String, CaseIterable {
    case general = "General"
    case professional = "Summary"
}

struct ProfilePageView: View {

    // States
    @State var segmentationSelection : ProfileSection = .general
        
    @ObservedObject var viewModel: ProfilePageViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    ProfilePageHeaderView(viewModel: viewModel)
                        .padding(.bottom, 10)
                    
                    Picker("", selection: $segmentationSelection) {
                        ForEach(ProfileSection.allCases, id: \.self) { option in
                            Text(option.rawValue)
                                .bold()
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    switch segmentationSelection {
                    case .general:
                        GeneralInfoView(isEditing: $viewModel.isEditing,
                                        viewModel: viewModel.infoViewModel)
                            .padding(.top, 15)
                    case .professional:
                        GeneralTagsView(isEditing: $viewModel.isEditing,
                                        viewModel: viewModel.tagsViewModel)
                            .padding(.top, 15)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100)
            }
            .frame(width: UIScreen.main.bounds.width)
            .overlay(
                VStack {
                    Spacer(minLength: geometry.size.height - 50)
                    EditButtonView(viewModel: viewModel)
                        .padding(.horizontal)
                }
            )
        }
    }
}
