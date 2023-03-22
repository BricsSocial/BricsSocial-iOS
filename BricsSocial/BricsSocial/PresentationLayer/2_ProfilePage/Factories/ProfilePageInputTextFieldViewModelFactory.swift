//
//  ProfilePageInputTextFieldViewModelFactory.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 21.03.2023.
//

import Foundation

protocol IProfilePageViewModelFactory {
    func makeEmailInputTextFieldViewModel(email: String, validation: @escaping (String) -> Bool)
    -> InputTextFieldViewModel
    func makePhoneInputTextFieldViewModel(phone: String, validation: @escaping (String) -> Bool)
    -> InputTextFieldViewModel
    func makeNameInputTextFieldViewModel(name: String, validation: @escaping (String) -> Bool)
    -> InputTextFieldViewModel
    func makeSurnameInputTextFieldViewModel(surname: String, validation: @escaping (String) -> Bool)
    -> InputTextFieldViewModel
    func makeBIOInputTextFieldViewModel(bio: String, validation: @escaping (String) -> Bool)
    -> InputTextFieldViewModel
}

final class ProfilePageViewModelFactory: IProfilePageViewModelFactory {
        
    func makeBIOInputTextFieldViewModel(bio: String, validation: @escaping (String) -> Bool)
    -> InputTextFieldViewModel {
        InputTextFieldViewModel(textFieldName: "Bio",
                                textFieldContent: bio,
                                iconName: "doc.circle.fill",
                                textContentType: .jobTitle,
                                validation: validation)
    }
    
    func makeNameInputTextFieldViewModel(name: String, validation: @escaping (String) -> Bool)
    -> InputTextFieldViewModel {
        InputTextFieldViewModel(textFieldName: "Name",
                                textFieldContent: name,
                                iconName: "person.crop.circle",
                                textContentType: .name,
                                validation: validation)
    }
    
    func makeSurnameInputTextFieldViewModel(surname: String, validation: @escaping (String) -> Bool)
    -> InputTextFieldViewModel {
        InputTextFieldViewModel(textFieldName: "Surname",
                                textFieldContent: surname,
                                iconName: "person.2",
                                textContentType: .name,
                                validation: validation)
    }
    
    func makeEmailInputTextFieldViewModel(email: String, validation: @escaping (String) -> Bool)
    -> InputTextFieldViewModel {
        InputTextFieldViewModel(textFieldName: "Email",
                                textFieldContent: email,
                                iconName: "envelope.fill",
                                textContentType: .emailAddress,
                                validation: validation)
    }
    
    func makePhoneInputTextFieldViewModel(phone: String, validation: @escaping (String) -> Bool)
    -> InputTextFieldViewModel {
        InputTextFieldViewModel(textFieldName: "Phone",
                                textFieldContent: phone,
                                iconName: "phone.fill",
                                textContentType: .telephoneNumber,
                                validation: validation)
    }
}
