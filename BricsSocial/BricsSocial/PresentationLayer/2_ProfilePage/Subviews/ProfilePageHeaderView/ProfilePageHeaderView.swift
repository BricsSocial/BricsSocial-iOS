//
//  ProfilePageHeaderView.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

import SwiftUI

struct ProfilePageHeaderView: View {
    
    @ObservedObject var viewModel: ProfilePageViewModel
    
    var body: some View {
        HStack {
            ProfilePhotoView(viewModel: viewModel)
            VStack(alignment: .leading, spacing: 5) {
                Text("\(viewModel.infoViewModel.nameInputTextViewModel.textFieldContent) \(viewModel.infoViewModel.surnameInputTextViewModel.textFieldContent)")
                    .font(.system(size: 20, weight: .black, design: .rounded))
                Text(viewModel.tagsViewModel.bioFieldViewModel.textFieldContent)
                    .font(.subheadline)
            }
        }
    }
}
