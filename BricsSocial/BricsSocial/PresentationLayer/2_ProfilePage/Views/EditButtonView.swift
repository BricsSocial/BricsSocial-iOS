//
//  EditButtonView.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 12.03.2023.
//

import SwiftUI

struct EditButtonView: View {
    
    @EnvironmentObject var viewModel: ProfilePageViewModel
    
    // State variables
    @State var isAlertPresented: Bool = false
    
    var body: some View {
        if viewModel.isEditing {
            changeButton
        } else {
            buttonsStack
        }
    }
    
    private var changeButton: some View {
        GeometryReader { geometry in
            HStack(alignment: .center) {
                
                Text("Save")
                    .foregroundColor(Color.white)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .padding(.vertical, 15)
                    .frame(maxWidth: geometry.size.width / 2)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundColor(Color.black)
                    )
                    .onTapGesture {
                        withAnimation {
                            if viewModel.isDataValid {
                                viewModel.saveUserInfo()
                                viewModel.isEditing.toggle()
                            } else {
                                isAlertPresented.toggle()
                            }
                        }
                    }
                    .alert(isPresented: $isAlertPresented) {
                        Alert(
                            title: Text("Error"),
                            message: Text("Invalid data!"),
                            dismissButton: .cancel()
                        )
                    }
                
                Text("Cancel")
                    .foregroundColor(Color.white)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .padding(.vertical, 15)
                    .frame(maxWidth: geometry.size.width / 2)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundColor(Color.black)
                    )
                    .onTapGesture {
                        withAnimation {
                            viewModel.isEditing.toggle()
                            viewModel.resetUserInfo()
                        }
                    }
            }
        }
    }
    
    private var buttonsStack: some View {
        GeometryReader { geometry in
            Text("Change")
                .foregroundColor(Color.white)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .padding(.vertical, 15)
                .frame(maxWidth: geometry.size.width)
                .background(
                    RoundedRectangle(cornerRadius: 14).foregroundColor(Color.black)
                )
                .onTapGesture {
                    withAnimation {
                        viewModel.isEditing.toggle()
                    }
                }
        }
    }
}
