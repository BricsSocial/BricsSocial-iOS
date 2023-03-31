//
//  BricsScoialApp.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 11.03.2023.
//

import SwiftUI

@main
struct BricsScoial: App {
   
    @State var isLogged: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isLogged {
                TabBarView()
            } else {
                SignInView(isLoggedIn: $isLogged)
            }
        }
    }
}
