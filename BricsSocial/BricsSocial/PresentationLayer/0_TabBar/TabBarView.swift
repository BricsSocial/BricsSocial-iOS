//
//  TabBarView.swift
//  BricsScoial
//
//  Created by Samarenko Andrey on 11.03.2023.
//

import SwiftUI

private extension String {
    static let mainPageName = "Главная"
    static let mainPageIconName = "house"
    
    static let searchPageName = "Поиск"
    static let searchPageIconName = "magnifyingglass"
    
    static let notificationPageName = "Уведомления"
    static let notificationPageIconName = "message.badge"
    
    static let profilePageName = "Профиль"
    static let profilePageIconName = "person.fill"
}

struct TabBarView: View {
    @State var currentTab = 0
    var body: some View {
        TabView(selection: $currentTab) {
            MainPageView()
                .tabItem {
                    Label(String.mainPageName, systemImage: String.mainPageIconName)
                }
                .tag(0)
            SearchPageView()
                .tabItem {
                    Label(String.searchPageName, systemImage: String.searchPageIconName)
                }
                .tag(1)
            AsyncProfilePageView()
                .tabItem {
                    Label(String.profilePageName, systemImage: String.profilePageIconName)
                }
                .tag(2)
                .padding(.bottom)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
