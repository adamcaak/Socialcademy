//
//  PostsRepository.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 14/08/2025.
//

import Foundation
import FirebaseFirestore

struct PostsRepository: PostsRepositoryProtocol {
    let postsReference = Firestore.firestore().collection("posts_v2")
    let favoritesReference = Firestore.firestore().collection("favorites")
    var user: User
    
    func create(_ post: Post) async throws {
        let document = postsReference.document(post.id.uuidString)
        try await document.setData(from: post)
    }
    
    func fetchAllPosts() async throws -> [Post] {
        let favorites = try await fetchFavorites()
        guard !favorites.isEmpty else { return [] }
        let posts = try await postsReference
            .whereField("id", in: favorites.map(\.uuidString))
            .order(by: "timestamp", descending: true)
            .getDocuments(as: Post.self)
    }
    
    func fetchFavoritePosts() async throws -> [Post] {
        return try await fetchPosts(from: postsReference.whereField("isFavorite", isEqualTo: true))
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
        precondition(canDelete(post))
        let document = postsReference.document(post.id.uuidString)
        try await document.delete()
    }
    
    func fetchFavorites() async throws -> [Post.ID] {
        return try await favoritesReference
            .whereField("userID", isEqualTo: user.id)
            .getDocuments(as: Favorite.self)
            .map(\.postID)
    }
    
    
    func unFavorite(_ post: Post) async throws {
        let favorite = Favorite(postID: post.id, userID: user.id)
        let document = favoritesReference.document(favorite.id)
        try await document.delete()
    }
    
    func fetchPosts(from query: Query) async throws -> [Post] {
        let (posts, favorites) = try await (
            query.order(by: "timestamp", descending: true).getDocuments(as: Post.self),
            fetchFavorites()
        )
        return posts.map { post in
            post.setting(\.isFavorite, to: favorites.contains(post.id))
        }
    }
}

protocol PostsRepositoryProtocol {
    func fetchFavoritePosts() async throws -> [Post]
    func fetchAllPosts() async throws -> [Post]
    func create(_ post: Post) async throws
    func delete(_ post: Post) async throws
    func favorite(_ post: Post) async throws
    func unFavorite(_ post: Post) async throws
    func fetchPosts(by author: User) async throws -> [Post]
    var user: User { get }
}

#if DEBUG
struct PostsRepositoryStub: PostsRepositoryProtocol {
    let state: Loadable<[Post]>
    var user = User.testUser
    
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
    
    func fetchPosts(by author: User) async throws -> [Post] {
        return try await state.simulate()
    }
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

extension PostsRepositoryProtocol {
    func canDelete(_ post: Post) -> Bool {
        post.author.id == user.id
    }
}

struct Favorite: Identifiable, Codable {
    var id: String {
        postID.uuidString + "-" + userID
    }
    
    let postID: Post.ID
    let userID: User.ID
}

private extension Post {
    func setting<T>(_ property: WritableKeyPath<Post, T>, to newValue: T) -> Post {
        var post = self
        post[keyPath: property] = newValue
        return post
    }
}

private extension Query {
    func getDocuments<T: Decodable>(as type: T.Type) async throws -> [T] {
        let snapshot = try await getDocuments()
        return snapshot.documents.compactMap { document in
            try! document.data(as: type)
        }
    }
}
