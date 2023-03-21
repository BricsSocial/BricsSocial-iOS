//
//  MainPageView.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 11.03.2023.
//

import SwiftUI

struct MainPageView: View {
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Платформа поможет")
                        .font(.title)
                        .bold()
                    Divider()
                    
                    HStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(maxWidth: geometry.size.width / 2,
                                   idealHeight: 120)
                            .foregroundColor(.gray)
                            .shadow(color: .gray, radius: 2)
                        
                        Spacer(minLength: 20)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .frame(maxWidth: geometry.size.width / 2,
                                   idealHeight: 120)
                            .foregroundColor(.gray)
                            .shadow(color: .gray, radius: 2)
                    }
                    .frame(maxWidth: geometry.size.width, idealHeight: 120)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: geometry.size.width, idealHeight: 120)
                        .foregroundColor(.gray)
                        .shadow(color: .gray, radius: 2)
                    
                    Text("Как работает BRICS+")
                        .font(.title)
                        .bold()
                    Divider()
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: geometry.size.width, idealHeight: 90)
                        .foregroundColor(.gray)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: geometry.size.width, idealHeight: 90)
                        .foregroundColor(.gray)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: geometry.size.width, idealHeight: 90)
                        .foregroundColor(.gray)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: geometry.size.width, idealHeight: 90)
                        .foregroundColor(.gray)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
