//
//  ProfileImageHandler.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 23.03.2023.
//

import SwiftUI

private extension String {
    static let imageName: String = "profileImage"
    static let folderName: String = "resources"
}

protocol IProfileImageHandler {
    var image: UIImage? { get }
    func provideProfileImage()
    func setProfileImage(image: UIImage)
    func uploadProfilePicture(specialistId: Int, image: UIImage) async -> String?
}

final class ProfileImageHandler: IProfileImageHandler {
    
    // Profile picture
    var image: UIImage?
    
    // Dependencies
    private var localFileManager: ILocalFileManager
    private var networkHandler: INetworkHandler
    
    // MARK: - Initialization
    
    init(localFileManager: ILocalFileManager,
         networkHandler: INetworkHandler) {
        self.localFileManager = localFileManager
        self.networkHandler = networkHandler
    }
    
    func uploadProfilePicture(specialistId: Int, image: UIImage) async -> String? {
        let boundary = UUID().uuidString
        let request = PhotoChangeRequest(specialistId: specialistId, image: image, boundary: boundary)
        request.headers["content-type"] = "multipart/form-data; boundary=\(boundary)"
        
        switch await networkHandler.send(request: request, type: Photo.self) {
        case .success(let model):
            return model.fileUrl
        case .failure:
            return nil
        }
    }

    func provideProfileImage() {
        image = localFileManager.getImage(imageName: String.imageName, folderName: String.folderName)
    }
    
    func setProfileImage(image: UIImage) {
        guard localFileManager.saveImage(image: image, imageName: String.imageName, folderName: String.folderName) else { return }
        self.image = image
    }
}
