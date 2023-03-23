//
//  ProfilePhotoView.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 12.03.2023.
//

import PhotosUI
import SwiftUI

struct ProfilePhotoView: View {
    
    @ObservedObject var viewModel: ProfilePageViewModel
    
    @State var selectedItems: [PhotosPickerItem] = []
    
    var body: some View {
        Image(uiImage: (viewModel.profileImage ?? UIImage()))
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay(
                    HStack {
                        Spacer()
                        VStack {
                            Spacer()
                            if viewModel.isEditing {
                                PhotosPicker(selection: $selectedItems,
                                             maxSelectionCount: 1,
                                             matching: .images,
                                             label: {
                                    Image(systemName: "plus")
                                        .bold()
                                        .foregroundColor(Color.white)
                                        .frame(width: 30, height: 30)
                                        .background(Circle().foregroundColor(Color.green))
                                })
                                .onChange(of: selectedItems) { _ in
                                    guard let photo = selectedItems.first else { return }
                                    photo.loadTransferable(type: Data.self) { result in
                                        switch result {
                                        case .success(let data):
                                            guard let data = data,
                                                  let image = UIImage(data: data)
                                            else { return }
                                            viewModel.saveProfileView(image)
                                        case .failure(let error):
                                            RootAssembly.coreAssembly.logger.log(.error, arguments: "failed to load profile picture",
                                                                                 error.localizedDescription)
                                        }
                                    }
                                }
                            } else {
                                EmptyView()
                            }
                        }
                    }
            )
            .onAppear {
                viewModel.loadProfileView()
            }
            .animation(.easeInOut, value: viewModel.profileImage)
    }
}

