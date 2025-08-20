//
//  PostsRepository.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 14/08/2025.
//

import Foundation
import FirebaseFirestore

struct PostsRepository: PostsRepositoryProtocol {
    let postsReference = Firestore.firestore().collection("posts_v1")
    
    func create(_ post: Post) async throws {
        let document = postsReference.document(post.id.uuidString)
        try await document.setData(from: post)
    }
    
    func fetchAllPosts() async throws -> [Post] {
        let snapshot = try await postsReference
            .order(by: "timeStamp", descending: true)
            .getDocuments()
        return snapshot.documents.compactMap { document in
            try! document.data(as: Post.self)
        }
    }
    
    func fetchFavoritePosts() async throws -> [Post] {
        let query = postsReference
            .order(by: "timeStamp", descending: true)
            .whereField("isFavorite", isEqualTo: true)
        let snapshot = try await query.getDocuments()
        let post = snapshot.documents.compactMap { document in
            try! document.data(as: Post.self)
        }
        return post
    }
    
    private func fetchPosts(from query: Query) async throws -> [Post] {
        let snapshot = try await query
            .order(by: "timeStamp", descending: true)
            .getDocuments()
        return snapshot.documents.compactMap { document in
            try! document.data(as: Post.self)
        }
    }
    
    func delete(_ post: Post) async throws {
        let document = postsReference.document(post.id.uuidString)
        try await document.delete()
    }
    
    func favorite(_ post: Post) async throws {
        let document = postsReference.document(post.id.uuidString)
        try await document.setData(["isFavorite": true], merge: true)
    }
    
    func unFavorite(_ post: Post) async throws {
        let document = postsReference.document(post.id.uuidString)
        try await document.setData(["isFavorite": false], merge: true)
    }
}

protocol PostsRepositoryProtocol {
    func fetchFavoritePosts() async throws -> [Post]
    func fetchAllPosts() async throws -> [Post]
    func create(_ post: Post) async throws
    func delete(_ post: Post) async throws
    func favorite(_ post: Post) async throws
    func unFavorite(_ post: Post) async throws
}

#if DEBUG
struct PostsRepositoryStub: PostsRepositoryProtocol {
    let state: Loadable<[Post]>
    
    func fetchAllPosts() async throws -> [Post] {
        return []
    }
    
    func fetchFavoritePosts() async throws -> [Post] {
        return []
    }
    
    func create(_ post: Post) async throws {}
    func delete(_ post: Post) async throws {}
    func favorite(_ post: Post) async throws {}
    func unFavorite(_ post: Post) async throws {}
}
#endif

private extension DocumentReference {
    func setData<T: Encodable>(from value: T) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            // Method only throws if there’s an encoding error, which indicates a problem with our model.
            // We handled this with a force try, while all other errors are passed to the completion handler.
            try! setData(from: value) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume()
            }
        }
    }
}
