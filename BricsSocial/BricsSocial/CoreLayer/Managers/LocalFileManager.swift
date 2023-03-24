//
//  LocalFileManager.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 23.03.2023.
//

import SwiftUI
import Foundation

protocol ILocalFileManager {
    func saveImage(image: UIImage, imageName: String, folderName: String) -> Bool
    func getImage(imageName: String, folderName: String) -> UIImage?
}

final class LocalFileManager: ILocalFileManager {
    
    // MARK: - ILocalFileManager

    func saveImage(image: UIImage, imageName: String, folderName: String) -> Bool {
        
        createFolderIfNeeded(folderName: folderName)
        
        guard
            let data = image.pngData(),
            let url = makeURLForImage(imageName, folderName: folderName)
        else { return false }
        
        do {
            try data.write(to: url)
        } catch let error {
            RootAssembly.coreAssembly.logger.log(.error, arguments: "\(#function)", error.localizedDescription)
            return false
        }
        
        return true
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = makeURLForImage(imageName, folderName: folderName),
              FileManager.default.fileExists(atPath:  url.path)
        else { return nil }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    // MARK: - Private
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = makeURLForFolder(folderName),
              !FileManager.default.fileExists(atPath:  url.path)
        else { return }
        
        do {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        } catch let error {
            RootAssembly.coreAssembly.logger.log(.error, arguments: "\(#function)", error.localizedDescription)
        }
    }
     
    private func makeURLForFolder(_ folderName: String) -> URL? {
        guard let url =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return url.appendingPathComponent(folderName)
    }
    
    private func makeURLForImage(_ imageName: String, folderName: String) -> URL? {
        guard let folderURL = makeURLForFolder(folderName) else { return nil }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
