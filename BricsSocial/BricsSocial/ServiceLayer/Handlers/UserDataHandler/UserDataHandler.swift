//
//  UserDataHandler.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 21.03.2023.
//

struct UserData {
    var name: String
    var surname: String
    var bio: String
    var email: String
    var phone: String
    var countryISO: String
    var skills: [String]
}

protocol IUserDataHandler {
    // Почта пользователя
    var email: String { get set }
    // Мобильный телефон пользователя
    var phone: String { get set }
    // ISO-код страны пользователя
    var countryISO: String { get set }
    // Умения
    var skills: [String] { get set }
    // Имя пользователя
    var name: String { get set }
    // Фамилия пользователя
    var surname: String { get set }
    // Биография
    var bio: String { get set }
    // Сохранение информации о пользователе
    func save()
}

final class UserDataHandler: IUserDataHandler {
    
    private(set) var userData = UserData(name: "Andrew",
                                         surname: "Samarenko",
                                         bio: "iOS-Developer",
                                         email: "avsamarenko@gmail.com",
                                         phone: "9157922425",
                                         countryISO: "RU",
                                         skills: [])
    
    // MARK: - IUserDataHandler
    
    var email: String {
        get { return userData.email }
        set {
            guard !newValue.isEmpty else { return }
            userData.email = newValue
        }
    }
    
    var phone: String {
        get { return userData.phone }
        set {
            guard !newValue.isEmpty else { return }
            userData.phone = newValue
        }
    }
    
    var countryISO: String {
        get { return userData.countryISO }
        set { userData.countryISO = newValue }
    }
    
    var skills: [String] {
        get { return userData.skills }
        set { userData.skills = newValue }
    }
    
    var name: String {
        get { return userData.name }
        set {
            guard !newValue.isEmpty else { return }
            userData.name = newValue
        }
    }
    
    var bio: String {
        get { return userData.bio }
        set {
            guard !newValue.isEmpty else { return }
            userData.bio = newValue
        }
    }
   
    var surname: String {
        get { return userData.surname }
        set {
            guard !newValue.isEmpty else { return }
            userData.surname = newValue
        }
    }
    
    func save() {}
}
