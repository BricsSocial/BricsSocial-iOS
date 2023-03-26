//
//  CountryPickerView.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 11.03.2023.
//

import SwiftUI
import Foundation

private extension Color {
    static let lightGrayColor = Color("LightGrayColor")
}

struct CountryPickerView: View {
    
    // View Model
    @Binding var viewModel: CountryModel?
    
    // Binding Variables
    @Binding var isEditable: Bool
    
    // Private
    private let dropDownList:[CountryModel] = CountryModel.allCountries
    
    var body: some View {
        Menu {
            ForEach(dropDownList, id: \.self) { client in
                Button(action: {
                    viewModel = client
                }) {
                    HStack {
                        Text(client.name + " " + "(+\(client.phoneCode))")
                            .foregroundColor(.black)
                        Spacer()
                        Image(client.flag)
                    }
                }
            }
 
        } label: {
            VStack(alignment: .leading) {
                Text("Country")
                    .font(.system(size: 15))
                    .bold()
                    .frame(height: 10)
                    .foregroundColor(Color.black)
                    .background(Color.white.frame(height: 20))
                    .padding(.init(top: 3, leading: 50, bottom: -25, trailing: 10))
                    .zIndex(1)
                
                HStack {
                    Image(viewModel?.flag ?? "")
                        .resizable()
                        .clipShape(Circle())
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 15)
                       
                    Text((viewModel?.name ?? "") + " " + (viewModel?.phoneCode ?? ""))
                        .font(Font.body.weight(.medium))
                        .foregroundColor(Color.lightGrayColor)
                    
                    Spacer()
                    Image(systemName: "chevron.down")
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.lightGrayColor)
                }
                .padding(.all, 15)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color.lightGrayColor, lineWidth: 0.3)
                )
            }
        }
        .disabled(!isEditable)
    }
}
