//
//  MainTabView.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 21/08/2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            PostsList()
                .tabItem {
                    Label("Posts List", systemImage: "list.dash")
                }
            PostsList(viewModel: PostsViewModel(filter: .favorites))
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                    
                    
                    
                    
                    
                }
        }
    }
}

#Preview {
    MainTabView()
}
