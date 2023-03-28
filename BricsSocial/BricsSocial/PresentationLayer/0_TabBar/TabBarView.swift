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
    
    static let searchPageName = "Search"
    static let searchPageIconName = "magnifyingglass"
    
    static let notificationPageName = "Replies"
    static let notificationPageIconName = "message.badge"
    
    static let profilePageName = "Profile"
    static let profilePageIconName = "person.fill"
}

struct TabBarView: View {
    @State var currentTab = 0
    var body: some View {
        TabView(selection: $currentTab) {
            AsyncSearchPageView()
                .tabItem {
                    Label(String.searchPageName, systemImage: String.searchPageIconName)
                }
                .tag(0)
            AsyncRepliesPageView()
                .tabItem {
                    Label(String.notificationPageName,
                          systemImage: String.notificationPageIconName)
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
