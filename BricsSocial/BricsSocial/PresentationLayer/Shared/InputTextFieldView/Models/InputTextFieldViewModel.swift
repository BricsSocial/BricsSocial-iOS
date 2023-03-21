//
//  InputTextFieldViewModel.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

import SwiftUI

final class InputTextFieldViewModel {
    
    // Static Properties
    let textFieldName: String
    var textFieldContent: String
    let iconName: String
    let textContentType: UITextContentType
    let validation: (String) -> Bool
    
    // MARK: - Initialization
    
    init(textFieldName: String,
         textFieldContent: String,
         iconName: String,
         textContentType: UITextContentType,
         validation: @escaping (String) -> Bool = { _ in return true }) {
        self.textFieldName = textFieldName
        self.textFieldContent = textFieldContent
        self.iconName = iconName
        self.textContentType = textContentType
        self.validation = validation
    }
}
