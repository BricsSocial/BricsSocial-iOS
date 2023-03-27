//
//  Company.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 26.03.2023.
//

import Foundation

struct Company: Decodable {
    let id: Int
    let name: String?
    let description: String?
    let logo: String?
}
