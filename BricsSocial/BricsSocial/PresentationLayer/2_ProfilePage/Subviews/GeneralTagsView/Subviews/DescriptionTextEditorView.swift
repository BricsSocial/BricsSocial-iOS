//
//  DescriptionTextEditorView.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 23.03.2023.
//

import SwiftUI

private extension Color {
    static let lightGrayColor = Color("LightGrayColor")
}

struct DescriptionTextEditorView: View {
    
    @Binding var descriptionText: String
    @Binding var isEditable: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Description")
                .font(.system(size: 15))
                .bold()
                .frame(height: 10)
                .background(Color.white.frame(height: 20))
                .padding(.init(top: 3, leading: 50, bottom: -25, trailing: 10))
                .zIndex(1)
            
                textEditor
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color.lightGrayColor, lineWidth: 0.5)
                        .zIndex(0)
                )
                .disabled(!isEditable)
        }
    }
    
    private var textEditor: some View {
        TextEditor(text: $descriptionText)
            .multilineTextAlignment(.leading)
            .font(Font.body.weight(.medium))
            .foregroundColor(Color.lightGrayColor)
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
}

struct DescriptionTextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionTextEditorView(descriptionText: Binding.constant("FFFF"), isEditable: Binding.constant(true))
    }
}
