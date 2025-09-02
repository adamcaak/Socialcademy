//
//  MainTabView.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 21/08/2025.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var factory: ViewModelFactory
    var body: some View {
        TabView {
            PostsList(viewModel: factory.makePostsViewModel())
                .tabItem {
                    Label("Posts List", systemImage: "list.dash")
                }
            PostsList(viewModel: factory.makePostsViewModel(filter: .favorites))
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(ViewModelFactory.preview)
    }
}
