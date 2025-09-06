//
//  CommentRowViewModel.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 06/09/2025.
//

import Foundation

@MainActor
@dynamicMemberLookup
class CommentRowViewModel: ObservableObject {
    @Published var comment: Comment
    
    subscript<T>(dynamicMember keyPath: KeyPath<Comment, T>) -> T {
        comment[keyPath: keyPath]
    }
    
    init(comment: Comment) {
        self.comment = comment
    }
}
