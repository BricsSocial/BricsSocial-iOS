//
//  ProfilePageViewModel.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

import SwiftUI

private extension String {
    func nilOrString() -> String? {
        if self.isEmpty {
            return nil
        } else {
            return self
        }
    }
}

final class ProfilePageViewModel: ObservableObject {
    
    // Dependencies
    private let dataValidationHandler: IDataValidationHandler
    private let inputTextFieldViewModelFactory: IInputTextFieldViewModelFactory
    private let profileImageHandler: IProfileImageHandler
    private let specialistInfoService: ISpecialistInfoService
    
    // Private
    var cachedSpecialistInfo: Specialist? {
        specialistInfoService.specialist
    }
    
    // State variables
    @Published var isEditing: Bool = false
    @Published var state: LoadingState<Specialist> = .loading
    
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
    @Published var country         : CountryModel?
    
    // Computed Properties
    var addButtonViewModel: RoundButtonViewModel {
        inputTextFieldViewModelFactory.makeTagAddButtonViewModel(actions: self)
    }
    
    var isDataValid: Bool {
        [
           
        ].allSatisfy { $0 }
    }
    
    // MARK: - Initialization
    
    init(dataValidationHandler: IDataValidationHandler,
         profileImageHandler: IProfileImageHandler,
         inputTextFieldViewModelFactory: IInputTextFieldViewModelFactory,
         specialistInfoService: ISpecialistInfoService) {
        self.dataValidationHandler = dataValidationHandler
        self.profileImageHandler = profileImageHandler
        self.inputTextFieldViewModelFactory = inputTextFieldViewModelFactory
        self.specialistInfoService = specialistInfoService
    }
    
    func save() async -> NetworkError? {
        guard let id = cachedSpecialistInfo?.id else { return nil }
        
        let email = mailFieldText.nilOrString()
        let firstName = nameFieldText.nilOrString()
        let lastName = surnameFieldText.nilOrString()
        let bio = bioFieldText.nilOrString()
        let about = descriptionText.nilOrString()
        let skillTags: String? = nil
        let photo: String? = nil
        let countryId = Country(rawValue: 1)!
        
        let specialistInfo = Specialist(id: id,
                                        email: email,
                                        firstName: firstName,
                                        lastName: lastName,
                                        bio: bio,
                                        about: about,
                                        skillTags: skillTags,
                                        photo: photo,
                                        countryId: countryId)
        return await specialistInfoService.updateSpecialistInfo(specialist: specialistInfo)
    }
    
    func resetUserInfo() {
        skillsFieldText  = String()
        tags             = []
        bioFieldText     = String()
        descriptionText  = cachedSpecialistInfo?.about ?? ""
        nameFieldText    = String()
        surnameFieldText = String()
        mailFieldText    = String()
        phoneFieldText   = String()
        country          = CountryModel(regionCode: cachedSpecialistInfo?.countryId.code ?? "RU")
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

    func load() async {
        let error = await specialistInfoService.loadSpecialistInfo()
        
        DispatchQueue.main.async {
            if let error = error {
                self.state = .failed(error)
            } else if let specialist = self.specialistInfoService.specialist {
                self.state = .loaded(specialist)
            }
        }
    }
}
