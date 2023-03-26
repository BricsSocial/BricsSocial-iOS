//
//  SignInView.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject var viewModel: AuthViewModel = AuthViewModel(inputTextFieldViewModelFactory: InputTextFieldViewModelFactory(dataValidationHandler: RootAssembly.serviceAssembly.dataValidationHandler,
                                                                                                                             specialistInfoService: RootAssembly.serviceAssembly.specialistInfoService),
                                                              dataValidationHandler: RootAssembly.serviceAssembly.dataValidationHandler,
                                                              authService: RootAssembly.serviceAssembly.authService)
    
    @State var isAlertPresented: Bool = false
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack {
                        Text("BRICS")
                            .font(.largeTitle.bold())
                            .padding(.bottom, 25)
                        
                        VStack(alignment: .leading) {
                            Text("You are signing in as a specialist")
                                .font(.title3.bold())
                                .padding(.bottom, 15)
                            
                            InputTextFieldView(viewModel: viewModel.textFieldViewModel(.email),
                                               textFieldText: $viewModel.emailFieldText,
                                               isEditable: Binding.constant(true))
                            
                            SensitiveDataTextFieldView(viewModel: viewModel.textFieldViewModel(.password),
                                                       textFieldText: $viewModel.passwordFieldText)
                            
                        }
                        .padding(.horizontal, 20)
                        
                        NavigationLink(destination: SignUpView()) {
                            HStack(alignment: .center) {
                                Text("Create specialist account")
                                    .font(.subheadline)
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .frame(width: 6, height: 10)
                                    .bold()
                                    .foregroundColor(.black)
                            }
                            .padding(.top, 30)
                        }
                    }
                }.frame(width: UIScreen.main.bounds.width)
                    .overlay(
                        VStack {
                            Spacer()
                            Button(action: {
                                Task {
                                    if await viewModel.performSignIn() != nil {
                                        DispatchQueue.main.async { isAlertPresented.toggle() }
                                    } else {
                                        DispatchQueue.main.async { withAnimation { isLoggedIn.toggle() } }
                                    }
                                }
                            }, label: {
                                Text("Sign In")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(
                                        RoundedRectangle(cornerRadius: 14)
                                            .foregroundColor(viewModel.isDataValid ? Color.black : Color.gray)
                                    )
                                    .padding(.horizontal, 15)
                                    .padding(.bottom, 20)
                            })
                            .disabled(!viewModel.isDataValid)
                        }
                    )
                    .alert(isPresented: $isAlertPresented) {
                        Alert(
                            title: Text("Authentification error"),
                            message: Text("Incorrect email or password, please try again!"),
                            dismissButton: .cancel()
                        )
                    }
            }
        }
    }
}
