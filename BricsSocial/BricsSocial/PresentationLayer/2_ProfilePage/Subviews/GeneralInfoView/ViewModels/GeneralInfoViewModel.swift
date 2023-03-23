//
//  GeneralInfoViewModel.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

import SwiftUI

final class GeneralInfoViewModel: ObservableObject {
    
    // Dependencies
    private let dataValidationHandler: IDataValidationHandler
    private var userDataHandler: IUserDataHandler
    private let viewModelFactory: IProfilePageViewModelFactory
    
    var nameInputTextViewModel: InputTextFieldViewModel {
        viewModelFactory.makeNameInputTextFieldViewModel(name: userDataHandler.name, validation: dataValidationHandler.validateNameOrSurname(rawValue:))
    }
    
    var surnameInputTextViewModel: InputTextFieldViewModel {
        viewModelFactory.makeSurnameInputTextFieldViewModel(surname: userDataHandler.surname, validation: dataValidationHandler.validateNameOrSurname(rawValue:))
    }
    
    var mailInputTextViewModel: InputTextFieldViewModel {
        viewModelFactory.makeEmailInputTextFieldViewModel(email: userDataHandler.email,
                                                          validation: dataValidationHandler.validateEmail(rawEmail:))
    }
    
    var telephoneInputTextViewModel: InputTextFieldViewModel {
        viewModelFactory.makePhoneInputTextFieldViewModel(phone: userDataHandler.phone,
                                                          validation: dataValidationHandler.validatePhone(rawPhone:))
    }
    
    lazy var countryPickerViewModel: CountryPickerViewModel = CountryPickerViewModel(countryCode: userDataHandler.countryISO)
    
    // State variables
    @Published var mailFieldText: String = ""
    @Published var phoneFieldText: String = ""
    @Published var nameFieldText: String = ""
    @Published var surnameFieldText: String = ""
    
    // MARK: - Initialization
    
    init(dataValidationHandler: IDataValidationHandler,
         userDataHandler: IUserDataHandler,
         viewModelFactory: IProfilePageViewModelFactory) {
        self.dataValidationHandler = dataValidationHandler
        self.userDataHandler = userDataHandler
        self.viewModelFactory = viewModelFactory
    }
}

// MARK: - IProfilePageViewModel

extension GeneralInfoViewModel: IProfilePageViewModel {
    
    var isDataValid: Bool {
        (dataValidationHandler.validateEmail(rawEmail: mailFieldText) || mailFieldText == "")
        &&
        (dataValidationHandler.validatePhone(rawPhone: phoneFieldText) || phoneFieldText == "")
        &&
        (dataValidationHandler.validateNameOrSurname(rawValue: nameFieldText) || nameFieldText == "")
        &&
        (dataValidationHandler.validateNameOrSurname(rawValue: surnameFieldText) || surnameFieldText == "")
    }
    
    func save() {
        userDataHandler.email = mailFieldText
        userDataHandler.phone = phoneFieldText
        userDataHandler.countryISO = countryPickerViewModel.country.code
        userDataHandler.surname = surnameFieldText
        userDataHandler.name = nameFieldText
    }
    
    func reset() {
        mailFieldText = String()
        phoneFieldText = String()
        countryPickerViewModel = CountryPickerViewModel(countryCode: userDataHandler.countryISO)
        nameFieldText = String()
        surnameFieldText = String()
    }
}
