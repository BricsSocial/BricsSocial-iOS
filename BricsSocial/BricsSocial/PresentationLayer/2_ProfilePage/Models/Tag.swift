//
//  Tag.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

import Foundation
import SwiftUI

struct Tag: Identifiable, Hashable {
    var id = UUID().uuidString
    var text: String
    var size: CGFloat = 0
    
    static func makeTag(from title: String) -> Tag {
        let font = UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (title as NSString).size(withAttributes: attributes)
        
        return Tag(text: title, size: size.width)
    }
}
