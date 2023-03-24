//
//  SummaryView.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

import SwiftUI

struct SummaryView: View {
    
    @EnvironmentObject var viewModel: ProfilePageViewModel

    var body: some View {
        VStack(spacing: 20) {
            InputTextFieldView(viewModel: viewModel.textFieldViewModel(.bio),
                               textFieldText: $viewModel.bioFieldText,
                               isEditable: $viewModel.isEditing)
            DescriptionTextEditorView(descriptionText: $viewModel.descriptionText,
                                      isEditable: $viewModel.isEditing)
            .frame(idealHeight: 200)
            HStack(alignment: .center, spacing: 10) {
                InputTextFieldView(viewModel: viewModel.textFieldViewModel(.skills),
                                   textFieldText: $viewModel.skillsFieldText,
                                   isEditable: $viewModel.isEditing)
                RoundButtonView(viewModel: viewModel.addButtonViewModel)
                .padding(.top, 6)
            }
            TagView(viewModel: $viewModel.tags)
        }
        .disabled(!viewModel.isEditing)
        .frame(width: UIScreen.main.bounds.width - 40)
    }
}
