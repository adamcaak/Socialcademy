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
        List(posts) { post in
            Text(post.content)
        }
    }
}

#Preview {
    PostsList()
}
