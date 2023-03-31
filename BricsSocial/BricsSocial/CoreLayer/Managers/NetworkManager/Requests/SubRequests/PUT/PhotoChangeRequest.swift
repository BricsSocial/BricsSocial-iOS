//
//  PhotoChangeRequest.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 30.03.2023.
//

import Foundation
import UIKit

final class PhotoChangeRequest: BaseRequest {
    
    // Private
    private let specialistId: Int
    private let image: UIImage
    private let boundary: String
    
    // MARK: - Initialization
    
    init(specialistId: Int,
         image: UIImage,
         boundary: String) {
        self.specialistId = specialistId
        self.image = image
        self.boundary = boundary
    }

    // MARK: - BaseRequest
    
    override var query: String {
        return "/specialists/\(specialistId)/photo"
    }
    
    override var requestType: HTTPRequestMethod {
        return .PUT
    }
    
    override var httpBody: Data? {
        makeHttpBody()
    }
    
    // MARK: - Private
    
    private func makeDataFromImage(_ image: UIImage) -> (bytes: Data, `extension`: String, mimeType: String?) {
        var data: Data = Data()
        var `extension`: String = ".png"
        if let imageData = image.jpegData(compressionQuality: 1) {
            data = imageData
            `extension` = ".jpg"
        } else if let imageData = image.pngData() {
            data = imageData
            `extension` = ".png"
        }
        return (bytes: data, extension: `extension`, mimeType: data.mimeType)
    }
    
    private func makeHttpBody() -> Data {
        let (imgData, ext, mimeType) = makeDataFromImage(image)
        let fileName = "\(boundary)\(ext)"
        
        var data = Data()
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: \(mimeType ?? "image/png")\r\n\r\n".data(using: .utf8)!)
        data.append(imgData)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        return data
    }
}

extension Data {

    var mimeType: String? {
        var values = [UInt8](repeating: 0, count: 1)
        copyBytes(to: &values, count: 1)

        switch values[0] {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x49, 0x4D:
            return "image/tiff"
        default:
            return nil
        }
    }
}
