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
    var description: String
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
    // Описание профиля пользователя
    var description: String { get set }
    
    var userData: UserData { get set }
}

final class UserDataHandler: IUserDataHandler {
    
    var userData = UserData(name: "Alexander",
                            surname: "Samarenko",
                            bio: "iOS-Developer",
                            email: "avsamarenko@gmail.com",
                            phone: "9157922425",
                            countryISO: "RU",
                            description: "Highly motivated, improving skills constantly",
                            skills: [])
    
    // MARK: - IUserDataHandler
    
    var email: String {
        get { return userData.email }
        set { userData.email = newValue }
    }
    
    var phone: String {
        get { return userData.phone }
        set { userData.phone = newValue }
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
        set { userData.name = newValue }
    }
    
    var bio: String {
        get { return userData.bio }
        set { userData.bio = newValue }
    }
   
    var surname: String {
        get { return userData.surname }
        set { userData.surname = newValue }
    }
    
    var description: String {
        get { return userData.description }
        set { userData.description = newValue }
    }
    
    func save() {}
}
