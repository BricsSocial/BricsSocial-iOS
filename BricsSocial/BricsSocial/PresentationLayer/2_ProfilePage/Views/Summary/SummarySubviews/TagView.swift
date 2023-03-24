//
//  TagView.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 19.03.2023.
//

import SwiftUI

struct TagView: View {
    
    // Environment Variables
    @Namespace var animation
    
    // Models
    @Binding var viewModel: [Tag]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(getRows(), id: \.self) { tagsRow in
                    HStack(spacing: 6) {
                        ForEach(tagsRow) { tag in
                            rowView(tag: tag)
                        }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
            .frame(minHeight: 30)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .animation(.easeIn)
        }
    }
    
    // MARK: - Private
    
    private func getIndex(tag: Tag) -> Int {
        return viewModel.firstIndex { currentTag in
            return tag.id == currentTag.id
        } ?? 0
    }
    
    private func getRows() -> [[Tag]] {
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []
        
        var totalWidth: CGFloat = 0
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        
        viewModel.forEach { tag in
            totalWidth += tag.size + 40
            
            if totalWidth >= screenWidth {
                totalWidth = (!currentRow.isEmpty || rows.isEmpty ? (tag.size + 40) : 0)
                  
                rows.append(currentRow)
                currentRow.removeAll()
                currentRow.append(tag)
            } else {
                currentRow.append(tag)
            }
        }
        
        if !currentRow.isEmpty {
            rows.append(currentRow)
            currentRow.removeAll()
        }
        
        return rows
    }
    
    @ViewBuilder
    private func rowView(tag: Tag) -> some View {
        Text(tag.text)
            .font(.system(size: 16))
            .bold()
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(Capsule().fill(Color.black))
            .foregroundColor(Color.white)
            .lineLimit(1)
            .contentShape(.contextMenuPreview, Capsule())
            .contextMenu {
                Button("Delete \(tag.text)") {
                    viewModel.remove(at: getIndex(tag: tag))
                }
            }
            .matchedGeometryEffect(id: tag.id, in: animation)
    }
}
