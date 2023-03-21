//
//  RoundButtonView.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

import SwiftUI

struct RoundButtonView: View {
    
    // Models
    @ObservedObject var viewModel: RoundButtonViewModel
    
    // States
    var isDisabled: Bool
    
    var body: some View {
        Button(action: {
            guard !isDisabled else { return }
            viewModel.action()
        },
               label: {
            Image(systemName: viewModel.iconName)
                .resizable()
                .bold()
                .foregroundColor(viewModel.foregroundColor)
                .frame(width: viewModel.iconSide, height: viewModel.iconSide)
                .background(Circle().fill(isDisabled
                                          ? viewModel.disabledBackgroundColor
                                          : viewModel.backgroundColor)
                    .frame(width: viewModel.buttonSide, height: viewModel.buttonSide))
        }).disabled(isDisabled)
    }
}
