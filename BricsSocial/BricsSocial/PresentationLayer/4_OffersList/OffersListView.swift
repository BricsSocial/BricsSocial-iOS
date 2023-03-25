//
//  OffersListView.swift
//  BricsSocial
//
//  Created by Samarenko Andrey on 24.03.2023.
//

import SwiftUI

struct SectionHeaderView: View {
    
    var color: Color
    var iconName: String
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(color)
            Text(text)
                .multilineTextAlignment(.leading)
                .font(.footnote)
                .foregroundColor(Color.gray)
        }
        .padding(.leading, -15)
    }
}

struct CompanyRowView: View {
    
    var body: some View {
        HStack {
            Image("RU")
                .resizable()
                .clipShape(Circle())
                .frame(width: 25, height: 25)
            Text("Tinkoff")
                .bold()
        }
    }
}

struct OffersListView: View {
    @State var chips: [TouchableChip] = [.init(isSelected: false,
                                               titleKey: "Pending")]
    private var headerView: some View {
        VStack(alignment: .leading) {
            Text("Offers")
                .font(.largeTitle).bold()
            ChipsView(categories: $chips)
        }
        .frame(maxWidth: .infinity)
    }
    var body: some View {
        List {
            Section(header: headerView)
                 {}
                .headerProminence(.increased)
                .padding(.bottom, -20)
                .padding(.leading, -15)
            
            Section(header: SectionHeaderView(color: .red,
                                              iconName: "multiply.circle",
                                              text: "Rejected")) {
                CompanyRowView()
            }
            
            Section(header: SectionHeaderView(color: .yellow,
                                              iconName: "magnifyingglass.circle",
                                              text: "Pending")) {
                Text("Tinkoff")
            }
            
            Section(header: SectionHeaderView(color: .green,
                                              iconName: "checkmark.circle",
                                              text: "Accepted")) {
                Text("Tinkoff")
            }
        }
        .refreshable {
            do {
                // Sleep for 2 seconds
                try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            } catch {}
        }
    }
}

struct OffersListView_Previews: PreviewProvider {
    static var previews: some View {
        OffersListView()
    }
}
