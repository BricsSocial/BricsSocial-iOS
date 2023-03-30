//
//  ProfilePageViewModel.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

import SwiftUI

final class ProfilePageViewModel: ObservableObject {
    
    // Dependencies
    private let dataValidationHandler: IDataValidationHandler
    private let inputTextFieldViewModelFactory: IInputTextFieldViewModelFactory
    private let profileImageHandler: IProfileImageHandler
    private let specialistInfoService: ISpecialistInfoService
    
    // Private
    private var cachedSpecialistInfo: Specialist? {
        specialistInfoService.specialist
    }
    
    // State variables
    @Published var isEditing: Bool = false
    @Published var state: LoadingState = .loading
    
    // Input Data
    @Published var profileImage: String?
    @Published var image: UIImage?

    // General Field Texts
    @Published var skillsFieldText : String  = String()
    @Published var tags            : [Tag]   = []
    
    @Published var bioFieldText    : String  = String()
    @Published var descriptionText : String  = String()
    
    // Summary Field Texts
    @Published var nameFieldText   : String  = String()
    @Published var surnameFieldText: String  = String()
    @Published var mailFieldText   : String  = String()
    @Published var country         : Country = .brasil
    
    // Computed Properties
    var addButtonViewModel: RoundButtonViewModel {
        inputTextFieldViewModelFactory.makeTagAddButtonViewModel(actions: self)
    }
    
    var isDataValid: Bool {
        var validationArray: [Bool] = []
        
        if !nameFieldText.isEmpty { validationArray.append(dataValidationHandler.validateNameOrSurname(rawValue: nameFieldText)) }
        if !surnameFieldText.isEmpty { validationArray.append(dataValidationHandler.validateNameOrSurname(rawValue: surnameFieldText)) }
        if !mailFieldText.isEmpty { validationArray.append(dataValidationHandler.validateEmail(rawEmail: mailFieldText)) }
        if !bioFieldText.isEmpty { validationArray.append(dataValidationHandler.validateBio(rawBio: bioFieldText)) }
        
        return validationArray.allSatisfy { $0 }
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
    
    func resetUserInfo() {
        skillsFieldText  = String()
        profileImage = cachedSpecialistInfo?.photo
        image = nil
        tags             = cachedSpecialistInfo?.skillTags?.split(separator: ",").map { Tag.makeTag(from: String($0)) } ?? []
        bioFieldText     = String()
        descriptionText  = cachedSpecialistInfo?.about ?? ""
        nameFieldText    = String()
        surnameFieldText = String()
        mailFieldText    = String()
        country          = cachedSpecialistInfo?.countryId ?? .brasil
    }
    
    func textFieldViewModel(_ type: InputTextViewType) -> InputTextFieldViewModel {
        inputTextFieldViewModelFactory.makeInputTextFieldViewModel(type)
    }
    
    // MARK: - Private
    
    private func makeSpecialistModel() -> Specialist? {
        guard let id = cachedSpecialistInfo?.id else { return nil }
        
        let email     = mailFieldText.nilIfEmpty()
        let firstName = nameFieldText.nilIfEmpty()
        let lastName  = surnameFieldText.nilIfEmpty()
        let bio       = bioFieldText.nilIfEmpty()
        let about     = descriptionText.nilIfEmpty()
        let skillTags = tags.map { $0.text }.joined(separator: ",")
        let countryId = country
        
        return Specialist(id: id,
                          email: email,
                          firstName: firstName,
                          lastName: lastName,
                          bio: bio,
                          about: about,
                          skillTags: skillTags,
                          photo: nil,
                          countryId: countryId)
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

// MARK: - LoadableObject

extension ProfilePageViewModel: LoadableObject {

    func load() async {
        let error = await specialistInfoService.loadSpecialistInfo()
        
        DispatchQueue.main.async { [weak self] in
            if let error = error {
                self?.state = .failed(error)
            } else {
                self?.state = .loaded
                self?.resetUserInfo()
            }
        }
    }
    
    func uploadPhoto(image: UIImage) async {
        let error = await profileImageHandler.uploadProfilePicture(specialistId: cachedSpecialistInfo?.id ?? 0, image: image)
    }
    
    func save() async -> NetworkError? {
        guard let specialistInfo = makeSpecialistModel() else { fatalError("Unexpected failure") }
        
        if let image = image { await uploadPhoto(image: image) }
        let error = await specialistInfoService.updateSpecialistInfo(specialist: specialistInfo)
        
        DispatchQueue.main.async { [weak self] in
            self?.resetUserInfo()
        }
        
        return error
    }
}

private extension String {
    func nilIfEmpty() -> String? {
        return self.isEmpty ? nil : self
    }
}
