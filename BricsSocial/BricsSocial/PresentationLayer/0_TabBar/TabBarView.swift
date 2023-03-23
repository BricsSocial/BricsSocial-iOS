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
    
    var body: some View {
        TabView {
            MainPageView()
                .tabItem {
                    Label(String.mainPageName, systemImage: String.mainPageIconName)
                }
            SearchPageView()
                .tabItem {
                    Label(String.searchPageName, systemImage: String.searchPageIconName)
                }
//            ContentView()
//                .tabItem {
//                    Label(String.notificationPageName, systemImage: String.notificationPageIconName)
//                }
//            ProfilePageView()
//                .tabItem {
//                    Label(String.profilePageName, systemImage: String.profilePageIconName)
//                }
//                .padding(.bottom)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
