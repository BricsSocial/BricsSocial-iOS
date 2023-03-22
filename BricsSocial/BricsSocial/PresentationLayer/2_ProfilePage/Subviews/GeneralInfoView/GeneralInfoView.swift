//
//  GeneralInfoView.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

import SwiftUI

struct GeneralInfoView: View {
    
    // Binding States
    @Binding var isEditing: Bool
    
    // View Models
    @ObservedObject var viewModel: GeneralInfoViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            InputTextFieldView(viewModel: viewModel.nameInputTextViewModel,
                               textFieldText: $viewModel.nameFieldText,
                               isEditable: $isEditing)
            InputTextFieldView(viewModel: viewModel.surnameInputTextViewModel,
                               textFieldText: $viewModel.surnameFieldText,
                               isEditable: $isEditing)
            InputTextFieldView(viewModel: viewModel.mailInputTextViewModel,
                               textFieldText: $viewModel.mailFieldText,
                               isEditable: $isEditing)
            InputTextFieldView(viewModel: viewModel.telephoneInputTextViewModel,
                               textFieldText: $viewModel.phoneFieldText,
                               isEditable: $isEditing)
            CountryPickerView(viewModel: viewModel.countryPickerViewModel,
                              isEditable: $isEditing)
        }
    }
}
