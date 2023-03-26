//
//  SignUpViewModel.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import Foundation

final class SignUpViewModel: ObservableObject {
    
    // Observed variables
    @Published var firstNameTextField: String = ""
    @Published var lastNameTextField: String = ""
    @Published var emailTextField: String = ""
    @Published var passwordTextField: String = ""
    @Published var country: Country = .brasil
    
    // Private
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
    
    // MARK: - Private
    
    private var registrationInfo: SpecialistRegistrationInfo {
        SpecialistRegistrationInfo(email: emailTextField,
                                   password: passwordTextField,
                                   firstName: firstNameTextField,
                                   lastName: lastNameTextField,
                                   countryId: country.rawValue)
    }
    
    // MARK: - Public

    func textFieldViewModel(_ type: InputTextViewType) -> InputTextFieldViewModel {
        inputTextFieldViewModelFactory.makeInputTextFieldViewModel(type)
    }
    
    var isValidated: Bool {
        [
            dataValidationHandler.validateNameOrSurname(rawValue: firstNameTextField),
            dataValidationHandler.validateNameOrSurname(rawValue: lastNameTextField),
            dataValidationHandler.validateEmail(rawEmail: emailTextField),
            dataValidationHandler.validatePassword(rawPassword: passwordTextField)
        ].allSatisfy { $0 }
    }
    
    func performSignUp() async -> NetworkError? {
        return await authService.performSignUp(info: registrationInfo)
    }
}
