//
//  PostsList.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 11/08/2025.
//

import SwiftUI

struct PostsList: View {
    private var posts = [Post.testPost]
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List(posts) { post in
                PostRow(post: post)
            }
            .navigationTitle("Posts")
            .searchable(text: $searchText)
        }
    }
}

#Preview {
    PostsList()
}
