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

struct AsyncProfilePageView: View {
    
    @StateObject var viewModel: ProfilePageViewModel = ProfilePageViewModel(dataValidationHandler: RootAssembly.serviceAssembly.dataValidationHandler,
                                                                            profileImageHandler: RootAssembly.serviceAssembly.profileImageHandler,
                                                                            inputTextFieldViewModelFactory: InputTextFieldViewModelFactory(dataValidationHandler: RootAssembly.serviceAssembly.dataValidationHandler, specialistInfoService: RootAssembly.serviceAssembly.specialistInfoService),
                                                                            specialistInfoService: RootAssembly.serviceAssembly.specialistInfoService)
    
    var body: some View {
        AsyncContentView(source: viewModel, content: { _ in
            ProfilePageView(viewModel: viewModel)
        })
    }
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
                        GeneralView()
                            .environmentObject(viewModel)
                            .padding(.top, 15)
                    case .professional:
                        SummaryView()
                            .environmentObject(viewModel)
                            .padding(.top, 15)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100)
            }
            .refreshable {
                let error = await RootAssembly.serviceAssembly.specialistInfoService.loadSpecialistInfo()
            }
            .frame(width: UIScreen.main.bounds.width)
            .overlay(
                VStack {
                    Spacer(minLength: geometry.size.height - 50)
                    EditButtonView()
                        .environmentObject(viewModel)
                        .padding(.horizontal)
                }
            )
        }
    }
}
