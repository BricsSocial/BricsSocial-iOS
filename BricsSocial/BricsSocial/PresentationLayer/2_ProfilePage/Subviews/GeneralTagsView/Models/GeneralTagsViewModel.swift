//
//  GeneralTagsViewModel.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

import SwiftUI

final class GeneralTagsViewModel: ObservableObject {
    
    // Dependencies
    private var userDataHandler: IUserDataHandler
    private var dataValidationHandler: IDataValidationHandler
    private let viewModelFactory: IProfilePageViewModelFactory
    
    // State variables
    @Published var skillsFieldText: String = ""
    @Published var bioFieldText: String = ""
    
    // View Models
    lazy var skillsFieldViewModel: InputTextFieldViewModel = InputTextFieldViewModel(textFieldName: "Skills",
                                                                                   textFieldContent: "Marketing, SMM, IT...",
                                                                                   iconName: "case.fill",
                                                                                   textContentType: .jobTitle)
    
    lazy var addButtonViewModel: RoundButtonViewModel = RoundButtonViewModel(iconName: "plus",
                                                                             foregroundColor: .white,
                                                                             backgroundColor: .black,
                                                                             disabledBackgroundColor: .gray,
                                                                             iconSide: 10,
                                                                             buttonSide: 20,
                                                                             action: { [weak self] in
        guard let self = self else { return }
        self.tagsViewModel.tags.append(Tag(text: self.skillsFieldText))
    })
    var bioFieldViewModel: InputTextFieldViewModel {
        viewModelFactory.makeBIOInputTextFieldViewModel(bio: userDataHandler.bio, validation: dataValidationHandler.validateBio(rawBio:))
    }
    
    lazy var tagsViewModel: TagsViewModel = {
        return TagsViewModel(titles: userDataHandler.skills)
    }()
    
    // MARK: - Initialization

    init(userDataHandler: IUserDataHandler,
         dataValidationHandler: IDataValidationHandler,
         viewModelFactory: IProfilePageViewModelFactory) {
        self.userDataHandler = userDataHandler
        self.dataValidationHandler = dataValidationHandler
        self.viewModelFactory = viewModelFactory
    }
}

extension GeneralTagsViewModel: IProfilePageViewModel {
    
    var isDataValid: Bool {
        return dataValidationHandler.validateBio(rawBio: bioFieldText) || bioFieldText == ""
    }
    
    func save() {
        userDataHandler.skills = tagsViewModel.tags.map { $0.text }
        userDataHandler.bio = bioFieldText
    }
    
    func reset() {
        tagsViewModel = TagsViewModel(titles: userDataHandler.skills)
        skillsFieldText = ""
        bioFieldText = ""
    }
}
