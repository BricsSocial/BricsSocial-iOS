//
//  SignUpView.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var viewModel: SignUpViewModel = SignUpViewModel(inputTextFieldViewModelFactory: InputTextFieldViewModelFactory(dataValidationHandler: RootAssembly.serviceAssembly.dataValidationHandler,
                                                                                                                                 specialistInfoService: RootAssembly.serviceAssembly.specialistInfoService),
                                                                  dataValidationHandler: RootAssembly.serviceAssembly.dataValidationHandler,
                                                                  authService: RootAssembly.serviceAssembly.authService)
    
    @State var isAlertPresented: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("You are signing up as a specialist, enter your account details")
                            .font(.title3.bold())
                            .padding(.bottom, 15)
                        
                        InputTextFieldView(viewModel: viewModel.textFieldViewModel(.name),
                                           textFieldText: $viewModel.firstNameTextField,
                                           isEditable: Binding.constant(true))
                        
                        InputTextFieldView(viewModel: viewModel.textFieldViewModel(.surname),
                                           textFieldText: $viewModel.lastNameTextField,
                                           isEditable: Binding.constant(true))
                        
                        InputTextFieldView(viewModel: viewModel.textFieldViewModel(.email),
                                           textFieldText: $viewModel.emailTextField,
                                           isEditable: Binding.constant(true))
                        
                        SensitiveDataTextFieldView(viewModel: viewModel.textFieldViewModel(.password),
                                                   textFieldText: $viewModel.passwordTextField)
                        
                        CountryPickerView(chosenCountry: $viewModel.country,
                                          isEditable: Binding.constant(true))
                        
                        
                    }
                    .padding(.horizontal, 20)
                }
            }.frame(width: UIScreen.main.bounds.width)
                .overlay(
                    VStack {
                        Spacer()
                        Button(action: {
                            Task {
                                if await viewModel.performSignUp() != nil {
                                    DispatchQueue.main.async {
                                        isAlertPresented.toggle()
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                        dismiss()
                                    }
                                }
                            }
                        }, label: {
                            Text("Sign Up")
                                .foregroundColor(Color.white)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .foregroundColor(viewModel.isValidated ? Color.black : Color.gray)
                                )
                                .padding(.horizontal, 15)
                                .padding(.bottom, 20)
                        })
                        .disabled(!viewModel.isValidated)
                    }
                )
                .alert(isPresented: $isAlertPresented) {
                    Alert(
                        title: Text("Registration error"),
                        message: Text("Oops, something went wrong! Please try again."),
                        dismissButton: .cancel()
                    )
                }
        }
    }
}
