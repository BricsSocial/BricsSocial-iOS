//
//  CommonInputTextFieldView.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 11.03.2023.
//

import SwiftUI

private extension Color {
    static let lightGrayColor = Color("LightGrayColor")
}

// MARK: - MainView

struct InputTextFieldView: View {
    
    // Models
    var viewModel: InputTextFieldViewModel
    
    // Binding variables
    @Binding var textFieldText: String
    @Binding var isEditable: Bool
    
    // State variables
    @State private var editing: Bool = false
    @State private var isValidated: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(viewModel.textFieldName)
                .font(.system(size: 15))
                .bold()
                .frame(height: 10)
                .background(Color.white.frame(height: 20))
                .padding(.init(top: 3, leading: 50, bottom: -25, trailing: 10))
                .zIndex(1)
            
            HStack {
                Image(systemName: viewModel.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.lightGrayColor)
                    .padding(.all, 15)
                textView
            }.background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(resolveStrokeColor(), lineWidth: 0.5)
                .zIndex(0)
            )
            .disabled(!isEditable)
        }
    }
    
    // MARK: - Private
    
    private var textView: some View {
        TextField(viewModel.textFieldContent,
                  text: $textFieldText,
                  onEditingChanged: { isChanging in
            editing = isChanging
            guard !isChanging && !textFieldText.isEmpty else { return }
            isValidated = viewModel.validation(textFieldText)
        })
        .textContentType(viewModel.textContentType)
        .font(Font.body.weight(.medium))
        .foregroundColor(Color.lightGrayColor)
        .autocapitalization(.none)
        .disableAutocorrection(true)
    }
    
    private func resolveStrokeColor() -> Color {
        guard isEditable && !textFieldText.isEmpty else {
            return Color.lightGrayColor
        }
        
        if editing {
            return Color.blue
        } else {
            if isValidated {
                return Color.lightGrayColor
            } else {
                return Color.red
            }
        }
    }
}
