//
//  DataValidationHandler.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

import Foundation

extension String {
    static let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let phoneRegex: String = #"^?\(?\d{3}\)?[ -]?\d{3}[ -]?\d{4}$"#
    static let nameOrSurnameValidation = "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$"
    static let selfMatchesFormat: String = "SELF MATCHES %@"
}

protocol IDataValidationHandler {
    // Валидация почтового адреса
    func validateEmail(rawEmail: String) -> Bool
    // Валидация номера телефона
    func validatePhone(rawPhone: String) -> Bool
    // Валидация имени или фамилии
    func validateNameOrSurname(rawValue: String) -> Bool
    // Валидация биографии
    func validateBio(rawBio: String) -> Bool
}

final class DataValidationHandler: IDataValidationHandler {
    
    // MARK: - IDataValidationHandler
    
    func validateEmail(rawEmail: String) -> Bool {
        let emailPred = NSPredicate(format: String.selfMatchesFormat, String.emailRegex)
        return emailPred.evaluate(with: rawEmail) 
    }
    
    func validatePhone(rawPhone: String) -> Bool {
        let phonePred = NSPredicate(format: String.selfMatchesFormat, String.phoneRegex)
        return phonePred.evaluate(with: rawPhone)
    }
    
    func validateNameOrSurname(rawValue: String) -> Bool {
        guard rawValue.count > 3, rawValue.count < 18 else { return false }

        let predicateTest = NSPredicate(format: String.selfMatchesFormat, String.nameOrSurnameValidation)
        return predicateTest.evaluate(with: rawValue)
    }
    
    func validateBio(rawBio: String) -> Bool {
        return !rawBio.isEmpty && rawBio.count < 20
    }
}
