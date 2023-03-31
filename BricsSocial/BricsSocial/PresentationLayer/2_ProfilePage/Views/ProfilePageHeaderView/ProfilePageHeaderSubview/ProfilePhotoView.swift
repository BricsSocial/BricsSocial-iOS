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
        if let picked = viewModel.image {
            Image(uiImage: picked)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(overlay)
        } else {
            AsyncImage(url: URL(string: viewModel.profileImage ?? "")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else if phase.error == nil {
                    Image("DefaultAvatar")
                        .resizable()
                        .scaledToFill()
                } else {
                    ProgressView()
                }
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay(overlay)
        }
    }
    
    private var overlay: some View {
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
                                DispatchQueue.main.async { [self] in
                                    viewModel.image = image
                                }
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
    }
}
