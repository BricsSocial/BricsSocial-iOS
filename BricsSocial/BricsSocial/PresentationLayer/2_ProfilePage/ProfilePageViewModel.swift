//
//  ProfilePageViewModel.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

import SwiftUI

protocol IProfilePageViewModel {
    // Валидность введенных данных
    var isDataValid: Bool { get }
    // Сохранить введенные данные
    func save()
    // Инвалидировать введенные пользователем данные
    func reset()
}

final class ProfilePageViewModel: ObservableObject {
    
    // Dependencies
    private let userDataHandler: IUserDataHandler
    private let dataValidationHandler: IDataValidationHandler
    
    // State variables
    @Published var isEditing: Bool = false
    
    // ViewModels
    lazy var infoViewModel = GeneralInfoViewModel(dataValidationHandler: dataValidationHandler,
                                                  userDataHandler: userDataHandler,
                                                  viewModelFactory: ProfilePageViewModelFactory())
    lazy var tagsViewModel = GeneralTagsViewModel(userDataHandler: userDataHandler,
                                                  dataValidationHandler: dataValidationHandler,
                                                  viewModelFactory: ProfilePageViewModelFactory())
    
    private lazy var handledViewModels: [IProfilePageViewModel] = {
        [
            infoViewModel,
            tagsViewModel
        ]
    }()
    
    // MARK: - Initialization
    
    init(dataValidationHandler: IDataValidationHandler,
         userDataHandler: IUserDataHandler) {
        self.dataValidationHandler = dataValidationHandler
        self.userDataHandler = userDataHandler
    }
}

extension ProfilePageViewModel: IProfilePageViewModel {
    
    var isDataValid: Bool {
        handledViewModels.allSatisfy(\.isDataValid)
    }
    
    func reset() {
        handledViewModels.forEach { $0.reset() }
    }
    
    func save() {
        handledViewModels.forEach { $0.save() }
        reset()
    }
}
