//
//  PostsViewModel.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 12/08/2025.
//

import Foundation

@MainActor
class PostsViewModel: ObservableObject {
    @Published var posts = [Post.testPost]
}
