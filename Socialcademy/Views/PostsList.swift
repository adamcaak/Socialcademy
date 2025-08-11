//
//  PostsList.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 11/08/2025.
//

import SwiftUI

struct PostsList: View {
    private var posts = [Post.testPost]
    var body: some View {
        NavigationView {
            List(posts) { post in
                Text(post.content)
            }
            .navigationTitle("Posts")
        }
    }
}

#Preview {
    PostsList()
}
