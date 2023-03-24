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
}

final class ProfileImageHandler: IProfileImageHandler {
    
    // Profile picture
    var image: UIImage?
    
    // Dependencies
    private var localFileManager: ILocalFileManager
    
    // MARK: - Initialization
    
    init(localFileManager: ILocalFileManager) {
        self.localFileManager = localFileManager
    }

    func provideProfileImage() {
        image = localFileManager.getImage(imageName: String.imageName, folderName: String.folderName)
    }
    
    func setProfileImage(image: UIImage) {
        guard localFileManager.saveImage(image: image, imageName: String.imageName, folderName: String.folderName) else { return }
        self.image = image
    }
}
