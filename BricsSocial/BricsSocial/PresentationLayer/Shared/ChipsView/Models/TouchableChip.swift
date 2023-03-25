//
//  TouchableChip.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 25.03.2023.
//

import Foundation

struct TouchableChip: Identifiable {
    let id = UUID()
    var isSelected: Bool
    let titleKey: String
}
