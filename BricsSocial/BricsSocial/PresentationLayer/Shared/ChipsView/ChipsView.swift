//
//  ChipsView.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 25.03.2023.
//

import SwiftUI

struct ChipsView: View {
    @Binding var categories: [TouchableChip]
    
    var body: some View {
        List {
            HStack {
                ForEach(0..<categories.count, id: \.self) {index in
                    Button(action: { categories[index].isSelected.toggle() },
                           label: {
                        HStack {
                            if categories[index].isSelected {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .animation(.easeIn)
                            } else {
                                Image(systemName: "circle")
                                    .foregroundColor(.gray)
                                    .animation(.easeOut)
                            }
                            Text(categories[index].titleKey).font(.title3).lineLimit(1)
                        }.padding(.all, 10)
                            .foregroundColor(categories[index].isSelected ? Color.white : Color.gray)
                            .background(categories[index].isSelected ? Color.black : Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                        
                    })
                }
            }
        }
    }
}

struct ChipsView_Preview: PreviewProvider {
    
    static var previews: some View {
        ChipsView(categories: Binding.constant([
            TouchableChip.init(isSelected: true, titleKey: "Pending"),
            TouchableChip.init(isSelected: true, titleKey: "Rejected"),
            TouchableChip.init(isSelected: true, titleKey: "Approved"),
        ]))
    }
}
