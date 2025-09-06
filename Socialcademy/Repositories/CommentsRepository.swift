//
//  CommentsRepository.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 06/09/2025.
//

import Foundation
import FirebaseStorage

struct CommentsRepository: CommentsRepositoryProtocol {
    let user: User
    let post: Post
    
    func fetchComments() async throws -> [Comment] {
        
    }
    
    func create(_ comment: Comment) async throws {
        
    }
    
    func delete(_ comment: Comment) async throws {
        
    }
}

