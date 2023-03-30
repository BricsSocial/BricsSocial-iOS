//
//  GeneralInfoView.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

import SwiftUI

struct GeneralView: View {
    
    // View Models
    @EnvironmentObject var viewModel: ProfilePageViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            InputTextFieldView(viewModel: viewModel.textFieldViewModel(.name),
                               textFieldText: $viewModel.nameFieldText,
                               isEditable: $viewModel.isEditing)
            InputTextFieldView(viewModel: viewModel.textFieldViewModel(.surname),
                               textFieldText: $viewModel.surnameFieldText,
                               isEditable: $viewModel.isEditing)
            InputTextFieldView(viewModel: viewModel.textFieldViewModel(.email),
                               textFieldText: $viewModel.mailFieldText,
                               isEditable: $viewModel.isEditing)
            CountryPickerView(chosenCountry: $viewModel.country,
                              isEditable: Binding.constant(false))
            .disabled(true)
        }
    }
}
