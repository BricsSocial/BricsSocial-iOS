//
//  TagsGeneralView.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

import SwiftUI

struct GeneralTagsView: View {
    
    // Binding Variables
    @Binding var isEditing: Bool
    
    // View Models
    @ObservedObject var viewModel: GeneralTagsViewModel

    var body: some View {
        VStack(spacing: 20) {
            InputTextFieldView(viewModel: viewModel.bioFieldViewModel,
                               textFieldText: $viewModel.bioFieldText,
                               isEditable: $isEditing)
            HStack(alignment: .center, spacing: 10) {
                InputTextFieldView(viewModel: viewModel.skillsFieldViewModel,
                                   textFieldText: $viewModel.skillsFieldText,
                                   isEditable: $isEditing)
                RoundButtonView(viewModel: viewModel.addButtonViewModel,
                                // подумать как исправить
                                isDisabled: viewModel.skillsFieldText.isEmpty || !isEditing)
                .padding(.top, 6)
            }
            TagView(viewModel: viewModel.tagsViewModel)
        }
        .disabled(!isEditing)
        .frame(width: UIScreen.main.bounds.width - 40)
    }
}
