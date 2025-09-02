//
//  ViewModelFactory.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 02/09/2025.
//

import Foundation

@MainActor
class ViewModelFactory: ObservableObject {
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func makePostsViewModel(filter: PostsViewModel.Filter = .all) -> PostsViewModel {
        return PostsViewModel(postsRepository: PostsRepository(user: user), filter: filter)
    }
}
