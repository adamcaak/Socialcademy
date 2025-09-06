//
//  Comment.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 06/09/2025.
//

import Foundation

struct Comment: Identifiable, Equatable, Codable {
    var content: String
    var author: User
    var timestamp = Date()
    var id = UUID()
}

extension Comment {
    static let comment = Comment(content: "Comment Test Comment Test", author: User.testUser)
}
