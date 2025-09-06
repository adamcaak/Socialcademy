//
//  CommentsRepository.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 06/09/2025.
//

import Foundation
import FirebaseFirestore

struct CommentsRepository: CommentsRepositoryProtocol {
    let user: User
    let post: Post
    
    func fetchComments() async throws -> [Comment] {
        return try await commentsReference
            .order(by: "timeStamp", descending: true)
            .getDocuments(as: Comment.self)
    }
    
    func create(_ comment: Comment) async throws {
        let document = commentsReference.document(comment.id.uuidString)
        try await document.setData(from: document)
    }
    
    func delete(_ comment: Comment) async throws {
        precondition(canDelete(comment))
        let document = commentsReference.document(comment.id.uuidString)
        try await document.delete()
    }
    
    private var commentsReference: CollectionReference {
        let postsReference = Firestore.firestore().collection("posts_v2")
        let document = postsReference.document(post.id.uuidString)
        return document.collection("comments")
    }
}
