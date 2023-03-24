//
//  ProfilePageInputTextFieldViewModelFactory.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 21.03.2023.
//

import Foundation

private extension String {
    static let nameFieldName: String = "First Name"
    static let nameIconName: String = "person.crop.circle"
    
    static let bioFieldName: String = "Bio"
    static let bioIconName: String = "doc.circle.fill"
    
    static let surnameFieldName: String = "Last Name"
    static let surnameIconName: String = "person.2"
    
    static let emailFieldName: String = "Email"
    static let emailIconName: String = "envelope.fill"
    
    static let phoneFieldName: String = "Phone"
    static let phoneIconName: String = "phone.fill"
    
    static let plusButtonIcon: String = "plus"
    
    static let skillsFieldName: String = "Skills"
    static let skillsFieldContent: String = "Marketing, SMM, IT..."
    static let skillsIconName: String = "case.fill"
}

enum InputTextViewType {
    case email
    case phone
    case name
    case surname
    case bio
    case skills
}

protocol IInputTextFieldViewModelFactory {
    func makeInputTextFieldViewModel(_ type: InputTextViewType) -> InputTextFieldViewModel
    func makeTagAddButtonViewModel(actions: IProfilePageViewModelActions) -> RoundButtonViewModel
}

protocol IProfilePageViewModelActions: AnyObject {
    var isAddButtonDisabled: Bool { get }
    func addNewTag()
}

final class InputTextFieldViewModelFactory: IInputTextFieldViewModelFactory {
        
    // Dependencies
    private let dataValidationHandler: IDataValidationHandler
    private let userDataHandler: IUserDataHandler
    
    // MARK: - Initialization
    
    init(dataValidationHandler: IDataValidationHandler,
         userDataHandler: IUserDataHandler) {
        self.dataValidationHandler = dataValidationHandler
        self.userDataHandler = userDataHandler
    }
    
    // MARK: - IInputTextFieldViewModelFactory

    func makeInputTextFieldViewModel(_ type: InputTextViewType) -> InputTextFieldViewModel {
        switch type {
        case .name:
            return InputTextFieldViewModel(textFieldName: String.nameFieldName,
                                           textFieldContent: userDataHandler.name,
                                           iconName: String.nameIconName,
                                           textContentType: .name,
                                           validation: dataValidationHandler.validateNameOrSurname(rawValue:))
        case .bio:
            return InputTextFieldViewModel(textFieldName: String.bioFieldName,
                                           textFieldContent: userDataHandler.bio,
                                           iconName: String.bioIconName,
                                           textContentType: .name,
                                           validation: dataValidationHandler.validateBio(rawBio:))
        case .surname:
            return InputTextFieldViewModel(textFieldName: String.surnameFieldName,
                                           textFieldContent: userDataHandler.surname,
                                           iconName: String.surnameIconName,
                                           textContentType: .name,
                                           validation: dataValidationHandler.validateNameOrSurname(rawValue:))
        case .email:
            return InputTextFieldViewModel(textFieldName: String.emailFieldName,
                                           textFieldContent: userDataHandler.email,
                                           iconName: String.emailIconName,
                                           textContentType: .emailAddress,
                                           validation: dataValidationHandler.validateEmail(rawEmail:))
        case .phone:
            return InputTextFieldViewModel(textFieldName: String.phoneFieldName,
                                           textFieldContent: userDataHandler.phone,
                                           iconName: String.phoneIconName,
                                           textContentType: .telephoneNumber,
                                           validation: dataValidationHandler.validatePhone(rawPhone:))
        case .skills:
            return InputTextFieldViewModel(textFieldName: String.skillsFieldName,
                                           textFieldContent: String.skillsFieldContent,
                                           iconName: String.skillsIconName,
                                           textContentType: .jobTitle,
                                           validation: { _ in return true })
        }
    }
    
    func makeTagAddButtonViewModel(actions: IProfilePageViewModelActions) -> RoundButtonViewModel {
        RoundButtonViewModel(iconName: String.plusButtonIcon,
                             foregroundColor: .white,
                             backgroundColor: .black,
                             disabledBackgroundColor: .gray,
                             iconSide: 10,
                             buttonSide: 20,
                             isDisabled: { [weak actions] in
            guard let actions = actions else { return false }
            return actions.isAddButtonDisabled },
                             action: { [weak actions] in
            actions?.addNewTag()
        })
    }
}
