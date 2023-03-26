//
//  AuthViewModel.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import Foundation

final class AuthViewModel: ObservableObject {
    
    // Observed values
    @Published var emailFieldText: String = ""
    @Published var passwordFieldText: String = ""
    
    // Dependencies
    private let inputTextFieldViewModelFactory: IInputTextFieldViewModelFactory
    private let dataValidationHandler: IDataValidationHandler
    private let authService: IAuthService
    
    // MARK: - Initialization
    
    init(inputTextFieldViewModelFactory: IInputTextFieldViewModelFactory,
         dataValidationHandler: IDataValidationHandler,
         authService: IAuthService) {
        self.inputTextFieldViewModelFactory = inputTextFieldViewModelFactory
        self.dataValidationHandler = dataValidationHandler
        self.authService = authService
    }

    // MARK: - Public
    
    var isDataValid: Bool {
        [
            dataValidationHandler.validateEmail(rawEmail: emailFieldText),
            dataValidationHandler.validatePassword(rawPassword: passwordFieldText)
        ].allSatisfy { $0 }
    }

    func textFieldViewModel(_ type: InputTextViewType) -> InputTextFieldViewModel {
        inputTextFieldViewModelFactory.makeInputTextFieldViewModel(type)
    }
    
    func performSignIn() async -> NetworkError?  {
        return await authService.performSignIn(email: emailFieldText, password: passwordFieldText)
    }
}
