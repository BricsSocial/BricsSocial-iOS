//
//  SensitiveDataTextFieldView.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import SwiftUI

private extension Color {
    static let lightGrayColor = Color("LightGrayColor")
}

struct SensitiveDataTextFieldView: View {
    
    var viewModel: InputTextFieldViewModel
        
    @Binding var textFieldText: String
    
    // State variables
    @State private var showText: Bool = false
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
                if showText {
                    textView
                } else {
                    secureTextView
                }
                Button(action: {
                    withAnimation {
                        showText.toggle()
                    }
                }, label: {
                    Image(systemName: showText ? "eye.fill" : "eye.slash.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.lightGrayColor)
                        .padding(.all, 15)
                })
                .accentColor(Color.lightGrayColor)
                
            }.background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color.lightGrayColor, lineWidth: 0.5)
                .zIndex(0)
            )
        }
    }
    
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
    }
    
    private var secureTextView: some View {
        SecureField(viewModel.textFieldContent,
                    text: $textFieldText)
        .textContentType(.password)
        .foregroundColor(Color.lightGrayColor)
        .font(Font.body.weight(.medium))
    }
}
