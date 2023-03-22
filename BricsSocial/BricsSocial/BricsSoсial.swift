//
//  BricsScoialApp.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 11.03.2023.
//

import SwiftUI

@main
struct BricsScoial: App {
    var body: some Scene {
        WindowGroup {
            ProfilePageView(viewModel: ProfilePageViewModel(dataValidationHandler: RootAssembly.serviceAssembly.dataValidationHandler,
                                                            userDataHandler: RootAssembly.serviceAssembly.userDataHandler))
        }
    }
}
