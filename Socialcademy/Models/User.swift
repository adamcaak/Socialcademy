//
//  User.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 01/09/2025.
//

import Foundation

struct User: Identifiable, Equatable, Codable {
    var id: String
    var name: String
    var imageURL: URL?
}

extension User {
    static let testUser = User(id: "", name: "Jammie Harris", imageURL: URL(string:"https://source.unsplash.com/lw9LrnpUmWw/480x480"))
}
