//
//  RoundButtonViewModel.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

import SwiftUI

final class RoundButtonViewModel: ObservableObject {
    
    // Static Properties
    let iconName: String
    let foregroundColor: Color
    let backgroundColor: Color
    let disabledBackgroundColor: Color
    let iconSide: CGFloat
    let buttonSide: CGFloat
    let action: () -> Void
    
    // MARK: - Initialization
    
    init(iconName: String,
         foregroundColor: Color,
         backgroundColor: Color,
         disabledBackgroundColor: Color,
         iconSide: CGFloat,
         buttonSide: CGFloat,
         action: @escaping () -> Void) {
        self.iconName = iconName
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.disabledBackgroundColor = disabledBackgroundColor
        self.iconSide = iconSide
        self.buttonSide = buttonSide
        self.action = action
    }
}
