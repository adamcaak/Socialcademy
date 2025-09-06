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
        
    }
    
    func create(_ comment: Comment) async throws {
        
    }
    
    func delete(_ comment: Comment) async throws {
        
    }
    
    private var commentsReference: CollectionReference {
        let postsReference = Firestore.firestore().collection("posts_v2")
        let document = postsReference.document(post.id.uuidString)
        return document.collection("comments")
    }
}
