//
//  ProfilePageViewModel.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

import SwiftUI

private extension String {
    func notEmptyString(newStr: String?) -> String {
        if let newStr = newStr, !newStr.isEmpty {
            return newStr
        } else {
            return self
        }
    }
}

final class ProfilePageViewModel: ObservableObject {
    
    // Dependencies
    private var userDataHandler: IUserDataHandler
    private let dataValidationHandler: IDataValidationHandler
    private let inputTextFieldViewModelFactory: IInputTextFieldViewModelFactory
    private let profileImageHandler: IProfileImageHandler
    
    // State variables
    @Published var isEditing: Bool = false
    @Published var state: LoadingState<UserData> = .idle
    
    // Input Data
    @Published var profileImage: UIImage?

    // General Field Texts
    @Published var skillsFieldText : String  = String()
    @Published var tags            : [Tag]   = []
    
    @Published var bioFieldText    : String  = String()
    @Published var descriptionText : String  = String()
    
    // Summary Field Texts
    @Published var nameFieldText   : String  = String()
    @Published var surnameFieldText: String  = String()
    @Published var mailFieldText   : String  = String()
    @Published var phoneFieldText  : String  = String()
    @Published var country         : Country?
    
    // Computed Properties
    var addButtonViewModel: RoundButtonViewModel {
        inputTextFieldViewModelFactory.makeTagAddButtonViewModel(actions: self)
    }
    
    var isDataValid: Bool {
        [
            dataValidationHandler.validateNameOrSurname(rawValue: userDataHandler.name.notEmptyString(newStr: nameFieldText)),
            dataValidationHandler.validateNameOrSurname(rawValue: userDataHandler.surname.notEmptyString(newStr: surnameFieldText)),
            dataValidationHandler.validateEmail(rawEmail: userDataHandler.email.notEmptyString(newStr: mailFieldText)),
            dataValidationHandler.validatePhone(rawPhone: userDataHandler.phone.notEmptyString(newStr: phoneFieldText))
        ].allSatisfy { $0 }
    }
    
    // MARK: - Initialization
    
    init(dataValidationHandler: IDataValidationHandler,
         userDataHandler: IUserDataHandler,
         profileImageHandler: IProfileImageHandler,
         inputTextFieldViewModelFactory: IInputTextFieldViewModelFactory) {
        self.dataValidationHandler = dataValidationHandler
        self.userDataHandler = userDataHandler
        self.profileImageHandler = profileImageHandler
        self.inputTextFieldViewModelFactory = inputTextFieldViewModelFactory
    }
    
    func saveUserInfo() {
        userDataHandler.name = userDataHandler.name.notEmptyString(newStr: nameFieldText)
        userDataHandler.surname = userDataHandler.surname.notEmptyString(newStr: surnameFieldText)
        userDataHandler.email = userDataHandler.email.notEmptyString(newStr: mailFieldText)
        userDataHandler.phone = userDataHandler.phone.notEmptyString(newStr: phoneFieldText)
        userDataHandler.countryISO = userDataHandler.phone.notEmptyString(newStr: country?.code)
        
        userDataHandler.skills = tags.map { $0.text }
        userDataHandler.bio = userDataHandler.bio.notEmptyString(newStr: bioFieldText)
        userDataHandler.description = userDataHandler.description.notEmptyString(newStr: descriptionText)
    }
    
    func resetUserInfo() {
        skillsFieldText  = String()
        tags             = userDataHandler.skills.map(Tag.makeTag(from:))
        bioFieldText     = String()
        descriptionText  = userDataHandler.description
        nameFieldText    = String()
        surnameFieldText = String()
        mailFieldText    = String()
        phoneFieldText   = String()
        country          = Country(regionCode: userDataHandler.countryISO)
    }
    
    func textFieldViewModel(_ type: InputTextViewType) -> InputTextFieldViewModel {
        inputTextFieldViewModelFactory.makeInputTextFieldViewModel(type)
    }
}

// MARK: - IProfilePageViewModelActions

extension ProfilePageViewModel: IProfilePageViewModelActions {
    
    var isAddButtonDisabled: Bool {
        skillsFieldText.isEmpty || !isEditing
    }
    
    func addNewTag() {
        tags.append(Tag.makeTag(from: skillsFieldText))
    }
}

extension ProfilePageViewModel: LoadableObject {
    
    func load() {
        state = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self]  in
            guard let self = self else { return }
            self.userDataHandler.userData = UserData(name: "Alexander",
                                                     surname: "Samarenko",
                                                     bio: "iOS-Developer",
                                                     email: "avsamarenko_1@edu.hse.ru",
                                                     phone: "9957922425",
                                                     countryISO: "RU",
                                                     description: "FUCK",
                                                     skills: [])
            self.state = .loaded(self.userDataHandler.userData)
            
            self.profileImageHandler.provideProfileImage()
            self.profileImage = self.profileImageHandler.image
            
            self.country = Country(regionCode: self.userDataHandler.countryISO)
            self.tags = self.userDataHandler.skills.map(Tag.makeTag(from:))
            self.descriptionText = self.userDataHandler.description
        }
    }
}
