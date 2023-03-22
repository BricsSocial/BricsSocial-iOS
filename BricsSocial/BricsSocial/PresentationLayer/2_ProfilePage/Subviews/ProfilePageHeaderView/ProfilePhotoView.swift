//
//  ProfilePhotoView.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 12.03.2023.
//

import SwiftUI

struct ProfilePhotoView: View {
    
    var body: some View {
        Image("BR")
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay(
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        Image(systemName: "plus")
                            .bold()
                            .foregroundColor(Color.white)
                            .frame(width: 30, height: 30)
                            .background(Circle().foregroundColor(Color.green))
                    }
                }
            )
    }
}

struct ProfilePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoView()
    }
}
